Genesis2.pl -parse -generate -top cb -input cb.vp tb_cb.vp cb_pnr.tclp 

grep -v "^//\|^module\|^endmodule" genesis_verif/cb_pnr.tcl > genesis_synth/pnr.tcl
