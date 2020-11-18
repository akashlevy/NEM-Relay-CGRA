11/24/2017
To run travis test can do e.g.:

  % ( cd $gen/testdir ; make test_all ) | & tee test_all.log | less

where $gen == CGRAGenerator/ repository path





==============================================================================
06/10/2017

8x8 matrix successfully doubles the parrot.

To run:

  run.csh -usemem -config ../../bitstream/examples/cd387-newmem-8x8.bs

Sample output from run:

  runlogs/run-8x8-usemem.log

Proof of 8x8-ness in log:

<pre>
Here is what I built (it's supposed to look like an array of tiles).

    --------------------------------------------
    t0#0_0#0    t0#0_1#0    t0#0_2#0    t1#0_3#0    t0#0_4#0    t0#0_5#0    t0#0_6#0    t1#0_7#0    
    t0#1_0#0    t0#1_1#0    t0#1_2#0    t1#0_3#1    t0#1_4#0    t0#1_5#0    t0#1_6#0    t1#0_7#1    
    t0#2_0#0    t0#2_1#0    t0#2_2#0    t1#2_3#0    t0#2_4#0    t0#2_5#0    t0#2_6#0    t1#2_7#0    
    t0#3_0#0    t0#3_1#0    t0#3_2#0    t1#2_3#1    t0#3_4#0    t0#3_5#0    t0#3_6#0    t1#2_7#1    
    t0#4_0#0    t0#4_1#0    t0#4_2#0    t1#4_3#0    t0#4_4#0    t0#4_5#0    t0#4_6#0    t1#4_7#0    
    t0#5_0#0    t0#5_1#0    t0#5_2#0    t1#4_3#1    t0#5_4#0    t0#5_5#0    t0#5_6#0    t1#4_7#1    
    t0#6_0#0    t0#6_1#0    t0#6_2#0    t1#6_3#0    t0#6_4#0    t0#6_5#0    t0#6_6#0    t1#6_7#0    
    t0#7_0#0    t0#7_1#0    t0#7_2#0    t1#6_3#1    t0#7_4#0    t0#7_5#0    t0#7_6#0    t1#6_7#1    
    --------------------------------------------
</pre>

------------------------------------------------------------------------------
OLD 03/12/2017

OLD A testbench that uses the sources in ../generator_z.

OLD Current status: compiles verilog sources but does not yet succesfully link in a testbench.

OLD Also: have not yet written a testbench that I expect to work at all correctly.
