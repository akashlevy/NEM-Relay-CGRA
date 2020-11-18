#include <stdlib.h>
#include <iostream>
#include <map>
#include <memory>
#include <vector>
#include "verilated.h"
#include "Vmemory_core_unq1.h"

namespace {

template<typename Module>
class VerilatorModuleWrapper {
 public:
  VerilatorModuleWrapper() : underlying_(new Module) {}

  const Module& underlying() const { return *underlying_; }
  // Caller should not take ownership of returned pointer.
  Module* mutable_underlying() { return underlying_.get(); }

 protected:
  std::unique_ptr<Module> underlying_;
};

class MemoryCore : public VerilatorModuleWrapper<Vmemory_core_unq1> {
 public:
  using VerilatorModuleWrapper<Vmemory_core_unq1>::underlying_;

  enum Mode {
    LINE_BUFFER = 0,
    FIFO = 1,
    SRAM = 2
  };
  struct Config {
    Mode mode = LINE_BUFFER;
    bool tile_enable = true;
    int depth = 8;
  };

  MemoryCore(Config config)
      : VerilatorModuleWrapper<Vmemory_core_unq1>() {
    Reset();
    Configure(config);
  }

  void LowerClock() {
    underlying_->clk_in = 0;
    Evaluate();
  }

  void RaiseClock() {
    underlying_->clk_in = 1;
    Evaluate();
  }

  void StepClock() {
    LowerClock();
    RaiseClock();
  }

  void Reset() {
    underlying_->reset = 0;
    LowerClock();
    underlying_->reset = 1;
    RaiseClock();
    underlying_->reset = 0;
    StepClock();
  }

  void Write(int addr, int data) {
    LowerClock();
    underlying_->wen_in = 1;
    underlying_->addr_in = addr;
    underlying_->data_in = data;
    RaiseClock();
  }

  int Read(int addr) {
    LowerClock();
    underlying_->wen_in = 0;
    underlying_->addr_in = addr;
    underlying_->ren_in = 1;
    RaiseClock();
    // Stalls for SRAM read delay.
    for (int delay = 0; delay < kReadDelay; delay++) {
      StepClock();
    }
    return underlying_->data_out;
  }

  bool VerifyConfig() const {
    // read_data is a debug field in the memory core. It essentially is a
    // read-out of the config_mem register.
    return underlying_->read_data == underlying_->config_data;
  }

  auto MemorySize() const { return kMemorySize; }
  auto ReadDelay() const { return kReadDelay; }

 private:
  void Evaluate() { underlying_->eval(); }
  void Configure(Config config) {
    LowerClock();
    underlying_->config_en = true;
    // The logic used in memory core is as follows:
    //
    //   if config_en == 1 and config_addr[31:24] == 0
    //       config_mem <-- config_data
    //
    // In particular, the relevant sub-fields of config_mem are as follows:
    //   [1:0] specifies the mode
    //   [2] is tile enable
    //   [15:3] specifies the depth
    underlying_->config_addr = 0x0;
    underlying_->config_data = 0x0;
    
    underlying_->config_data |= (((uint32_t)config.mode) << 0);
    underlying_->config_data |= (((uint32_t)config.tile_enable) << 2);
    underlying_->config_data |= (((uint32_t)config.depth) << 3);
    RaiseClock();
    underlying_->config_en = false;  // disable configuration after.
  }

  // Some constants about the memory.
  const int kMemorySize = 1024;
  const int kReadDelay = 1;  // number of cycles of read delay.
};

bool TestSramPhases() {
  const int kDepth = 100;
  const int kNumWrites = 80;
  MemoryCore memory({ MemoryCore::SRAM, true, kDepth });
  // Set clk_en to high.
  memory.mutable_underlying()->clk_en = 1;
  if (not memory.VerifyConfig()) {
    std::cout << "Configuration failed. Exiting." << std::endl;
    return 1;
  }
  memory.StepClock();

  // Perform a sequence of writes of random data to random addresses. Proceed to
  // read out the addresses (in arbitrary order) and verify that the writes
  // succeeded.
  std::map<int, int> reference;
  const int memory_size = memory.MemorySize();
  for (int i = 0; i < kNumWrites; i++) {
    int addr = rand() % memory_size;
    while (reference.find(addr) != reference.end()) {
      addr = rand() % memory_size;
    }
    const int data_in = rand() % (1 << 10);
    reference[addr] = data_in;
    memory.Write(addr, data_in);
  }
  for (const auto& entry : reference) {
    const auto data_out = (int)memory.Read(entry.first);
    assert(entry.second == data_out);
  }
  return true;
}

bool TestSramInterleaved() {
  const int kDepth = 100;
  const int kNumWrites = 80;
  MemoryCore memory({MemoryCore::SRAM, true, kDepth });
  // Set clk_en to high.
  memory.mutable_underlying()->clk_en = 1;
  if (not memory.VerifyConfig()) {
    std::cout << "Configuration failed. Exiting." << std::endl;
    return 1;
  }
  memory.StepClock();

  // Perform a sequence of interleaved reads and writes, where we uniformly (at
  // random) select whether to do a read or a write. Reads and write cycles are
  // all disjoint. On reads we verify that the most recent write succeeded, or
  // that the value is zero if the address has not been written to.
  std::map<int, int> reference;
  const int memory_size = memory.MemorySize();
  for (int i = 0; i < kNumWrites; i++) {
    const int write = rand() % 2;
    const int addr = rand() % memory_size;
    if (write) {
      const int data_in = rand() % (1 << 10);
      reference[addr] = data_in;
      memory.Write(addr, data_in);
    } else {
      auto it = reference.find(addr);
      const int expected_data = (it == reference.end()) ? 0 : it->second;
      const auto data_out = (int)memory.Read(addr);
      assert(expected_data == data_out);
    }
  }
  return true;
}

bool TestLbBasic() {
  const int kNumWrites = 100;
  const int kDepth = 18;
  MemoryCore memory({ MemoryCore::LINE_BUFFER, true, kDepth });
  // Set clk_en to high.
  memory.mutable_underlying()->clk_en = 1;
  if (not memory.VerifyConfig()) {
    std::cout << "Configuration failed. Exiting." << std::endl;
    return 1;
  }
  memory.StepClock();

  // Write a series of random values to the line buffer and verify by performing
  // reads (delayed by the depth + read delay).
  // std::vector<int> reference;
  // const int total_read_delay = kDepth /*+ memory.ReadDelay()*/;
  // const int total_ticks = kNumWrites + total_read_delay;
  // // NOTE(raj): Functionally, in line buffer mode, ren_in signal should not
  // // affect the behavior of the memory. However, in this basic test we always
  // // enable it.
  memory.mutable_underlying()->ren_in = 0;
  memory.mutable_underlying()->flush = 0;
  // int reference_index = 0;
  // for (int tick = 0; tick < total_ticks + 20; tick++) {
  //   memory.LowerClock();
  //   if (tick < kNumWrites || tick > kNumWrites + 5) {
  //     memory.mutable_underlying()->wen_in = 1;
  //     const int data_in = rand() % (1 << 10);
  //     memory.mutable_underlying()->data_in = data_in;
  //     reference.push_back(data_in);
  //     if (tick > kDepth) reference_index++;
  //   } else {
  //     memory.mutable_underlying()->wen_in = 0;
  //   }
  //   memory.RaiseClock();
  //   const int data_out = memory.mutable_underlying()->data_out;
  //   //if (tick >= total_read_delay) {
  //   std::cout << "tick = " << tick  << ", data_out = " << data_out << ", expected_data = " << reference[reference_index] << ", valid_out = " << (int)(memory.mutable_underlying()->valid_out) << ", wen_in = " << (int)memory.mutable_underlying()->wen_in << std::endl;
  //   //}
  // }

  const int kNumTicks = 200;
  int num_writes = 0;
  std::vector<int> reference;
  int reference_index = -1;
  srand(10);
  for (int tick = 0; tick < kNumTicks; tick++) {
    const bool do_write = rand() % 2;
    {
      const auto data_out = memory.underlying().data_out;
      const auto valid_out = (int)memory.underlying().valid_out;
      std::cout << "CLOCK LO tick = " << tick << ", do_write = " << do_write << ", valid_out = " << valid_out << ", data_out = " << data_out << /*", expected data out = " << reference[reference_index] << */", reference_index = " << reference_index << ", num_writes = " << num_writes << std::endl;
    }
    {
      memory.LowerClock();
      if (tick < 40 || (tick > 40 && tick < 41) || tick > 150) {
        const int data_in = num_writes; // rand() % (1 << 10);
        reference.push_back(data_in);
        memory.mutable_underlying()->wen_in = 1;
        memory.mutable_underlying()->data_in = data_in;
        num_writes++;
        if (num_writes > kDepth) {
          reference_index++;
        }
        std::cout << "    doing write !! " << data_in << std::endl;
      } else {
        memory.mutable_underlying()->wen_in = 0;
      }
      memory.RaiseClock();
    }
    {
      const auto data_out = memory.underlying().data_out;
      const auto valid_out = (int)memory.underlying().valid_out;
      std::cout << "CLOCK HI tick = " << tick << ", do_write = " << do_write << ", valid_out = " << valid_out << ", data_out = " << data_out << /*", expected data out = " << reference[reference_index] << */", reference_index = " << reference_index << ", num_writes = " << num_writes << std::endl;
    }
  }

  return true;
}

}  // namespace

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);

    TestSramPhases();
    TestSramInterleaved();
    TestLbBasic();

    // for (int i = 0; i < 20; i++) {
    //   LowerClock(memory_core.get());
    //   std::cout << "#### CLOCK " << i << " ####" << std::endl;
    //   memory_core->wen_in = 1;
    //   memory_core->ren_in = 0;
    //   memory_core->data_in = i + 348;
    //   std::cout << "  valid = " << (int)memory_core->valid_out << std::endl;
    //   std::cout << "  almost_full = " << (int)memory_core->almost_full << std::endl;
    //   std::cout << "  almost_empty = " << (int)memory_core->almost_empty << std::endl;
    //   std::cout << "  data_out = " << (int)memory_core->data_out << std::endl;
    //   RaiseClock(memory_core.get());
    // }

    std::cout << "Tests ran successfully. Exiting." << std::endl;
    return 0;
}
