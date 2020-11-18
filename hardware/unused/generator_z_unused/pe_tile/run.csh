Genesis2.pl -parse -generate -top pe -input ../sb/sb.vp ../cb/cb.vp pe.vp 

grep -v "^//\|^module\|^endmodule" genesis_verif/mem_tile_pnr.tcl > genesis_synth/pnr.tcl
