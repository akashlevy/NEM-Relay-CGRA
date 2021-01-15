Genesis2.pl -parse -generate -top top -input 		top.svp \
							JTAGDriver.svp \
							clocker.svp \
							test.svp \
							../jtag.svp \
						        ../Template/src/digital/template_ifc.svp \
							../Template/src/digital/cfg_ifc.svp \
						        ../Template/src/digital/flop.svp \
						        ../Template/src/digital/tap.svp \
						        ../Template/src/digital/cfg_and_dbg.svp
