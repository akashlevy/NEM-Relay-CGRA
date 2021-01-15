files=`ls ../top/genesis_verif/*.v ../top/genesis_verif/*.sv ./top_tb.v`
irun -l irun.log -access +rwc +nctimescale+1ns/1ps -notimingchecks -input cmd.tcl $files
