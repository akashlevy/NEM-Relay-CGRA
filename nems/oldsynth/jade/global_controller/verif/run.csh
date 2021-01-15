rm -rf genesis_verif/
Genesis2.pl -parse -generate -top top -input 		top.svp \
							JTAGDriver.svp \
							clocker.svp \
							test.svp \
							../global_controller.svp \
							../../jtag/jtag.svp \
						        ../../jtag/Template/src/digital/template_ifc.svp \
							../../jtag/Template/src/digital/cfg_ifc.svp \
						        ../../jtag/Template/src/digital/flop.svp \
						        ../../jtag/Template/src/digital/tap.svp \
						        ../../jtag/Template/src/digital/cfg_and_dbg.svp
