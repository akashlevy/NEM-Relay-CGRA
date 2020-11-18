// 03/2017 Got rid of the vcd waveform trace and did printf's instead.

#include "Vcounter.h"
#include "verilated.h"
// #include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
  int i;
  int clk;

  // printf("Hello Woild!\n");

  Verilated::commandArgs(argc, argv);

  // init top verilog instance
  Vcounter* top = new Vcounter;

  // init trace dump
  // Verilated::traceEverOn(true);
  // VerilatedVcdC* tfp = new VerilatedVcdC;
  // top->trace (tfp, 99);
  // tfp->open ("counter.vcd");

  // initialize simulation inputs
  top->clk = 1;
  top->rst = 1;
  top->cen = 0;
  top->wen = 0;
  top->dat = 0x55;

  printf("\n");

  // run simulation for 100 clock periods
  for (i=0; i<20; i++) {
      if (i%4==0) {
          printf("\n");
          printf("           i.clk  rst cen wen o_p  o_n\n");
          printf("    -----  -----  --- --- --- ---  ---\n");
      }
      top->rst = (i < 2); // Keep reset HIGH for first two clocks, then zero.

    for (clk=0; clk<2; clk++) {
      // tfp->dump (2*i+clk);
      top->clk = !top->clk;

      // Print a set of ascii waveforms, sorta
      printf("    eval-  ");
      printf("%03d.%d   %d   %d   %d   %2x   %2x\n", i, clk, top->rst, top->cen, top->wen, top->o_p, top->o_n);
      top->eval ();
      printf("    eval+  ");
      printf("%03d.%d   %d   %d   %d   %2x   %2x\n", i, clk, top->rst, top->cen, top->wen, top->o_p, top->o_n);
    }
    top->cen = (i > 5);   // After first five clocks, increment (cen) by 1?  Then zero thereafter??
    top->wen = (i == 10); // After first ten clocks, set counter to dat value (0x55)
    if (Verilated::gotFinish())  exit(0);
  }
  // tfp->close();
  exit(0);
}
