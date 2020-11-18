// Than write a C++ testbench. C++ is used for the bench since non
// synthesizable Verilog features would be needed to write a proper
// Verilog bench. Anoter option would be to use SystemC, but due to
// licensing issues it is very difficult to get a package for Linux
// distributions. The bench will toggle the clock and provide input
// values.

// https://www.veripool.org/projects/verilator/wiki/Manual-verilator#FAQ-FREQUENTLY-ASKED-QUESTIONS
// 
// How do I generate waveforms (traces) in C++?
// 
//     See the next question for tracing in SystemC mode.
// 
//     Add the --trace switch to Verilator, and in your top level C
//     code, call Verilated::traceEverOn(true). Then create a
//     VerilatedVcdC object, and in your main loop call
//     "trace_object->dump(time)" every time step, and finally call
//     "trace_object->close()". For an example, see below and the
//     test_c/sim_main.cpp file of the distribution.
// 
//     You also need to compile verilated_vcd_c.cpp and add it to your
//     link, preferably by adding the dependencies in
//     $(VK_GLOBAL_OBJS) to your Makefile's link rule. This is done
//     for you if using the Verilator --exe flag.
// 
//     Note you can also call ->trace on multiple Verilated objects
//     with the same trace file if you want all data to land in the
//     same output file.


#include "Vcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"


int main(int argc, char **argv, char **env) {
  int i;
  int clk;
  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vcounter* top = new Vcounter;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("counter.vcd");
  // initialize simulation inputs
  top->clk = 1;
  top->rst = 1;
  top->cen = 0;
  top->wen = 0;
  top->dat = 0x55;
  // run simulation for 100 clock periods
  for (i=0; i<20; i++) {
    top->rst = (i < 2);
    // dump variables into VCD file and toggle clock
    for (clk=0; clk<2; clk++) {
      tfp->dump (2*i+clk);
      top->clk = !top->clk;
      top->eval ();
    }
    top->cen = (i > 5);
    top->wen = (i == 10);
    if (Verilated::gotFinish())  exit(0);
  }
  tfp->close();
  exit(0);
}
