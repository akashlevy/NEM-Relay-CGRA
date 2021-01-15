Genesis2.pl -parse -generate -top global_controller -input  global_controller.svp \
							../jtag/jtag.svp \
						        ../jtag/Template/src/digital/template_ifc.svp \
							../jtag/Template/src/digital/cfg_ifc.svp \
						        ../jtag/Template/src/digital/flop.svp \
						        ../jtag/Template/src/digital/tap.svp \
						        ../jtag/Template/src/digital/cfg_and_dbg.svp \
							analog_regfile.vp
