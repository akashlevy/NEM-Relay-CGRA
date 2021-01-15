Genesis2.pl -parse -generate -top sb -input sb.vp sb_pnr.tclp tb_sb.vp

grep -v "^//\|^module\|^endmodule" genesis_verif/sb_pnr.tcl > genesis_synth/pnr.tcl
