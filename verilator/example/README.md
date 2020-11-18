03/2017 Verilator testbench example for 8-bit counter.

To run original example from Rattus Pubis, creating a vcd wave file "counter.vcd":

  ./run.csh counter_tb.cpp

-----
To run my testbench that instead prints an ascii waveform to stdout:

  ./run.csh counter_tb_ascii.cpp

(See counter_tb_ascii.out for sample output.)

-----
Or, to be fancy:

  ./run.csh counter_tb_ascii.cpp | tee tmp.out
  diff counter_tb_ascii.out tmp.out

-----
To clean up from testbench runs:

  ./run.csh -clean




----------------------------------------------------------------------------------
http://rattus-pubis.blogspot.com/2011/02/experimenting-with-verilator-counter.html

See 0notes-rattus-pubis.txt in this dir.

1. counter.v
2. counter_tb.cpp
3. run.csh


------------------------------------------------------------------------------
Notes on running verilator
- apparently I use the VERILATOR_ROOT scheme, because the other one didn't work for me...

# If you used the VERILATOR_ROOT scheme you're done. Programs should
# set the environment variable VERILATOR_ROOT to point to this
# distribution, then execute $VERILATOR_ROOT/bin/verilator, which will
# find the path to all needed files.
# 
#         If you used the prefix scheme, now do a "make install". To run
#         verilator, have the verilator binary directory in your PATH (this
#         should already be true if using the default configure), and make
#         sure VERILATOR_ROOT is not set.
# 
#     Detailed documentation and the man page can be seen by running:
# 
#         bin/verilator --help


------------------------------------------------------------------------------
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

