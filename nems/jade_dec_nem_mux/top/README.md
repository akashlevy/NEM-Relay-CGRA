<pre>
To build the CGRA, cd to this directory and execute "run.csh"

If you get an error "Genesis2.pl: command not found" then run 
"./setup-genesis2.csh" and follow the directions

To clean up after running the generator, use the "genesis_clean"
script, which is created every time you execute "run.csh":

    ./genesis_clean.cmd

</pre>



<pre>
TBD The optional makefile lets you run the generator from any remote
TBD directory without messing up the generator sources.  For example,
TBD if the generator lives in
TBD 
TBD    /nobackup/steveri/github/CGRA/hardware/generator_z/top
TBD 
TBD you can do this:
TBD 
TBD    % mkdir /tmp/cgra; cd /tmp/cgra
TBD    % make gen -f /nobackup/steveri/github/CGRA/hardware/generator_z/top/Makefile
TBD    % ls /tmp/cgra
TBD        genesis_clean.cmd*  genesis_synth/         genesis_vlog.verif.vf
TBD        genesis.log         genesis_verif/         genesis_vlog.vf
TBD        genesis_raw/        genesis_vlog.synth.vf  genesis_work/

UNUSED Alternatively, you can use the makefile, e.g. one of:
UNUSED     make gen
UNUSED     make gen CGRA_GEN_USE_MEM=1
UNUSED     make gen CGRA_GEN_ALL_REG=1
UNUSED     make gen CGRA_GEN_ALL_REG=1 CGRA_GEN_USE_MEM=1
</pre>
