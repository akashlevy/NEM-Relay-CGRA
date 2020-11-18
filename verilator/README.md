Subdirectories:

**example/**
Simple verilator example shows how to compile and run a testbench for a simple 8-bit counter.

**example-remote/**
Similar to example/ except it builds a local testbench using remote verilog sources.

**generator_z_tb/**
A testbench for generator_z
To use it do this:
<pre>
  cd generator_z
  ./run.csh tb_remote.cpp 

Current status: compiles verilog sources but does not yet succesfully link in a testbench.
Also: have not yet written a testbench that I expect to work at all correctly.
Current tb 'remote' is just BOGUS.

