# ####################################################################

#  Created by Genus(TM) Synthesis Solution 17.21-s010_1 on Sun Apr 22 11:25:25 PDT 2018

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000.0fF
set_units -time 1000.0ps

# Set the current design
current_design pe_tile_new_unq1

create_clock -name "clk" -period 2.0 -waveform {0.0 0.5} [get_ports clk_in]
set_load -pin_load 0.1 [get_ports {out_BUS1_S0_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S0_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S0_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S0_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S0_T4[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S1_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S1_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S1_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S1_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S1_T4[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S2_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S2_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S2_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S2_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S2_T4[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S3_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S3_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S3_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S3_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS1_S3_T4[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S0_T4[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S1_T4[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S2_T4[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T0[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T1[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T2[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T3[0]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[15]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[14]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[13]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[12]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[11]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[10]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[9]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[8]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[7]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[6]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[5]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[4]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[3]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[2]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[1]}]
set_load -pin_load 0.1 [get_ports {out_BUS16_S3_T4[0]}]
set_load -pin_load 0.1 [get_ports gout]
set_load -pin_load 0.1 [get_ports {read_data[31]}]
set_load -pin_load 0.1 [get_ports {read_data[30]}]
set_load -pin_load 0.1 [get_ports {read_data[29]}]
set_load -pin_load 0.1 [get_ports {read_data[28]}]
set_load -pin_load 0.1 [get_ports {read_data[27]}]
set_load -pin_load 0.1 [get_ports {read_data[26]}]
set_load -pin_load 0.1 [get_ports {read_data[25]}]
set_load -pin_load 0.1 [get_ports {read_data[24]}]
set_load -pin_load 0.1 [get_ports {read_data[23]}]
set_load -pin_load 0.1 [get_ports {read_data[22]}]
set_load -pin_load 0.1 [get_ports {read_data[21]}]
set_load -pin_load 0.1 [get_ports {read_data[20]}]
set_load -pin_load 0.1 [get_ports {read_data[19]}]
set_load -pin_load 0.1 [get_ports {read_data[18]}]
set_load -pin_load 0.1 [get_ports {read_data[17]}]
set_load -pin_load 0.1 [get_ports {read_data[16]}]
set_load -pin_load 0.1 [get_ports {read_data[15]}]
set_load -pin_load 0.1 [get_ports {read_data[14]}]
set_load -pin_load 0.1 [get_ports {read_data[13]}]
set_load -pin_load 0.1 [get_ports {read_data[12]}]
set_load -pin_load 0.1 [get_ports {read_data[11]}]
set_load -pin_load 0.1 [get_ports {read_data[10]}]
set_load -pin_load 0.1 [get_ports {read_data[9]}]
set_load -pin_load 0.1 [get_ports {read_data[8]}]
set_load -pin_load 0.1 [get_ports {read_data[7]}]
set_load -pin_load 0.1 [get_ports {read_data[6]}]
set_load -pin_load 0.1 [get_ports {read_data[5]}]
set_load -pin_load 0.1 [get_ports {read_data[4]}]
set_load -pin_load 0.1 [get_ports {read_data[3]}]
set_load -pin_load 0.1 [get_ports {read_data[2]}]
set_load -pin_load 0.1 [get_ports {read_data[1]}]
set_load -pin_load 0.1 [get_ports {read_data[0]}]
set_false_path -from [list \
  [get_pins {cb_data1/config_cb_reg[25]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[1]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[14]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[15]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[16]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[17]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[18]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[19]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[20]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[21]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[2]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[3]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[22]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[23]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[24]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[0]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[13]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[26]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[27]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[5]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[28]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[29]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[6]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[7]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[30]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[31]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[8]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[9]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[10]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[11]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[12]/CP}]  \
  [get_pins {cb_data1/config_cb_reg[4]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[25]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[1]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[14]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[15]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[16]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[17]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[18]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[19]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[20]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[21]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[2]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[3]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[22]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[23]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[24]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[0]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[13]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[26]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[27]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[5]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[28]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[29]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[6]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[7]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[30]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[31]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[8]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[9]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[10]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[11]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[12]/CP}]  \
  [get_pins {cb_bit2/config_cb_reg[4]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[25]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[1]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[14]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[15]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[16]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[17]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[18]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[19]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[20]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[21]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[2]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[3]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[22]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[23]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[24]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[0]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[13]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[26]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[27]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[5]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[28]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[29]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[6]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[7]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[30]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[31]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[8]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[9]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[10]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[11]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[12]/CP}]  \
  [get_pins {cb_data0/config_cb_reg[4]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[25]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[1]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[14]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[15]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[16]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[17]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[18]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[19]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[20]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[21]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[2]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[3]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[22]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[23]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[24]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[0]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[13]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[26]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[27]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[5]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[28]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[29]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[6]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[7]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[30]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[31]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[8]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[9]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[10]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[11]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[12]/CP}]  \
  [get_pins {cb_cg_en/config_cb_reg[4]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[25]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[1]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[14]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[15]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[16]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[17]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[18]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[19]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[20]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[21]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[2]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[3]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[22]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[23]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[24]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[0]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[13]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[26]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[27]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[5]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[28]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[29]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[6]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[7]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[30]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[31]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[8]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[9]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[10]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[11]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[12]/CP}]  \
  [get_pins {cb_bit1/config_cb_reg[4]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[3]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[1]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[13]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[14]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[15]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[16]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[17]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[18]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[19]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[20]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[2]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[21]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[22]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[23]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[24]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[0]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[12]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[26]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[4]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[27]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[28]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[5]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[6]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[29]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[30]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[31]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[7]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[8]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[9]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[10]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[11]/CP}]  \
  [get_pins {cb_bit0/config_cb_reg[25]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[0]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[1]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[2]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[3]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[4]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[5]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[6]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[7]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[8]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[9]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[10]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[11]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[12]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[13]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[14]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[15]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[16]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[17]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[18]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[19]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[20]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[21]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[22]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[23]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[24]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[25]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[26]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[27]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[28]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[29]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[30]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[31]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[32]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[33]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[34]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[35]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[36]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[37]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[38]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[39]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[40]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[41]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[42]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[43]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[44]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[45]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[46]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[47]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[48]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[49]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[50]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[51]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[52]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[53]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[54]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[55]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[56]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[57]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[58]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[59]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[60]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[61]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[62]/CP}]  \
  [get_pins {sb_wide/config_sb_reg[63]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[0]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[1]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[2]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[3]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[4]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[5]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[6]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[7]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[8]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[9]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[10]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[11]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[12]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[13]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[14]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[15]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[16]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[17]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[18]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[19]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[20]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[21]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[22]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[23]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[24]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[25]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[26]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[27]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[28]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[29]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[30]/CP}]  \
  [get_pins {sb_wide/config_ungate_reg[31]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[0]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[1]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[2]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[3]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[4]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[5]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[6]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[7]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[8]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[9]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[10]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[11]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[12]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[13]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[14]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[15]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[16]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[17]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[18]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[19]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[20]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[21]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[22]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[23]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[24]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[25]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[26]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[27]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[28]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[29]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[30]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[31]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[32]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[33]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[34]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[35]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[36]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[37]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[38]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[39]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[40]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[41]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[42]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[43]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[44]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[45]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[46]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[47]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[48]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[49]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[50]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[51]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[52]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[53]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[54]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[55]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[56]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[57]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[58]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[59]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[60]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[61]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[62]/CP}]  \
  [get_pins {sb_1b/config_sb_reg[63]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[0]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[1]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[2]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[3]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[4]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[5]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[6]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[7]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[8]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[9]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[10]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[11]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[12]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[13]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[14]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[15]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[16]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[17]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[18]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[19]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[20]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[21]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[22]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[23]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[24]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[25]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[26]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[27]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[28]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[29]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[30]/CP}]  \
  [get_pins {sb_1b/config_ungate_reg[31]/CP}] ]
set_false_path -to [list \
  [get_pins {cb_data1/config_cb_reg[25]/D}]  \
  [get_pins {cb_data1/config_cb_reg[1]/D}]  \
  [get_pins {cb_data1/config_cb_reg[14]/D}]  \
  [get_pins {cb_data1/config_cb_reg[15]/D}]  \
  [get_pins {cb_data1/config_cb_reg[16]/D}]  \
  [get_pins {cb_data1/config_cb_reg[17]/D}]  \
  [get_pins {cb_data1/config_cb_reg[18]/D}]  \
  [get_pins {cb_data1/config_cb_reg[19]/D}]  \
  [get_pins {cb_data1/config_cb_reg[20]/D}]  \
  [get_pins {cb_data1/config_cb_reg[21]/D}]  \
  [get_pins {cb_data1/config_cb_reg[2]/D}]  \
  [get_pins {cb_data1/config_cb_reg[3]/D}]  \
  [get_pins {cb_data1/config_cb_reg[22]/D}]  \
  [get_pins {cb_data1/config_cb_reg[23]/D}]  \
  [get_pins {cb_data1/config_cb_reg[24]/D}]  \
  [get_pins {cb_data1/config_cb_reg[0]/D}]  \
  [get_pins {cb_data1/config_cb_reg[13]/D}]  \
  [get_pins {cb_data1/config_cb_reg[26]/D}]  \
  [get_pins {cb_data1/config_cb_reg[27]/D}]  \
  [get_pins {cb_data1/config_cb_reg[5]/D}]  \
  [get_pins {cb_data1/config_cb_reg[28]/D}]  \
  [get_pins {cb_data1/config_cb_reg[29]/D}]  \
  [get_pins {cb_data1/config_cb_reg[6]/D}]  \
  [get_pins {cb_data1/config_cb_reg[7]/D}]  \
  [get_pins {cb_data1/config_cb_reg[30]/D}]  \
  [get_pins {cb_data1/config_cb_reg[31]/D}]  \
  [get_pins {cb_data1/config_cb_reg[8]/D}]  \
  [get_pins {cb_data1/config_cb_reg[9]/D}]  \
  [get_pins {cb_data1/config_cb_reg[10]/D}]  \
  [get_pins {cb_data1/config_cb_reg[11]/D}]  \
  [get_pins {cb_data1/config_cb_reg[12]/D}]  \
  [get_pins {cb_data1/config_cb_reg[4]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[25]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[1]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[14]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[15]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[16]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[17]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[18]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[19]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[20]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[21]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[2]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[3]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[22]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[23]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[24]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[0]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[13]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[26]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[27]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[5]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[28]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[29]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[6]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[7]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[30]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[31]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[8]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[9]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[10]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[11]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[12]/D}]  \
  [get_pins {cb_bit2/config_cb_reg[4]/D}]  \
  [get_pins {cb_data0/config_cb_reg[25]/D}]  \
  [get_pins {cb_data0/config_cb_reg[1]/D}]  \
  [get_pins {cb_data0/config_cb_reg[14]/D}]  \
  [get_pins {cb_data0/config_cb_reg[15]/D}]  \
  [get_pins {cb_data0/config_cb_reg[16]/D}]  \
  [get_pins {cb_data0/config_cb_reg[17]/D}]  \
  [get_pins {cb_data0/config_cb_reg[18]/D}]  \
  [get_pins {cb_data0/config_cb_reg[19]/D}]  \
  [get_pins {cb_data0/config_cb_reg[20]/D}]  \
  [get_pins {cb_data0/config_cb_reg[21]/D}]  \
  [get_pins {cb_data0/config_cb_reg[2]/D}]  \
  [get_pins {cb_data0/config_cb_reg[3]/D}]  \
  [get_pins {cb_data0/config_cb_reg[22]/D}]  \
  [get_pins {cb_data0/config_cb_reg[23]/D}]  \
  [get_pins {cb_data0/config_cb_reg[24]/D}]  \
  [get_pins {cb_data0/config_cb_reg[0]/D}]  \
  [get_pins {cb_data0/config_cb_reg[13]/D}]  \
  [get_pins {cb_data0/config_cb_reg[26]/D}]  \
  [get_pins {cb_data0/config_cb_reg[27]/D}]  \
  [get_pins {cb_data0/config_cb_reg[5]/D}]  \
  [get_pins {cb_data0/config_cb_reg[28]/D}]  \
  [get_pins {cb_data0/config_cb_reg[29]/D}]  \
  [get_pins {cb_data0/config_cb_reg[6]/D}]  \
  [get_pins {cb_data0/config_cb_reg[7]/D}]  \
  [get_pins {cb_data0/config_cb_reg[30]/D}]  \
  [get_pins {cb_data0/config_cb_reg[31]/D}]  \
  [get_pins {cb_data0/config_cb_reg[8]/D}]  \
  [get_pins {cb_data0/config_cb_reg[9]/D}]  \
  [get_pins {cb_data0/config_cb_reg[10]/D}]  \
  [get_pins {cb_data0/config_cb_reg[11]/D}]  \
  [get_pins {cb_data0/config_cb_reg[12]/D}]  \
  [get_pins {cb_data0/config_cb_reg[4]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[25]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[1]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[14]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[15]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[16]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[17]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[18]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[19]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[20]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[21]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[2]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[3]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[22]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[23]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[24]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[0]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[13]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[26]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[27]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[5]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[28]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[29]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[6]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[7]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[30]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[31]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[8]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[9]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[10]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[11]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[12]/D}]  \
  [get_pins {cb_cg_en/config_cb_reg[4]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[25]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[1]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[14]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[15]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[16]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[17]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[18]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[19]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[20]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[21]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[2]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[3]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[22]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[23]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[24]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[0]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[13]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[26]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[27]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[5]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[28]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[29]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[6]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[7]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[30]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[31]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[8]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[9]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[10]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[11]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[12]/D}]  \
  [get_pins {cb_bit1/config_cb_reg[4]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[3]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[1]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[13]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[14]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[15]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[16]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[17]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[18]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[19]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[20]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[2]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[21]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[22]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[23]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[24]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[0]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[12]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[26]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[4]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[27]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[28]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[5]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[6]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[29]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[30]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[31]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[7]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[8]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[9]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[10]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[11]/D}]  \
  [get_pins {cb_bit0/config_cb_reg[25]/D}]  \
  [get_pins {sb_wide/config_sb_reg[0]/D}]  \
  [get_pins {sb_wide/config_sb_reg[1]/D}]  \
  [get_pins {sb_wide/config_sb_reg[2]/D}]  \
  [get_pins {sb_wide/config_sb_reg[3]/D}]  \
  [get_pins {sb_wide/config_sb_reg[4]/D}]  \
  [get_pins {sb_wide/config_sb_reg[5]/D}]  \
  [get_pins {sb_wide/config_sb_reg[6]/D}]  \
  [get_pins {sb_wide/config_sb_reg[7]/D}]  \
  [get_pins {sb_wide/config_sb_reg[8]/D}]  \
  [get_pins {sb_wide/config_sb_reg[9]/D}]  \
  [get_pins {sb_wide/config_sb_reg[10]/D}]  \
  [get_pins {sb_wide/config_sb_reg[11]/D}]  \
  [get_pins {sb_wide/config_sb_reg[12]/D}]  \
  [get_pins {sb_wide/config_sb_reg[13]/D}]  \
  [get_pins {sb_wide/config_sb_reg[14]/D}]  \
  [get_pins {sb_wide/config_sb_reg[15]/D}]  \
  [get_pins {sb_wide/config_sb_reg[16]/D}]  \
  [get_pins {sb_wide/config_sb_reg[17]/D}]  \
  [get_pins {sb_wide/config_sb_reg[18]/D}]  \
  [get_pins {sb_wide/config_sb_reg[19]/D}]  \
  [get_pins {sb_wide/config_sb_reg[20]/D}]  \
  [get_pins {sb_wide/config_sb_reg[21]/D}]  \
  [get_pins {sb_wide/config_sb_reg[22]/D}]  \
  [get_pins {sb_wide/config_sb_reg[23]/D}]  \
  [get_pins {sb_wide/config_sb_reg[24]/D}]  \
  [get_pins {sb_wide/config_sb_reg[25]/D}]  \
  [get_pins {sb_wide/config_sb_reg[26]/D}]  \
  [get_pins {sb_wide/config_sb_reg[27]/D}]  \
  [get_pins {sb_wide/config_sb_reg[28]/D}]  \
  [get_pins {sb_wide/config_sb_reg[29]/D}]  \
  [get_pins {sb_wide/config_sb_reg[30]/D}]  \
  [get_pins {sb_wide/config_sb_reg[31]/D}]  \
  [get_pins {sb_wide/config_sb_reg[32]/D}]  \
  [get_pins {sb_wide/config_sb_reg[33]/D}]  \
  [get_pins {sb_wide/config_sb_reg[34]/D}]  \
  [get_pins {sb_wide/config_sb_reg[35]/D}]  \
  [get_pins {sb_wide/config_sb_reg[36]/D}]  \
  [get_pins {sb_wide/config_sb_reg[37]/D}]  \
  [get_pins {sb_wide/config_sb_reg[38]/D}]  \
  [get_pins {sb_wide/config_sb_reg[39]/D}]  \
  [get_pins {sb_wide/config_sb_reg[40]/D}]  \
  [get_pins {sb_wide/config_sb_reg[41]/D}]  \
  [get_pins {sb_wide/config_sb_reg[42]/D}]  \
  [get_pins {sb_wide/config_sb_reg[43]/D}]  \
  [get_pins {sb_wide/config_sb_reg[44]/D}]  \
  [get_pins {sb_wide/config_sb_reg[45]/D}]  \
  [get_pins {sb_wide/config_sb_reg[46]/D}]  \
  [get_pins {sb_wide/config_sb_reg[47]/D}]  \
  [get_pins {sb_wide/config_sb_reg[48]/D}]  \
  [get_pins {sb_wide/config_sb_reg[49]/D}]  \
  [get_pins {sb_wide/config_sb_reg[50]/D}]  \
  [get_pins {sb_wide/config_sb_reg[51]/D}]  \
  [get_pins {sb_wide/config_sb_reg[52]/D}]  \
  [get_pins {sb_wide/config_sb_reg[53]/D}]  \
  [get_pins {sb_wide/config_sb_reg[54]/D}]  \
  [get_pins {sb_wide/config_sb_reg[55]/D}]  \
  [get_pins {sb_wide/config_sb_reg[56]/D}]  \
  [get_pins {sb_wide/config_sb_reg[57]/D}]  \
  [get_pins {sb_wide/config_sb_reg[58]/D}]  \
  [get_pins {sb_wide/config_sb_reg[59]/D}]  \
  [get_pins {sb_wide/config_sb_reg[60]/D}]  \
  [get_pins {sb_wide/config_sb_reg[61]/D}]  \
  [get_pins {sb_wide/config_sb_reg[62]/D}]  \
  [get_pins {sb_wide/config_sb_reg[63]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[0]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[1]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[2]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[3]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[4]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[5]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[6]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[7]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[8]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[9]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[10]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[11]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[12]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[13]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[14]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[15]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[16]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[17]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[18]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[19]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[20]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[21]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[22]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[23]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[24]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[25]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[26]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[27]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[28]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[29]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[30]/D}]  \
  [get_pins {sb_wide/config_ungate_reg[31]/D}]  \
  [get_pins {sb_1b/config_sb_reg[0]/D}]  \
  [get_pins {sb_1b/config_sb_reg[1]/D}]  \
  [get_pins {sb_1b/config_sb_reg[2]/D}]  \
  [get_pins {sb_1b/config_sb_reg[3]/D}]  \
  [get_pins {sb_1b/config_sb_reg[4]/D}]  \
  [get_pins {sb_1b/config_sb_reg[5]/D}]  \
  [get_pins {sb_1b/config_sb_reg[6]/D}]  \
  [get_pins {sb_1b/config_sb_reg[7]/D}]  \
  [get_pins {sb_1b/config_sb_reg[8]/D}]  \
  [get_pins {sb_1b/config_sb_reg[9]/D}]  \
  [get_pins {sb_1b/config_sb_reg[10]/D}]  \
  [get_pins {sb_1b/config_sb_reg[11]/D}]  \
  [get_pins {sb_1b/config_sb_reg[12]/D}]  \
  [get_pins {sb_1b/config_sb_reg[13]/D}]  \
  [get_pins {sb_1b/config_sb_reg[14]/D}]  \
  [get_pins {sb_1b/config_sb_reg[15]/D}]  \
  [get_pins {sb_1b/config_sb_reg[16]/D}]  \
  [get_pins {sb_1b/config_sb_reg[17]/D}]  \
  [get_pins {sb_1b/config_sb_reg[18]/D}]  \
  [get_pins {sb_1b/config_sb_reg[19]/D}]  \
  [get_pins {sb_1b/config_sb_reg[20]/D}]  \
  [get_pins {sb_1b/config_sb_reg[21]/D}]  \
  [get_pins {sb_1b/config_sb_reg[22]/D}]  \
  [get_pins {sb_1b/config_sb_reg[23]/D}]  \
  [get_pins {sb_1b/config_sb_reg[24]/D}]  \
  [get_pins {sb_1b/config_sb_reg[25]/D}]  \
  [get_pins {sb_1b/config_sb_reg[26]/D}]  \
  [get_pins {sb_1b/config_sb_reg[27]/D}]  \
  [get_pins {sb_1b/config_sb_reg[28]/D}]  \
  [get_pins {sb_1b/config_sb_reg[29]/D}]  \
  [get_pins {sb_1b/config_sb_reg[30]/D}]  \
  [get_pins {sb_1b/config_sb_reg[31]/D}]  \
  [get_pins {sb_1b/config_sb_reg[32]/D}]  \
  [get_pins {sb_1b/config_sb_reg[33]/D}]  \
  [get_pins {sb_1b/config_sb_reg[34]/D}]  \
  [get_pins {sb_1b/config_sb_reg[35]/D}]  \
  [get_pins {sb_1b/config_sb_reg[36]/D}]  \
  [get_pins {sb_1b/config_sb_reg[37]/D}]  \
  [get_pins {sb_1b/config_sb_reg[38]/D}]  \
  [get_pins {sb_1b/config_sb_reg[39]/D}]  \
  [get_pins {sb_1b/config_sb_reg[40]/D}]  \
  [get_pins {sb_1b/config_sb_reg[41]/D}]  \
  [get_pins {sb_1b/config_sb_reg[42]/D}]  \
  [get_pins {sb_1b/config_sb_reg[43]/D}]  \
  [get_pins {sb_1b/config_sb_reg[44]/D}]  \
  [get_pins {sb_1b/config_sb_reg[45]/D}]  \
  [get_pins {sb_1b/config_sb_reg[46]/D}]  \
  [get_pins {sb_1b/config_sb_reg[47]/D}]  \
  [get_pins {sb_1b/config_sb_reg[48]/D}]  \
  [get_pins {sb_1b/config_sb_reg[49]/D}]  \
  [get_pins {sb_1b/config_sb_reg[50]/D}]  \
  [get_pins {sb_1b/config_sb_reg[51]/D}]  \
  [get_pins {sb_1b/config_sb_reg[52]/D}]  \
  [get_pins {sb_1b/config_sb_reg[53]/D}]  \
  [get_pins {sb_1b/config_sb_reg[54]/D}]  \
  [get_pins {sb_1b/config_sb_reg[55]/D}]  \
  [get_pins {sb_1b/config_sb_reg[56]/D}]  \
  [get_pins {sb_1b/config_sb_reg[57]/D}]  \
  [get_pins {sb_1b/config_sb_reg[58]/D}]  \
  [get_pins {sb_1b/config_sb_reg[59]/D}]  \
  [get_pins {sb_1b/config_sb_reg[60]/D}]  \
  [get_pins {sb_1b/config_sb_reg[61]/D}]  \
  [get_pins {sb_1b/config_sb_reg[62]/D}]  \
  [get_pins {sb_1b/config_sb_reg[63]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[0]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[1]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[2]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[3]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[4]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[5]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[6]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[7]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[8]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[9]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[10]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[11]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[12]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[13]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[14]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[15]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[16]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[17]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[18]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[19]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[20]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[21]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[22]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[23]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[24]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[25]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[26]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[27]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[28]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[29]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[30]/D}]  \
  [get_pins {sb_1b/config_ungate_reg[31]/D}] ]
set_false_path -through [list \
  [get_pins {sb_wide/out_0_0[15]}]  \
  [get_pins {sb_wide/out_0_0[14]}]  \
  [get_pins {sb_wide/out_0_0[13]}]  \
  [get_pins {sb_wide/out_0_0[12]}]  \
  [get_pins {sb_wide/out_0_0[11]}]  \
  [get_pins {sb_wide/out_0_0[10]}]  \
  [get_pins {sb_wide/out_0_0[9]}]  \
  [get_pins {sb_wide/out_0_0[8]}]  \
  [get_pins {sb_wide/out_0_0[7]}]  \
  [get_pins {sb_wide/out_0_0[6]}]  \
  [get_pins {sb_wide/out_0_0[5]}]  \
  [get_pins {sb_wide/out_0_0[4]}]  \
  [get_pins {sb_wide/out_0_0[3]}]  \
  [get_pins {sb_wide/out_0_0[2]}]  \
  [get_pins {sb_wide/out_0_0[1]}]  \
  [get_pins {sb_wide/out_0_0[0]}]  \
  [get_pins {sb_wide/out_0_1[15]}]  \
  [get_pins {sb_wide/out_0_1[14]}]  \
  [get_pins {sb_wide/out_0_1[13]}]  \
  [get_pins {sb_wide/out_0_1[12]}]  \
  [get_pins {sb_wide/out_0_1[11]}]  \
  [get_pins {sb_wide/out_0_1[10]}]  \
  [get_pins {sb_wide/out_0_1[9]}]  \
  [get_pins {sb_wide/out_0_1[8]}]  \
  [get_pins {sb_wide/out_0_1[7]}]  \
  [get_pins {sb_wide/out_0_1[6]}]  \
  [get_pins {sb_wide/out_0_1[5]}]  \
  [get_pins {sb_wide/out_0_1[4]}]  \
  [get_pins {sb_wide/out_0_1[3]}]  \
  [get_pins {sb_wide/out_0_1[2]}]  \
  [get_pins {sb_wide/out_0_1[1]}]  \
  [get_pins {sb_wide/out_0_1[0]}]  \
  [get_pins {sb_wide/out_0_2[15]}]  \
  [get_pins {sb_wide/out_0_2[14]}]  \
  [get_pins {sb_wide/out_0_2[13]}]  \
  [get_pins {sb_wide/out_0_2[12]}]  \
  [get_pins {sb_wide/out_0_2[11]}]  \
  [get_pins {sb_wide/out_0_2[10]}]  \
  [get_pins {sb_wide/out_0_2[9]}]  \
  [get_pins {sb_wide/out_0_2[8]}]  \
  [get_pins {sb_wide/out_0_2[7]}]  \
  [get_pins {sb_wide/out_0_2[6]}]  \
  [get_pins {sb_wide/out_0_2[5]}]  \
  [get_pins {sb_wide/out_0_2[4]}]  \
  [get_pins {sb_wide/out_0_2[3]}]  \
  [get_pins {sb_wide/out_0_2[2]}]  \
  [get_pins {sb_wide/out_0_2[1]}]  \
  [get_pins {sb_wide/out_0_2[0]}]  \
  [get_pins {sb_wide/out_0_3[15]}]  \
  [get_pins {sb_wide/out_0_3[14]}]  \
  [get_pins {sb_wide/out_0_3[13]}]  \
  [get_pins {sb_wide/out_0_3[12]}]  \
  [get_pins {sb_wide/out_0_3[11]}]  \
  [get_pins {sb_wide/out_0_3[10]}]  \
  [get_pins {sb_wide/out_0_3[9]}]  \
  [get_pins {sb_wide/out_0_3[8]}]  \
  [get_pins {sb_wide/out_0_3[7]}]  \
  [get_pins {sb_wide/out_0_3[6]}]  \
  [get_pins {sb_wide/out_0_3[5]}]  \
  [get_pins {sb_wide/out_0_3[4]}]  \
  [get_pins {sb_wide/out_0_3[3]}]  \
  [get_pins {sb_wide/out_0_3[2]}]  \
  [get_pins {sb_wide/out_0_3[1]}]  \
  [get_pins {sb_wide/out_0_3[0]}]  \
  [get_pins {sb_wide/out_0_4[15]}]  \
  [get_pins {sb_wide/out_0_4[14]}]  \
  [get_pins {sb_wide/out_0_4[13]}]  \
  [get_pins {sb_wide/out_0_4[12]}]  \
  [get_pins {sb_wide/out_0_4[11]}]  \
  [get_pins {sb_wide/out_0_4[10]}]  \
  [get_pins {sb_wide/out_0_4[9]}]  \
  [get_pins {sb_wide/out_0_4[8]}]  \
  [get_pins {sb_wide/out_0_4[7]}]  \
  [get_pins {sb_wide/out_0_4[6]}]  \
  [get_pins {sb_wide/out_0_4[5]}]  \
  [get_pins {sb_wide/out_0_4[4]}]  \
  [get_pins {sb_wide/out_0_4[3]}]  \
  [get_pins {sb_wide/out_0_4[2]}]  \
  [get_pins {sb_wide/out_0_4[1]}]  \
  [get_pins {sb_wide/out_0_4[0]}]  \
  [get_pins {sb_wide/out_1_0[15]}]  \
  [get_pins {sb_wide/out_1_0[14]}]  \
  [get_pins {sb_wide/out_1_0[13]}]  \
  [get_pins {sb_wide/out_1_0[12]}]  \
  [get_pins {sb_wide/out_1_0[11]}]  \
  [get_pins {sb_wide/out_1_0[10]}]  \
  [get_pins {sb_wide/out_1_0[9]}]  \
  [get_pins {sb_wide/out_1_0[8]}]  \
  [get_pins {sb_wide/out_1_0[7]}]  \
  [get_pins {sb_wide/out_1_0[6]}]  \
  [get_pins {sb_wide/out_1_0[5]}]  \
  [get_pins {sb_wide/out_1_0[4]}]  \
  [get_pins {sb_wide/out_1_0[3]}]  \
  [get_pins {sb_wide/out_1_0[2]}]  \
  [get_pins {sb_wide/out_1_0[1]}]  \
  [get_pins {sb_wide/out_1_0[0]}]  \
  [get_pins {sb_wide/out_1_1[15]}]  \
  [get_pins {sb_wide/out_1_1[14]}]  \
  [get_pins {sb_wide/out_1_1[13]}]  \
  [get_pins {sb_wide/out_1_1[12]}]  \
  [get_pins {sb_wide/out_1_1[11]}]  \
  [get_pins {sb_wide/out_1_1[10]}]  \
  [get_pins {sb_wide/out_1_1[9]}]  \
  [get_pins {sb_wide/out_1_1[8]}]  \
  [get_pins {sb_wide/out_1_1[7]}]  \
  [get_pins {sb_wide/out_1_1[6]}]  \
  [get_pins {sb_wide/out_1_1[5]}]  \
  [get_pins {sb_wide/out_1_1[4]}]  \
  [get_pins {sb_wide/out_1_1[3]}]  \
  [get_pins {sb_wide/out_1_1[2]}]  \
  [get_pins {sb_wide/out_1_1[1]}]  \
  [get_pins {sb_wide/out_1_1[0]}]  \
  [get_pins {sb_wide/out_1_2[15]}]  \
  [get_pins {sb_wide/out_1_2[14]}]  \
  [get_pins {sb_wide/out_1_2[13]}]  \
  [get_pins {sb_wide/out_1_2[12]}]  \
  [get_pins {sb_wide/out_1_2[11]}]  \
  [get_pins {sb_wide/out_1_2[10]}]  \
  [get_pins {sb_wide/out_1_2[9]}]  \
  [get_pins {sb_wide/out_1_2[8]}]  \
  [get_pins {sb_wide/out_1_2[7]}]  \
  [get_pins {sb_wide/out_1_2[6]}]  \
  [get_pins {sb_wide/out_1_2[5]}]  \
  [get_pins {sb_wide/out_1_2[4]}]  \
  [get_pins {sb_wide/out_1_2[3]}]  \
  [get_pins {sb_wide/out_1_2[2]}]  \
  [get_pins {sb_wide/out_1_2[1]}]  \
  [get_pins {sb_wide/out_1_2[0]}]  \
  [get_pins {sb_wide/out_1_3[15]}]  \
  [get_pins {sb_wide/out_1_3[14]}]  \
  [get_pins {sb_wide/out_1_3[13]}]  \
  [get_pins {sb_wide/out_1_3[12]}]  \
  [get_pins {sb_wide/out_1_3[11]}]  \
  [get_pins {sb_wide/out_1_3[10]}]  \
  [get_pins {sb_wide/out_1_3[9]}]  \
  [get_pins {sb_wide/out_1_3[8]}]  \
  [get_pins {sb_wide/out_1_3[7]}]  \
  [get_pins {sb_wide/out_1_3[6]}]  \
  [get_pins {sb_wide/out_1_3[5]}]  \
  [get_pins {sb_wide/out_1_3[4]}]  \
  [get_pins {sb_wide/out_1_3[3]}]  \
  [get_pins {sb_wide/out_1_3[2]}]  \
  [get_pins {sb_wide/out_1_3[1]}]  \
  [get_pins {sb_wide/out_1_3[0]}]  \
  [get_pins {sb_wide/out_1_4[15]}]  \
  [get_pins {sb_wide/out_1_4[14]}]  \
  [get_pins {sb_wide/out_1_4[13]}]  \
  [get_pins {sb_wide/out_1_4[12]}]  \
  [get_pins {sb_wide/out_1_4[11]}]  \
  [get_pins {sb_wide/out_1_4[10]}]  \
  [get_pins {sb_wide/out_1_4[9]}]  \
  [get_pins {sb_wide/out_1_4[8]}]  \
  [get_pins {sb_wide/out_1_4[7]}]  \
  [get_pins {sb_wide/out_1_4[6]}]  \
  [get_pins {sb_wide/out_1_4[5]}]  \
  [get_pins {sb_wide/out_1_4[4]}]  \
  [get_pins {sb_wide/out_1_4[3]}]  \
  [get_pins {sb_wide/out_1_4[2]}]  \
  [get_pins {sb_wide/out_1_4[1]}]  \
  [get_pins {sb_wide/out_1_4[0]}]  \
  [get_pins {sb_wide/out_2_0[15]}]  \
  [get_pins {sb_wide/out_2_0[14]}]  \
  [get_pins {sb_wide/out_2_0[13]}]  \
  [get_pins {sb_wide/out_2_0[12]}]  \
  [get_pins {sb_wide/out_2_0[11]}]  \
  [get_pins {sb_wide/out_2_0[10]}]  \
  [get_pins {sb_wide/out_2_0[9]}]  \
  [get_pins {sb_wide/out_2_0[8]}]  \
  [get_pins {sb_wide/out_2_0[7]}]  \
  [get_pins {sb_wide/out_2_0[6]}]  \
  [get_pins {sb_wide/out_2_0[5]}]  \
  [get_pins {sb_wide/out_2_0[4]}]  \
  [get_pins {sb_wide/out_2_0[3]}]  \
  [get_pins {sb_wide/out_2_0[2]}]  \
  [get_pins {sb_wide/out_2_0[1]}]  \
  [get_pins {sb_wide/out_2_0[0]}]  \
  [get_pins {sb_wide/out_2_1[15]}]  \
  [get_pins {sb_wide/out_2_1[14]}]  \
  [get_pins {sb_wide/out_2_1[13]}]  \
  [get_pins {sb_wide/out_2_1[12]}]  \
  [get_pins {sb_wide/out_2_1[11]}]  \
  [get_pins {sb_wide/out_2_1[10]}]  \
  [get_pins {sb_wide/out_2_1[9]}]  \
  [get_pins {sb_wide/out_2_1[8]}]  \
  [get_pins {sb_wide/out_2_1[7]}]  \
  [get_pins {sb_wide/out_2_1[6]}]  \
  [get_pins {sb_wide/out_2_1[5]}]  \
  [get_pins {sb_wide/out_2_1[4]}]  \
  [get_pins {sb_wide/out_2_1[3]}]  \
  [get_pins {sb_wide/out_2_1[2]}]  \
  [get_pins {sb_wide/out_2_1[1]}]  \
  [get_pins {sb_wide/out_2_1[0]}]  \
  [get_pins {sb_wide/out_2_2[15]}]  \
  [get_pins {sb_wide/out_2_2[14]}]  \
  [get_pins {sb_wide/out_2_2[13]}]  \
  [get_pins {sb_wide/out_2_2[12]}]  \
  [get_pins {sb_wide/out_2_2[11]}]  \
  [get_pins {sb_wide/out_2_2[10]}]  \
  [get_pins {sb_wide/out_2_2[9]}]  \
  [get_pins {sb_wide/out_2_2[8]}]  \
  [get_pins {sb_wide/out_2_2[7]}]  \
  [get_pins {sb_wide/out_2_2[6]}]  \
  [get_pins {sb_wide/out_2_2[5]}]  \
  [get_pins {sb_wide/out_2_2[4]}]  \
  [get_pins {sb_wide/out_2_2[3]}]  \
  [get_pins {sb_wide/out_2_2[2]}]  \
  [get_pins {sb_wide/out_2_2[1]}]  \
  [get_pins {sb_wide/out_2_2[0]}]  \
  [get_pins {sb_wide/out_2_3[15]}]  \
  [get_pins {sb_wide/out_2_3[14]}]  \
  [get_pins {sb_wide/out_2_3[13]}]  \
  [get_pins {sb_wide/out_2_3[12]}]  \
  [get_pins {sb_wide/out_2_3[11]}]  \
  [get_pins {sb_wide/out_2_3[10]}]  \
  [get_pins {sb_wide/out_2_3[9]}]  \
  [get_pins {sb_wide/out_2_3[8]}]  \
  [get_pins {sb_wide/out_2_3[7]}]  \
  [get_pins {sb_wide/out_2_3[6]}]  \
  [get_pins {sb_wide/out_2_3[5]}]  \
  [get_pins {sb_wide/out_2_3[4]}]  \
  [get_pins {sb_wide/out_2_3[3]}]  \
  [get_pins {sb_wide/out_2_3[2]}]  \
  [get_pins {sb_wide/out_2_3[1]}]  \
  [get_pins {sb_wide/out_2_3[0]}]  \
  [get_pins {sb_wide/out_2_4[15]}]  \
  [get_pins {sb_wide/out_2_4[14]}]  \
  [get_pins {sb_wide/out_2_4[13]}]  \
  [get_pins {sb_wide/out_2_4[12]}]  \
  [get_pins {sb_wide/out_2_4[11]}]  \
  [get_pins {sb_wide/out_2_4[10]}]  \
  [get_pins {sb_wide/out_2_4[9]}]  \
  [get_pins {sb_wide/out_2_4[8]}]  \
  [get_pins {sb_wide/out_2_4[7]}]  \
  [get_pins {sb_wide/out_2_4[6]}]  \
  [get_pins {sb_wide/out_2_4[5]}]  \
  [get_pins {sb_wide/out_2_4[4]}]  \
  [get_pins {sb_wide/out_2_4[3]}]  \
  [get_pins {sb_wide/out_2_4[2]}]  \
  [get_pins {sb_wide/out_2_4[1]}]  \
  [get_pins {sb_wide/out_2_4[0]}]  \
  [get_pins {sb_wide/out_3_0[15]}]  \
  [get_pins {sb_wide/out_3_0[14]}]  \
  [get_pins {sb_wide/out_3_0[13]}]  \
  [get_pins {sb_wide/out_3_0[12]}]  \
  [get_pins {sb_wide/out_3_0[11]}]  \
  [get_pins {sb_wide/out_3_0[10]}]  \
  [get_pins {sb_wide/out_3_0[9]}]  \
  [get_pins {sb_wide/out_3_0[8]}]  \
  [get_pins {sb_wide/out_3_0[7]}]  \
  [get_pins {sb_wide/out_3_0[6]}]  \
  [get_pins {sb_wide/out_3_0[5]}]  \
  [get_pins {sb_wide/out_3_0[4]}]  \
  [get_pins {sb_wide/out_3_0[3]}]  \
  [get_pins {sb_wide/out_3_0[2]}]  \
  [get_pins {sb_wide/out_3_0[1]}]  \
  [get_pins {sb_wide/out_3_0[0]}]  \
  [get_pins {sb_wide/out_3_1[15]}]  \
  [get_pins {sb_wide/out_3_1[14]}]  \
  [get_pins {sb_wide/out_3_1[13]}]  \
  [get_pins {sb_wide/out_3_1[12]}]  \
  [get_pins {sb_wide/out_3_1[11]}]  \
  [get_pins {sb_wide/out_3_1[10]}]  \
  [get_pins {sb_wide/out_3_1[9]}]  \
  [get_pins {sb_wide/out_3_1[8]}]  \
  [get_pins {sb_wide/out_3_1[7]}]  \
  [get_pins {sb_wide/out_3_1[6]}]  \
  [get_pins {sb_wide/out_3_1[5]}]  \
  [get_pins {sb_wide/out_3_1[4]}]  \
  [get_pins {sb_wide/out_3_1[3]}]  \
  [get_pins {sb_wide/out_3_1[2]}]  \
  [get_pins {sb_wide/out_3_1[1]}]  \
  [get_pins {sb_wide/out_3_1[0]}]  \
  [get_pins {sb_wide/out_3_2[15]}]  \
  [get_pins {sb_wide/out_3_2[14]}]  \
  [get_pins {sb_wide/out_3_2[13]}]  \
  [get_pins {sb_wide/out_3_2[12]}]  \
  [get_pins {sb_wide/out_3_2[11]}]  \
  [get_pins {sb_wide/out_3_2[10]}]  \
  [get_pins {sb_wide/out_3_2[9]}]  \
  [get_pins {sb_wide/out_3_2[8]}]  \
  [get_pins {sb_wide/out_3_2[7]}]  \
  [get_pins {sb_wide/out_3_2[6]}]  \
  [get_pins {sb_wide/out_3_2[5]}]  \
  [get_pins {sb_wide/out_3_2[4]}]  \
  [get_pins {sb_wide/out_3_2[3]}]  \
  [get_pins {sb_wide/out_3_2[2]}]  \
  [get_pins {sb_wide/out_3_2[1]}]  \
  [get_pins {sb_wide/out_3_2[0]}]  \
  [get_pins {sb_wide/out_3_3[15]}]  \
  [get_pins {sb_wide/out_3_3[14]}]  \
  [get_pins {sb_wide/out_3_3[13]}]  \
  [get_pins {sb_wide/out_3_3[12]}]  \
  [get_pins {sb_wide/out_3_3[11]}]  \
  [get_pins {sb_wide/out_3_3[10]}]  \
  [get_pins {sb_wide/out_3_3[9]}]  \
  [get_pins {sb_wide/out_3_3[8]}]  \
  [get_pins {sb_wide/out_3_3[7]}]  \
  [get_pins {sb_wide/out_3_3[6]}]  \
  [get_pins {sb_wide/out_3_3[5]}]  \
  [get_pins {sb_wide/out_3_3[4]}]  \
  [get_pins {sb_wide/out_3_3[3]}]  \
  [get_pins {sb_wide/out_3_3[2]}]  \
  [get_pins {sb_wide/out_3_3[1]}]  \
  [get_pins {sb_wide/out_3_3[0]}]  \
  [get_pins {sb_wide/out_3_4[15]}]  \
  [get_pins {sb_wide/out_3_4[14]}]  \
  [get_pins {sb_wide/out_3_4[13]}]  \
  [get_pins {sb_wide/out_3_4[12]}]  \
  [get_pins {sb_wide/out_3_4[11]}]  \
  [get_pins {sb_wide/out_3_4[10]}]  \
  [get_pins {sb_wide/out_3_4[9]}]  \
  [get_pins {sb_wide/out_3_4[8]}]  \
  [get_pins {sb_wide/out_3_4[7]}]  \
  [get_pins {sb_wide/out_3_4[6]}]  \
  [get_pins {sb_wide/out_3_4[5]}]  \
  [get_pins {sb_wide/out_3_4[4]}]  \
  [get_pins {sb_wide/out_3_4[3]}]  \
  [get_pins {sb_wide/out_3_4[2]}]  \
  [get_pins {sb_wide/out_3_4[1]}]  \
  [get_pins {sb_wide/out_3_4[0]}]  \
  [get_pins {sb_wide/read_data[31]}]  \
  [get_pins {sb_wide/read_data[30]}]  \
  [get_pins {sb_wide/read_data[29]}]  \
  [get_pins {sb_wide/read_data[28]}]  \
  [get_pins {sb_wide/read_data[27]}]  \
  [get_pins {sb_wide/read_data[26]}]  \
  [get_pins {sb_wide/read_data[25]}]  \
  [get_pins {sb_wide/read_data[24]}]  \
  [get_pins {sb_wide/read_data[23]}]  \
  [get_pins {sb_wide/read_data[22]}]  \
  [get_pins {sb_wide/read_data[21]}]  \
  [get_pins {sb_wide/read_data[20]}]  \
  [get_pins {sb_wide/read_data[19]}]  \
  [get_pins {sb_wide/read_data[18]}]  \
  [get_pins {sb_wide/read_data[17]}]  \
  [get_pins {sb_wide/read_data[16]}]  \
  [get_pins {sb_wide/read_data[15]}]  \
  [get_pins {sb_wide/read_data[14]}]  \
  [get_pins {sb_wide/read_data[13]}]  \
  [get_pins {sb_wide/read_data[12]}]  \
  [get_pins {sb_wide/read_data[11]}]  \
  [get_pins {sb_wide/read_data[10]}]  \
  [get_pins {sb_wide/read_data[9]}]  \
  [get_pins {sb_wide/read_data[8]}]  \
  [get_pins {sb_wide/read_data[7]}]  \
  [get_pins {sb_wide/read_data[6]}]  \
  [get_pins {sb_wide/read_data[5]}]  \
  [get_pins {sb_wide/read_data[4]}]  \
  [get_pins {sb_wide/read_data[3]}]  \
  [get_pins {sb_wide/read_data[2]}]  \
  [get_pins {sb_wide/read_data[1]}]  \
  [get_pins {sb_wide/read_data[0]}]  \
  [get_pins {sb_1b/out_0_0[0]}]  \
  [get_pins {sb_1b/out_0_1[0]}]  \
  [get_pins {sb_1b/out_0_2[0]}]  \
  [get_pins {sb_1b/out_0_3[0]}]  \
  [get_pins {sb_1b/out_0_4[0]}]  \
  [get_pins {sb_1b/out_1_0[0]}]  \
  [get_pins {sb_1b/out_1_1[0]}]  \
  [get_pins {sb_1b/out_1_2[0]}]  \
  [get_pins {sb_1b/out_1_3[0]}]  \
  [get_pins {sb_1b/out_1_4[0]}]  \
  [get_pins {sb_1b/out_2_0[0]}]  \
  [get_pins {sb_1b/out_2_1[0]}]  \
  [get_pins {sb_1b/out_2_2[0]}]  \
  [get_pins {sb_1b/out_2_3[0]}]  \
  [get_pins {sb_1b/out_2_4[0]}]  \
  [get_pins {sb_1b/out_3_0[0]}]  \
  [get_pins {sb_1b/out_3_1[0]}]  \
  [get_pins {sb_1b/out_3_2[0]}]  \
  [get_pins {sb_1b/out_3_3[0]}]  \
  [get_pins {sb_1b/out_3_4[0]}]  \
  [get_pins {sb_1b/read_data[31]}]  \
  [get_pins {sb_1b/read_data[30]}]  \
  [get_pins {sb_1b/read_data[29]}]  \
  [get_pins {sb_1b/read_data[28]}]  \
  [get_pins {sb_1b/read_data[27]}]  \
  [get_pins {sb_1b/read_data[26]}]  \
  [get_pins {sb_1b/read_data[25]}]  \
  [get_pins {sb_1b/read_data[24]}]  \
  [get_pins {sb_1b/read_data[23]}]  \
  [get_pins {sb_1b/read_data[22]}]  \
  [get_pins {sb_1b/read_data[21]}]  \
  [get_pins {sb_1b/read_data[20]}]  \
  [get_pins {sb_1b/read_data[19]}]  \
  [get_pins {sb_1b/read_data[18]}]  \
  [get_pins {sb_1b/read_data[17]}]  \
  [get_pins {sb_1b/read_data[16]}]  \
  [get_pins {sb_1b/read_data[15]}]  \
  [get_pins {sb_1b/read_data[14]}]  \
  [get_pins {sb_1b/read_data[13]}]  \
  [get_pins {sb_1b/read_data[12]}]  \
  [get_pins {sb_1b/read_data[11]}]  \
  [get_pins {sb_1b/read_data[10]}]  \
  [get_pins {sb_1b/read_data[9]}]  \
  [get_pins {sb_1b/read_data[8]}]  \
  [get_pins {sb_1b/read_data[7]}]  \
  [get_pins {sb_1b/read_data[6]}]  \
  [get_pins {sb_1b/read_data[5]}]  \
  [get_pins {sb_1b/read_data[4]}]  \
  [get_pins {sb_1b/read_data[3]}]  \
  [get_pins {sb_1b/read_data[2]}]  \
  [get_pins {sb_1b/read_data[1]}]  \
  [get_pins {sb_1b/read_data[0]}] ] -through [list \
  [get_pins cb_data0/clk]  \
  [get_pins cb_data0/reset]  \
  [get_pins {cb_data0/in_0[15]}]  \
  [get_pins {cb_data0/in_0[14]}]  \
  [get_pins {cb_data0/in_0[13]}]  \
  [get_pins {cb_data0/in_0[12]}]  \
  [get_pins {cb_data0/in_0[11]}]  \
  [get_pins {cb_data0/in_0[10]}]  \
  [get_pins {cb_data0/in_0[9]}]  \
  [get_pins {cb_data0/in_0[8]}]  \
  [get_pins {cb_data0/in_0[7]}]  \
  [get_pins {cb_data0/in_0[6]}]  \
  [get_pins {cb_data0/in_0[5]}]  \
  [get_pins {cb_data0/in_0[4]}]  \
  [get_pins {cb_data0/in_0[3]}]  \
  [get_pins {cb_data0/in_0[2]}]  \
  [get_pins {cb_data0/in_0[1]}]  \
  [get_pins {cb_data0/in_0[0]}]  \
  [get_pins {cb_data0/in_1[15]}]  \
  [get_pins {cb_data0/in_1[14]}]  \
  [get_pins {cb_data0/in_1[13]}]  \
  [get_pins {cb_data0/in_1[12]}]  \
  [get_pins {cb_data0/in_1[11]}]  \
  [get_pins {cb_data0/in_1[10]}]  \
  [get_pins {cb_data0/in_1[9]}]  \
  [get_pins {cb_data0/in_1[8]}]  \
  [get_pins {cb_data0/in_1[7]}]  \
  [get_pins {cb_data0/in_1[6]}]  \
  [get_pins {cb_data0/in_1[5]}]  \
  [get_pins {cb_data0/in_1[4]}]  \
  [get_pins {cb_data0/in_1[3]}]  \
  [get_pins {cb_data0/in_1[2]}]  \
  [get_pins {cb_data0/in_1[1]}]  \
  [get_pins {cb_data0/in_1[0]}]  \
  [get_pins {cb_data0/in_2[15]}]  \
  [get_pins {cb_data0/in_2[14]}]  \
  [get_pins {cb_data0/in_2[13]}]  \
  [get_pins {cb_data0/in_2[12]}]  \
  [get_pins {cb_data0/in_2[11]}]  \
  [get_pins {cb_data0/in_2[10]}]  \
  [get_pins {cb_data0/in_2[9]}]  \
  [get_pins {cb_data0/in_2[8]}]  \
  [get_pins {cb_data0/in_2[7]}]  \
  [get_pins {cb_data0/in_2[6]}]  \
  [get_pins {cb_data0/in_2[5]}]  \
  [get_pins {cb_data0/in_2[4]}]  \
  [get_pins {cb_data0/in_2[3]}]  \
  [get_pins {cb_data0/in_2[2]}]  \
  [get_pins {cb_data0/in_2[1]}]  \
  [get_pins {cb_data0/in_2[0]}]  \
  [get_pins {cb_data0/in_3[15]}]  \
  [get_pins {cb_data0/in_3[14]}]  \
  [get_pins {cb_data0/in_3[13]}]  \
  [get_pins {cb_data0/in_3[12]}]  \
  [get_pins {cb_data0/in_3[11]}]  \
  [get_pins {cb_data0/in_3[10]}]  \
  [get_pins {cb_data0/in_3[9]}]  \
  [get_pins {cb_data0/in_3[8]}]  \
  [get_pins {cb_data0/in_3[7]}]  \
  [get_pins {cb_data0/in_3[6]}]  \
  [get_pins {cb_data0/in_3[5]}]  \
  [get_pins {cb_data0/in_3[4]}]  \
  [get_pins {cb_data0/in_3[3]}]  \
  [get_pins {cb_data0/in_3[2]}]  \
  [get_pins {cb_data0/in_3[1]}]  \
  [get_pins {cb_data0/in_3[0]}]  \
  [get_pins {cb_data0/in_4[15]}]  \
  [get_pins {cb_data0/in_4[14]}]  \
  [get_pins {cb_data0/in_4[13]}]  \
  [get_pins {cb_data0/in_4[12]}]  \
  [get_pins {cb_data0/in_4[11]}]  \
  [get_pins {cb_data0/in_4[10]}]  \
  [get_pins {cb_data0/in_4[9]}]  \
  [get_pins {cb_data0/in_4[8]}]  \
  [get_pins {cb_data0/in_4[7]}]  \
  [get_pins {cb_data0/in_4[6]}]  \
  [get_pins {cb_data0/in_4[5]}]  \
  [get_pins {cb_data0/in_4[4]}]  \
  [get_pins {cb_data0/in_4[3]}]  \
  [get_pins {cb_data0/in_4[2]}]  \
  [get_pins {cb_data0/in_4[1]}]  \
  [get_pins {cb_data0/in_4[0]}]  \
  [get_pins {cb_data0/in_5[15]}]  \
  [get_pins {cb_data0/in_5[14]}]  \
  [get_pins {cb_data0/in_5[13]}]  \
  [get_pins {cb_data0/in_5[12]}]  \
  [get_pins {cb_data0/in_5[11]}]  \
  [get_pins {cb_data0/in_5[10]}]  \
  [get_pins {cb_data0/in_5[9]}]  \
  [get_pins {cb_data0/in_5[8]}]  \
  [get_pins {cb_data0/in_5[7]}]  \
  [get_pins {cb_data0/in_5[6]}]  \
  [get_pins {cb_data0/in_5[5]}]  \
  [get_pins {cb_data0/in_5[4]}]  \
  [get_pins {cb_data0/in_5[3]}]  \
  [get_pins {cb_data0/in_5[2]}]  \
  [get_pins {cb_data0/in_5[1]}]  \
  [get_pins {cb_data0/in_5[0]}]  \
  [get_pins {cb_data0/in_6[15]}]  \
  [get_pins {cb_data0/in_6[14]}]  \
  [get_pins {cb_data0/in_6[13]}]  \
  [get_pins {cb_data0/in_6[12]}]  \
  [get_pins {cb_data0/in_6[11]}]  \
  [get_pins {cb_data0/in_6[10]}]  \
  [get_pins {cb_data0/in_6[9]}]  \
  [get_pins {cb_data0/in_6[8]}]  \
  [get_pins {cb_data0/in_6[7]}]  \
  [get_pins {cb_data0/in_6[6]}]  \
  [get_pins {cb_data0/in_6[5]}]  \
  [get_pins {cb_data0/in_6[4]}]  \
  [get_pins {cb_data0/in_6[3]}]  \
  [get_pins {cb_data0/in_6[2]}]  \
  [get_pins {cb_data0/in_6[1]}]  \
  [get_pins {cb_data0/in_6[0]}]  \
  [get_pins {cb_data0/in_7[15]}]  \
  [get_pins {cb_data0/in_7[14]}]  \
  [get_pins {cb_data0/in_7[13]}]  \
  [get_pins {cb_data0/in_7[12]}]  \
  [get_pins {cb_data0/in_7[11]}]  \
  [get_pins {cb_data0/in_7[10]}]  \
  [get_pins {cb_data0/in_7[9]}]  \
  [get_pins {cb_data0/in_7[8]}]  \
  [get_pins {cb_data0/in_7[7]}]  \
  [get_pins {cb_data0/in_7[6]}]  \
  [get_pins {cb_data0/in_7[5]}]  \
  [get_pins {cb_data0/in_7[4]}]  \
  [get_pins {cb_data0/in_7[3]}]  \
  [get_pins {cb_data0/in_7[2]}]  \
  [get_pins {cb_data0/in_7[1]}]  \
  [get_pins {cb_data0/in_7[0]}]  \
  [get_pins {cb_data0/in_8[15]}]  \
  [get_pins {cb_data0/in_8[14]}]  \
  [get_pins {cb_data0/in_8[13]}]  \
  [get_pins {cb_data0/in_8[12]}]  \
  [get_pins {cb_data0/in_8[11]}]  \
  [get_pins {cb_data0/in_8[10]}]  \
  [get_pins {cb_data0/in_8[9]}]  \
  [get_pins {cb_data0/in_8[8]}]  \
  [get_pins {cb_data0/in_8[7]}]  \
  [get_pins {cb_data0/in_8[6]}]  \
  [get_pins {cb_data0/in_8[5]}]  \
  [get_pins {cb_data0/in_8[4]}]  \
  [get_pins {cb_data0/in_8[3]}]  \
  [get_pins {cb_data0/in_8[2]}]  \
  [get_pins {cb_data0/in_8[1]}]  \
  [get_pins {cb_data0/in_8[0]}]  \
  [get_pins {cb_data0/in_9[15]}]  \
  [get_pins {cb_data0/in_9[14]}]  \
  [get_pins {cb_data0/in_9[13]}]  \
  [get_pins {cb_data0/in_9[12]}]  \
  [get_pins {cb_data0/in_9[11]}]  \
  [get_pins {cb_data0/in_9[10]}]  \
  [get_pins {cb_data0/in_9[9]}]  \
  [get_pins {cb_data0/in_9[8]}]  \
  [get_pins {cb_data0/in_9[7]}]  \
  [get_pins {cb_data0/in_9[6]}]  \
  [get_pins {cb_data0/in_9[5]}]  \
  [get_pins {cb_data0/in_9[4]}]  \
  [get_pins {cb_data0/in_9[3]}]  \
  [get_pins {cb_data0/in_9[2]}]  \
  [get_pins {cb_data0/in_9[1]}]  \
  [get_pins {cb_data0/in_9[0]}]  \
  [get_pins {cb_data0/config_addr[31]}]  \
  [get_pins {cb_data0/config_addr[30]}]  \
  [get_pins {cb_data0/config_addr[29]}]  \
  [get_pins {cb_data0/config_addr[28]}]  \
  [get_pins {cb_data0/config_addr[27]}]  \
  [get_pins {cb_data0/config_addr[26]}]  \
  [get_pins {cb_data0/config_addr[25]}]  \
  [get_pins {cb_data0/config_addr[24]}]  \
  [get_pins {cb_data0/config_addr[23]}]  \
  [get_pins {cb_data0/config_addr[22]}]  \
  [get_pins {cb_data0/config_addr[21]}]  \
  [get_pins {cb_data0/config_addr[20]}]  \
  [get_pins {cb_data0/config_addr[19]}]  \
  [get_pins {cb_data0/config_addr[18]}]  \
  [get_pins {cb_data0/config_addr[17]}]  \
  [get_pins {cb_data0/config_addr[16]}]  \
  [get_pins {cb_data0/config_addr[15]}]  \
  [get_pins {cb_data0/config_addr[14]}]  \
  [get_pins {cb_data0/config_addr[13]}]  \
  [get_pins {cb_data0/config_addr[12]}]  \
  [get_pins {cb_data0/config_addr[11]}]  \
  [get_pins {cb_data0/config_addr[10]}]  \
  [get_pins {cb_data0/config_addr[9]}]  \
  [get_pins {cb_data0/config_addr[8]}]  \
  [get_pins {cb_data0/config_addr[7]}]  \
  [get_pins {cb_data0/config_addr[6]}]  \
  [get_pins {cb_data0/config_addr[5]}]  \
  [get_pins {cb_data0/config_addr[4]}]  \
  [get_pins {cb_data0/config_addr[3]}]  \
  [get_pins {cb_data0/config_addr[2]}]  \
  [get_pins {cb_data0/config_addr[1]}]  \
  [get_pins {cb_data0/config_addr[0]}]  \
  [get_pins {cb_data0/config_data[31]}]  \
  [get_pins {cb_data0/config_data[30]}]  \
  [get_pins {cb_data0/config_data[29]}]  \
  [get_pins {cb_data0/config_data[28]}]  \
  [get_pins {cb_data0/config_data[27]}]  \
  [get_pins {cb_data0/config_data[26]}]  \
  [get_pins {cb_data0/config_data[25]}]  \
  [get_pins {cb_data0/config_data[24]}]  \
  [get_pins {cb_data0/config_data[23]}]  \
  [get_pins {cb_data0/config_data[22]}]  \
  [get_pins {cb_data0/config_data[21]}]  \
  [get_pins {cb_data0/config_data[20]}]  \
  [get_pins {cb_data0/config_data[19]}]  \
  [get_pins {cb_data0/config_data[18]}]  \
  [get_pins {cb_data0/config_data[17]}]  \
  [get_pins {cb_data0/config_data[16]}]  \
  [get_pins {cb_data0/config_data[15]}]  \
  [get_pins {cb_data0/config_data[14]}]  \
  [get_pins {cb_data0/config_data[13]}]  \
  [get_pins {cb_data0/config_data[12]}]  \
  [get_pins {cb_data0/config_data[11]}]  \
  [get_pins {cb_data0/config_data[10]}]  \
  [get_pins {cb_data0/config_data[9]}]  \
  [get_pins {cb_data0/config_data[8]}]  \
  [get_pins {cb_data0/config_data[7]}]  \
  [get_pins {cb_data0/config_data[6]}]  \
  [get_pins {cb_data0/config_data[5]}]  \
  [get_pins {cb_data0/config_data[4]}]  \
  [get_pins {cb_data0/config_data[3]}]  \
  [get_pins {cb_data0/config_data[2]}]  \
  [get_pins {cb_data0/config_data[1]}]  \
  [get_pins {cb_data0/config_data[0]}]  \
  [get_pins cb_data0/config_en]  \
  [get_pins cb_data1/clk]  \
  [get_pins cb_data1/reset]  \
  [get_pins {cb_data1/in_0[15]}]  \
  [get_pins {cb_data1/in_0[14]}]  \
  [get_pins {cb_data1/in_0[13]}]  \
  [get_pins {cb_data1/in_0[12]}]  \
  [get_pins {cb_data1/in_0[11]}]  \
  [get_pins {cb_data1/in_0[10]}]  \
  [get_pins {cb_data1/in_0[9]}]  \
  [get_pins {cb_data1/in_0[8]}]  \
  [get_pins {cb_data1/in_0[7]}]  \
  [get_pins {cb_data1/in_0[6]}]  \
  [get_pins {cb_data1/in_0[5]}]  \
  [get_pins {cb_data1/in_0[4]}]  \
  [get_pins {cb_data1/in_0[3]}]  \
  [get_pins {cb_data1/in_0[2]}]  \
  [get_pins {cb_data1/in_0[1]}]  \
  [get_pins {cb_data1/in_0[0]}]  \
  [get_pins {cb_data1/in_1[15]}]  \
  [get_pins {cb_data1/in_1[14]}]  \
  [get_pins {cb_data1/in_1[13]}]  \
  [get_pins {cb_data1/in_1[12]}]  \
  [get_pins {cb_data1/in_1[11]}]  \
  [get_pins {cb_data1/in_1[10]}]  \
  [get_pins {cb_data1/in_1[9]}]  \
  [get_pins {cb_data1/in_1[8]}]  \
  [get_pins {cb_data1/in_1[7]}]  \
  [get_pins {cb_data1/in_1[6]}]  \
  [get_pins {cb_data1/in_1[5]}]  \
  [get_pins {cb_data1/in_1[4]}]  \
  [get_pins {cb_data1/in_1[3]}]  \
  [get_pins {cb_data1/in_1[2]}]  \
  [get_pins {cb_data1/in_1[1]}]  \
  [get_pins {cb_data1/in_1[0]}]  \
  [get_pins {cb_data1/in_2[15]}]  \
  [get_pins {cb_data1/in_2[14]}]  \
  [get_pins {cb_data1/in_2[13]}]  \
  [get_pins {cb_data1/in_2[12]}]  \
  [get_pins {cb_data1/in_2[11]}]  \
  [get_pins {cb_data1/in_2[10]}]  \
  [get_pins {cb_data1/in_2[9]}]  \
  [get_pins {cb_data1/in_2[8]}]  \
  [get_pins {cb_data1/in_2[7]}]  \
  [get_pins {cb_data1/in_2[6]}]  \
  [get_pins {cb_data1/in_2[5]}]  \
  [get_pins {cb_data1/in_2[4]}]  \
  [get_pins {cb_data1/in_2[3]}]  \
  [get_pins {cb_data1/in_2[2]}]  \
  [get_pins {cb_data1/in_2[1]}]  \
  [get_pins {cb_data1/in_2[0]}]  \
  [get_pins {cb_data1/in_3[15]}]  \
  [get_pins {cb_data1/in_3[14]}]  \
  [get_pins {cb_data1/in_3[13]}]  \
  [get_pins {cb_data1/in_3[12]}]  \
  [get_pins {cb_data1/in_3[11]}]  \
  [get_pins {cb_data1/in_3[10]}]  \
  [get_pins {cb_data1/in_3[9]}]  \
  [get_pins {cb_data1/in_3[8]}]  \
  [get_pins {cb_data1/in_3[7]}]  \
  [get_pins {cb_data1/in_3[6]}]  \
  [get_pins {cb_data1/in_3[5]}]  \
  [get_pins {cb_data1/in_3[4]}]  \
  [get_pins {cb_data1/in_3[3]}]  \
  [get_pins {cb_data1/in_3[2]}]  \
  [get_pins {cb_data1/in_3[1]}]  \
  [get_pins {cb_data1/in_3[0]}]  \
  [get_pins {cb_data1/in_4[15]}]  \
  [get_pins {cb_data1/in_4[14]}]  \
  [get_pins {cb_data1/in_4[13]}]  \
  [get_pins {cb_data1/in_4[12]}]  \
  [get_pins {cb_data1/in_4[11]}]  \
  [get_pins {cb_data1/in_4[10]}]  \
  [get_pins {cb_data1/in_4[9]}]  \
  [get_pins {cb_data1/in_4[8]}]  \
  [get_pins {cb_data1/in_4[7]}]  \
  [get_pins {cb_data1/in_4[6]}]  \
  [get_pins {cb_data1/in_4[5]}]  \
  [get_pins {cb_data1/in_4[4]}]  \
  [get_pins {cb_data1/in_4[3]}]  \
  [get_pins {cb_data1/in_4[2]}]  \
  [get_pins {cb_data1/in_4[1]}]  \
  [get_pins {cb_data1/in_4[0]}]  \
  [get_pins {cb_data1/in_5[15]}]  \
  [get_pins {cb_data1/in_5[14]}]  \
  [get_pins {cb_data1/in_5[13]}]  \
  [get_pins {cb_data1/in_5[12]}]  \
  [get_pins {cb_data1/in_5[11]}]  \
  [get_pins {cb_data1/in_5[10]}]  \
  [get_pins {cb_data1/in_5[9]}]  \
  [get_pins {cb_data1/in_5[8]}]  \
  [get_pins {cb_data1/in_5[7]}]  \
  [get_pins {cb_data1/in_5[6]}]  \
  [get_pins {cb_data1/in_5[5]}]  \
  [get_pins {cb_data1/in_5[4]}]  \
  [get_pins {cb_data1/in_5[3]}]  \
  [get_pins {cb_data1/in_5[2]}]  \
  [get_pins {cb_data1/in_5[1]}]  \
  [get_pins {cb_data1/in_5[0]}]  \
  [get_pins {cb_data1/in_6[15]}]  \
  [get_pins {cb_data1/in_6[14]}]  \
  [get_pins {cb_data1/in_6[13]}]  \
  [get_pins {cb_data1/in_6[12]}]  \
  [get_pins {cb_data1/in_6[11]}]  \
  [get_pins {cb_data1/in_6[10]}]  \
  [get_pins {cb_data1/in_6[9]}]  \
  [get_pins {cb_data1/in_6[8]}]  \
  [get_pins {cb_data1/in_6[7]}]  \
  [get_pins {cb_data1/in_6[6]}]  \
  [get_pins {cb_data1/in_6[5]}]  \
  [get_pins {cb_data1/in_6[4]}]  \
  [get_pins {cb_data1/in_6[3]}]  \
  [get_pins {cb_data1/in_6[2]}]  \
  [get_pins {cb_data1/in_6[1]}]  \
  [get_pins {cb_data1/in_6[0]}]  \
  [get_pins {cb_data1/in_7[15]}]  \
  [get_pins {cb_data1/in_7[14]}]  \
  [get_pins {cb_data1/in_7[13]}]  \
  [get_pins {cb_data1/in_7[12]}]  \
  [get_pins {cb_data1/in_7[11]}]  \
  [get_pins {cb_data1/in_7[10]}]  \
  [get_pins {cb_data1/in_7[9]}]  \
  [get_pins {cb_data1/in_7[8]}]  \
  [get_pins {cb_data1/in_7[7]}]  \
  [get_pins {cb_data1/in_7[6]}]  \
  [get_pins {cb_data1/in_7[5]}]  \
  [get_pins {cb_data1/in_7[4]}]  \
  [get_pins {cb_data1/in_7[3]}]  \
  [get_pins {cb_data1/in_7[2]}]  \
  [get_pins {cb_data1/in_7[1]}]  \
  [get_pins {cb_data1/in_7[0]}]  \
  [get_pins {cb_data1/in_8[15]}]  \
  [get_pins {cb_data1/in_8[14]}]  \
  [get_pins {cb_data1/in_8[13]}]  \
  [get_pins {cb_data1/in_8[12]}]  \
  [get_pins {cb_data1/in_8[11]}]  \
  [get_pins {cb_data1/in_8[10]}]  \
  [get_pins {cb_data1/in_8[9]}]  \
  [get_pins {cb_data1/in_8[8]}]  \
  [get_pins {cb_data1/in_8[7]}]  \
  [get_pins {cb_data1/in_8[6]}]  \
  [get_pins {cb_data1/in_8[5]}]  \
  [get_pins {cb_data1/in_8[4]}]  \
  [get_pins {cb_data1/in_8[3]}]  \
  [get_pins {cb_data1/in_8[2]}]  \
  [get_pins {cb_data1/in_8[1]}]  \
  [get_pins {cb_data1/in_8[0]}]  \
  [get_pins {cb_data1/in_9[15]}]  \
  [get_pins {cb_data1/in_9[14]}]  \
  [get_pins {cb_data1/in_9[13]}]  \
  [get_pins {cb_data1/in_9[12]}]  \
  [get_pins {cb_data1/in_9[11]}]  \
  [get_pins {cb_data1/in_9[10]}]  \
  [get_pins {cb_data1/in_9[9]}]  \
  [get_pins {cb_data1/in_9[8]}]  \
  [get_pins {cb_data1/in_9[7]}]  \
  [get_pins {cb_data1/in_9[6]}]  \
  [get_pins {cb_data1/in_9[5]}]  \
  [get_pins {cb_data1/in_9[4]}]  \
  [get_pins {cb_data1/in_9[3]}]  \
  [get_pins {cb_data1/in_9[2]}]  \
  [get_pins {cb_data1/in_9[1]}]  \
  [get_pins {cb_data1/in_9[0]}]  \
  [get_pins {cb_data1/config_addr[31]}]  \
  [get_pins {cb_data1/config_addr[30]}]  \
  [get_pins {cb_data1/config_addr[29]}]  \
  [get_pins {cb_data1/config_addr[28]}]  \
  [get_pins {cb_data1/config_addr[27]}]  \
  [get_pins {cb_data1/config_addr[26]}]  \
  [get_pins {cb_data1/config_addr[25]}]  \
  [get_pins {cb_data1/config_addr[24]}]  \
  [get_pins {cb_data1/config_addr[23]}]  \
  [get_pins {cb_data1/config_addr[22]}]  \
  [get_pins {cb_data1/config_addr[21]}]  \
  [get_pins {cb_data1/config_addr[20]}]  \
  [get_pins {cb_data1/config_addr[19]}]  \
  [get_pins {cb_data1/config_addr[18]}]  \
  [get_pins {cb_data1/config_addr[17]}]  \
  [get_pins {cb_data1/config_addr[16]}]  \
  [get_pins {cb_data1/config_addr[15]}]  \
  [get_pins {cb_data1/config_addr[14]}]  \
  [get_pins {cb_data1/config_addr[13]}]  \
  [get_pins {cb_data1/config_addr[12]}]  \
  [get_pins {cb_data1/config_addr[11]}]  \
  [get_pins {cb_data1/config_addr[10]}]  \
  [get_pins {cb_data1/config_addr[9]}]  \
  [get_pins {cb_data1/config_addr[8]}]  \
  [get_pins {cb_data1/config_addr[7]}]  \
  [get_pins {cb_data1/config_addr[6]}]  \
  [get_pins {cb_data1/config_addr[5]}]  \
  [get_pins {cb_data1/config_addr[4]}]  \
  [get_pins {cb_data1/config_addr[3]}]  \
  [get_pins {cb_data1/config_addr[2]}]  \
  [get_pins {cb_data1/config_addr[1]}]  \
  [get_pins {cb_data1/config_addr[0]}]  \
  [get_pins {cb_data1/config_data[31]}]  \
  [get_pins {cb_data1/config_data[30]}]  \
  [get_pins {cb_data1/config_data[29]}]  \
  [get_pins {cb_data1/config_data[28]}]  \
  [get_pins {cb_data1/config_data[27]}]  \
  [get_pins {cb_data1/config_data[26]}]  \
  [get_pins {cb_data1/config_data[25]}]  \
  [get_pins {cb_data1/config_data[24]}]  \
  [get_pins {cb_data1/config_data[23]}]  \
  [get_pins {cb_data1/config_data[22]}]  \
  [get_pins {cb_data1/config_data[21]}]  \
  [get_pins {cb_data1/config_data[20]}]  \
  [get_pins {cb_data1/config_data[19]}]  \
  [get_pins {cb_data1/config_data[18]}]  \
  [get_pins {cb_data1/config_data[17]}]  \
  [get_pins {cb_data1/config_data[16]}]  \
  [get_pins {cb_data1/config_data[15]}]  \
  [get_pins {cb_data1/config_data[14]}]  \
  [get_pins {cb_data1/config_data[13]}]  \
  [get_pins {cb_data1/config_data[12]}]  \
  [get_pins {cb_data1/config_data[11]}]  \
  [get_pins {cb_data1/config_data[10]}]  \
  [get_pins {cb_data1/config_data[9]}]  \
  [get_pins {cb_data1/config_data[8]}]  \
  [get_pins {cb_data1/config_data[7]}]  \
  [get_pins {cb_data1/config_data[6]}]  \
  [get_pins {cb_data1/config_data[5]}]  \
  [get_pins {cb_data1/config_data[4]}]  \
  [get_pins {cb_data1/config_data[3]}]  \
  [get_pins {cb_data1/config_data[2]}]  \
  [get_pins {cb_data1/config_data[1]}]  \
  [get_pins {cb_data1/config_data[0]}]  \
  [get_pins cb_data1/config_en]  \
  [get_pins cb_bit0/clk]  \
  [get_pins cb_bit0/reset]  \
  [get_pins {cb_bit0/in_0[0]}]  \
  [get_pins {cb_bit0/in_1[0]}]  \
  [get_pins {cb_bit0/in_2[0]}]  \
  [get_pins {cb_bit0/in_3[0]}]  \
  [get_pins {cb_bit0/in_4[0]}]  \
  [get_pins {cb_bit0/in_5[0]}]  \
  [get_pins {cb_bit0/in_6[0]}]  \
  [get_pins {cb_bit0/in_7[0]}]  \
  [get_pins {cb_bit0/in_8[0]}]  \
  [get_pins {cb_bit0/in_9[0]}]  \
  [get_pins {cb_bit0/in_10[0]}]  \
  [get_pins {cb_bit0/in_11[0]}]  \
  [get_pins {cb_bit0/in_12[0]}]  \
  [get_pins {cb_bit0/in_13[0]}]  \
  [get_pins {cb_bit0/config_addr[31]}]  \
  [get_pins {cb_bit0/config_addr[30]}]  \
  [get_pins {cb_bit0/config_addr[29]}]  \
  [get_pins {cb_bit0/config_addr[28]}]  \
  [get_pins {cb_bit0/config_addr[27]}]  \
  [get_pins {cb_bit0/config_addr[26]}]  \
  [get_pins {cb_bit0/config_addr[25]}]  \
  [get_pins {cb_bit0/config_addr[24]}]  \
  [get_pins {cb_bit0/config_addr[23]}]  \
  [get_pins {cb_bit0/config_addr[22]}]  \
  [get_pins {cb_bit0/config_addr[21]}]  \
  [get_pins {cb_bit0/config_addr[20]}]  \
  [get_pins {cb_bit0/config_addr[19]}]  \
  [get_pins {cb_bit0/config_addr[18]}]  \
  [get_pins {cb_bit0/config_addr[17]}]  \
  [get_pins {cb_bit0/config_addr[16]}]  \
  [get_pins {cb_bit0/config_addr[15]}]  \
  [get_pins {cb_bit0/config_addr[14]}]  \
  [get_pins {cb_bit0/config_addr[13]}]  \
  [get_pins {cb_bit0/config_addr[12]}]  \
  [get_pins {cb_bit0/config_addr[11]}]  \
  [get_pins {cb_bit0/config_addr[10]}]  \
  [get_pins {cb_bit0/config_addr[9]}]  \
  [get_pins {cb_bit0/config_addr[8]}]  \
  [get_pins {cb_bit0/config_addr[7]}]  \
  [get_pins {cb_bit0/config_addr[6]}]  \
  [get_pins {cb_bit0/config_addr[5]}]  \
  [get_pins {cb_bit0/config_addr[4]}]  \
  [get_pins {cb_bit0/config_addr[3]}]  \
  [get_pins {cb_bit0/config_addr[2]}]  \
  [get_pins {cb_bit0/config_addr[1]}]  \
  [get_pins {cb_bit0/config_addr[0]}]  \
  [get_pins {cb_bit0/config_data[31]}]  \
  [get_pins {cb_bit0/config_data[30]}]  \
  [get_pins {cb_bit0/config_data[29]}]  \
  [get_pins {cb_bit0/config_data[28]}]  \
  [get_pins {cb_bit0/config_data[27]}]  \
  [get_pins {cb_bit0/config_data[26]}]  \
  [get_pins {cb_bit0/config_data[25]}]  \
  [get_pins {cb_bit0/config_data[24]}]  \
  [get_pins {cb_bit0/config_data[23]}]  \
  [get_pins {cb_bit0/config_data[22]}]  \
  [get_pins {cb_bit0/config_data[21]}]  \
  [get_pins {cb_bit0/config_data[20]}]  \
  [get_pins {cb_bit0/config_data[19]}]  \
  [get_pins {cb_bit0/config_data[18]}]  \
  [get_pins {cb_bit0/config_data[17]}]  \
  [get_pins {cb_bit0/config_data[16]}]  \
  [get_pins {cb_bit0/config_data[15]}]  \
  [get_pins {cb_bit0/config_data[14]}]  \
  [get_pins {cb_bit0/config_data[13]}]  \
  [get_pins {cb_bit0/config_data[12]}]  \
  [get_pins {cb_bit0/config_data[11]}]  \
  [get_pins {cb_bit0/config_data[10]}]  \
  [get_pins {cb_bit0/config_data[9]}]  \
  [get_pins {cb_bit0/config_data[8]}]  \
  [get_pins {cb_bit0/config_data[7]}]  \
  [get_pins {cb_bit0/config_data[6]}]  \
  [get_pins {cb_bit0/config_data[5]}]  \
  [get_pins {cb_bit0/config_data[4]}]  \
  [get_pins {cb_bit0/config_data[3]}]  \
  [get_pins {cb_bit0/config_data[2]}]  \
  [get_pins {cb_bit0/config_data[1]}]  \
  [get_pins {cb_bit0/config_data[0]}]  \
  [get_pins cb_bit0/config_en]  \
  [get_pins cb_bit1/clk]  \
  [get_pins cb_bit1/reset]  \
  [get_pins {cb_bit1/in_0[0]}]  \
  [get_pins {cb_bit1/in_1[0]}]  \
  [get_pins {cb_bit1/in_2[0]}]  \
  [get_pins {cb_bit1/in_3[0]}]  \
  [get_pins {cb_bit1/in_4[0]}]  \
  [get_pins {cb_bit1/in_5[0]}]  \
  [get_pins {cb_bit1/in_6[0]}]  \
  [get_pins {cb_bit1/in_7[0]}]  \
  [get_pins {cb_bit1/in_8[0]}]  \
  [get_pins {cb_bit1/in_9[0]}]  \
  [get_pins {cb_bit1/in_10[0]}]  \
  [get_pins {cb_bit1/in_11[0]}]  \
  [get_pins {cb_bit1/in_12[0]}]  \
  [get_pins {cb_bit1/in_13[0]}]  \
  [get_pins {cb_bit1/config_addr[31]}]  \
  [get_pins {cb_bit1/config_addr[30]}]  \
  [get_pins {cb_bit1/config_addr[29]}]  \
  [get_pins {cb_bit1/config_addr[28]}]  \
  [get_pins {cb_bit1/config_addr[27]}]  \
  [get_pins {cb_bit1/config_addr[26]}]  \
  [get_pins {cb_bit1/config_addr[25]}]  \
  [get_pins {cb_bit1/config_addr[24]}]  \
  [get_pins {cb_bit1/config_addr[23]}]  \
  [get_pins {cb_bit1/config_addr[22]}]  \
  [get_pins {cb_bit1/config_addr[21]}]  \
  [get_pins {cb_bit1/config_addr[20]}]  \
  [get_pins {cb_bit1/config_addr[19]}]  \
  [get_pins {cb_bit1/config_addr[18]}]  \
  [get_pins {cb_bit1/config_addr[17]}]  \
  [get_pins {cb_bit1/config_addr[16]}]  \
  [get_pins {cb_bit1/config_addr[15]}]  \
  [get_pins {cb_bit1/config_addr[14]}]  \
  [get_pins {cb_bit1/config_addr[13]}]  \
  [get_pins {cb_bit1/config_addr[12]}]  \
  [get_pins {cb_bit1/config_addr[11]}]  \
  [get_pins {cb_bit1/config_addr[10]}]  \
  [get_pins {cb_bit1/config_addr[9]}]  \
  [get_pins {cb_bit1/config_addr[8]}]  \
  [get_pins {cb_bit1/config_addr[7]}]  \
  [get_pins {cb_bit1/config_addr[6]}]  \
  [get_pins {cb_bit1/config_addr[5]}]  \
  [get_pins {cb_bit1/config_addr[4]}]  \
  [get_pins {cb_bit1/config_addr[3]}]  \
  [get_pins {cb_bit1/config_addr[2]}]  \
  [get_pins {cb_bit1/config_addr[1]}]  \
  [get_pins {cb_bit1/config_addr[0]}]  \
  [get_pins {cb_bit1/config_data[31]}]  \
  [get_pins {cb_bit1/config_data[30]}]  \
  [get_pins {cb_bit1/config_data[29]}]  \
  [get_pins {cb_bit1/config_data[28]}]  \
  [get_pins {cb_bit1/config_data[27]}]  \
  [get_pins {cb_bit1/config_data[26]}]  \
  [get_pins {cb_bit1/config_data[25]}]  \
  [get_pins {cb_bit1/config_data[24]}]  \
  [get_pins {cb_bit1/config_data[23]}]  \
  [get_pins {cb_bit1/config_data[22]}]  \
  [get_pins {cb_bit1/config_data[21]}]  \
  [get_pins {cb_bit1/config_data[20]}]  \
  [get_pins {cb_bit1/config_data[19]}]  \
  [get_pins {cb_bit1/config_data[18]}]  \
  [get_pins {cb_bit1/config_data[17]}]  \
  [get_pins {cb_bit1/config_data[16]}]  \
  [get_pins {cb_bit1/config_data[15]}]  \
  [get_pins {cb_bit1/config_data[14]}]  \
  [get_pins {cb_bit1/config_data[13]}]  \
  [get_pins {cb_bit1/config_data[12]}]  \
  [get_pins {cb_bit1/config_data[11]}]  \
  [get_pins {cb_bit1/config_data[10]}]  \
  [get_pins {cb_bit1/config_data[9]}]  \
  [get_pins {cb_bit1/config_data[8]}]  \
  [get_pins {cb_bit1/config_data[7]}]  \
  [get_pins {cb_bit1/config_data[6]}]  \
  [get_pins {cb_bit1/config_data[5]}]  \
  [get_pins {cb_bit1/config_data[4]}]  \
  [get_pins {cb_bit1/config_data[3]}]  \
  [get_pins {cb_bit1/config_data[2]}]  \
  [get_pins {cb_bit1/config_data[1]}]  \
  [get_pins {cb_bit1/config_data[0]}]  \
  [get_pins cb_bit1/config_en]  \
  [get_pins cb_bit2/clk]  \
  [get_pins cb_bit2/reset]  \
  [get_pins {cb_bit2/in_0[0]}]  \
  [get_pins {cb_bit2/in_1[0]}]  \
  [get_pins {cb_bit2/in_2[0]}]  \
  [get_pins {cb_bit2/in_3[0]}]  \
  [get_pins {cb_bit2/in_4[0]}]  \
  [get_pins {cb_bit2/in_5[0]}]  \
  [get_pins {cb_bit2/in_6[0]}]  \
  [get_pins {cb_bit2/in_7[0]}]  \
  [get_pins {cb_bit2/in_8[0]}]  \
  [get_pins {cb_bit2/in_9[0]}]  \
  [get_pins {cb_bit2/in_10[0]}]  \
  [get_pins {cb_bit2/in_11[0]}]  \
  [get_pins {cb_bit2/in_12[0]}]  \
  [get_pins {cb_bit2/in_13[0]}]  \
  [get_pins {cb_bit2/config_addr[31]}]  \
  [get_pins {cb_bit2/config_addr[30]}]  \
  [get_pins {cb_bit2/config_addr[29]}]  \
  [get_pins {cb_bit2/config_addr[28]}]  \
  [get_pins {cb_bit2/config_addr[27]}]  \
  [get_pins {cb_bit2/config_addr[26]}]  \
  [get_pins {cb_bit2/config_addr[25]}]  \
  [get_pins {cb_bit2/config_addr[24]}]  \
  [get_pins {cb_bit2/config_addr[23]}]  \
  [get_pins {cb_bit2/config_addr[22]}]  \
  [get_pins {cb_bit2/config_addr[21]}]  \
  [get_pins {cb_bit2/config_addr[20]}]  \
  [get_pins {cb_bit2/config_addr[19]}]  \
  [get_pins {cb_bit2/config_addr[18]}]  \
  [get_pins {cb_bit2/config_addr[17]}]  \
  [get_pins {cb_bit2/config_addr[16]}]  \
  [get_pins {cb_bit2/config_addr[15]}]  \
  [get_pins {cb_bit2/config_addr[14]}]  \
  [get_pins {cb_bit2/config_addr[13]}]  \
  [get_pins {cb_bit2/config_addr[12]}]  \
  [get_pins {cb_bit2/config_addr[11]}]  \
  [get_pins {cb_bit2/config_addr[10]}]  \
  [get_pins {cb_bit2/config_addr[9]}]  \
  [get_pins {cb_bit2/config_addr[8]}]  \
  [get_pins {cb_bit2/config_addr[7]}]  \
  [get_pins {cb_bit2/config_addr[6]}]  \
  [get_pins {cb_bit2/config_addr[5]}]  \
  [get_pins {cb_bit2/config_addr[4]}]  \
  [get_pins {cb_bit2/config_addr[3]}]  \
  [get_pins {cb_bit2/config_addr[2]}]  \
  [get_pins {cb_bit2/config_addr[1]}]  \
  [get_pins {cb_bit2/config_addr[0]}]  \
  [get_pins {cb_bit2/config_data[31]}]  \
  [get_pins {cb_bit2/config_data[30]}]  \
  [get_pins {cb_bit2/config_data[29]}]  \
  [get_pins {cb_bit2/config_data[28]}]  \
  [get_pins {cb_bit2/config_data[27]}]  \
  [get_pins {cb_bit2/config_data[26]}]  \
  [get_pins {cb_bit2/config_data[25]}]  \
  [get_pins {cb_bit2/config_data[24]}]  \
  [get_pins {cb_bit2/config_data[23]}]  \
  [get_pins {cb_bit2/config_data[22]}]  \
  [get_pins {cb_bit2/config_data[21]}]  \
  [get_pins {cb_bit2/config_data[20]}]  \
  [get_pins {cb_bit2/config_data[19]}]  \
  [get_pins {cb_bit2/config_data[18]}]  \
  [get_pins {cb_bit2/config_data[17]}]  \
  [get_pins {cb_bit2/config_data[16]}]  \
  [get_pins {cb_bit2/config_data[15]}]  \
  [get_pins {cb_bit2/config_data[14]}]  \
  [get_pins {cb_bit2/config_data[13]}]  \
  [get_pins {cb_bit2/config_data[12]}]  \
  [get_pins {cb_bit2/config_data[11]}]  \
  [get_pins {cb_bit2/config_data[10]}]  \
  [get_pins {cb_bit2/config_data[9]}]  \
  [get_pins {cb_bit2/config_data[8]}]  \
  [get_pins {cb_bit2/config_data[7]}]  \
  [get_pins {cb_bit2/config_data[6]}]  \
  [get_pins {cb_bit2/config_data[5]}]  \
  [get_pins {cb_bit2/config_data[4]}]  \
  [get_pins {cb_bit2/config_data[3]}]  \
  [get_pins {cb_bit2/config_data[2]}]  \
  [get_pins {cb_bit2/config_data[1]}]  \
  [get_pins {cb_bit2/config_data[0]}]  \
  [get_pins cb_bit2/config_en]  \
  [get_pins cb_cg_en/clk]  \
  [get_pins cb_cg_en/reset]  \
  [get_pins {cb_cg_en/in_0[0]}]  \
  [get_pins {cb_cg_en/in_1[0]}]  \
  [get_pins {cb_cg_en/in_2[0]}]  \
  [get_pins {cb_cg_en/in_3[0]}]  \
  [get_pins {cb_cg_en/in_4[0]}]  \
  [get_pins {cb_cg_en/in_5[0]}]  \
  [get_pins {cb_cg_en/in_6[0]}]  \
  [get_pins {cb_cg_en/in_7[0]}]  \
  [get_pins {cb_cg_en/in_8[0]}]  \
  [get_pins {cb_cg_en/in_9[0]}]  \
  [get_pins {cb_cg_en/in_10[0]}]  \
  [get_pins {cb_cg_en/in_11[0]}]  \
  [get_pins {cb_cg_en/in_12[0]}]  \
  [get_pins {cb_cg_en/in_13[0]}]  \
  [get_pins {cb_cg_en/config_addr[31]}]  \
  [get_pins {cb_cg_en/config_addr[30]}]  \
  [get_pins {cb_cg_en/config_addr[29]}]  \
  [get_pins {cb_cg_en/config_addr[28]}]  \
  [get_pins {cb_cg_en/config_addr[27]}]  \
  [get_pins {cb_cg_en/config_addr[26]}]  \
  [get_pins {cb_cg_en/config_addr[25]}]  \
  [get_pins {cb_cg_en/config_addr[24]}]  \
  [get_pins {cb_cg_en/config_addr[23]}]  \
  [get_pins {cb_cg_en/config_addr[22]}]  \
  [get_pins {cb_cg_en/config_addr[21]}]  \
  [get_pins {cb_cg_en/config_addr[20]}]  \
  [get_pins {cb_cg_en/config_addr[19]}]  \
  [get_pins {cb_cg_en/config_addr[18]}]  \
  [get_pins {cb_cg_en/config_addr[17]}]  \
  [get_pins {cb_cg_en/config_addr[16]}]  \
  [get_pins {cb_cg_en/config_addr[15]}]  \
  [get_pins {cb_cg_en/config_addr[14]}]  \
  [get_pins {cb_cg_en/config_addr[13]}]  \
  [get_pins {cb_cg_en/config_addr[12]}]  \
  [get_pins {cb_cg_en/config_addr[11]}]  \
  [get_pins {cb_cg_en/config_addr[10]}]  \
  [get_pins {cb_cg_en/config_addr[9]}]  \
  [get_pins {cb_cg_en/config_addr[8]}]  \
  [get_pins {cb_cg_en/config_addr[7]}]  \
  [get_pins {cb_cg_en/config_addr[6]}]  \
  [get_pins {cb_cg_en/config_addr[5]}]  \
  [get_pins {cb_cg_en/config_addr[4]}]  \
  [get_pins {cb_cg_en/config_addr[3]}]  \
  [get_pins {cb_cg_en/config_addr[2]}]  \
  [get_pins {cb_cg_en/config_addr[1]}]  \
  [get_pins {cb_cg_en/config_addr[0]}]  \
  [get_pins {cb_cg_en/config_data[31]}]  \
  [get_pins {cb_cg_en/config_data[30]}]  \
  [get_pins {cb_cg_en/config_data[29]}]  \
  [get_pins {cb_cg_en/config_data[28]}]  \
  [get_pins {cb_cg_en/config_data[27]}]  \
  [get_pins {cb_cg_en/config_data[26]}]  \
  [get_pins {cb_cg_en/config_data[25]}]  \
  [get_pins {cb_cg_en/config_data[24]}]  \
  [get_pins {cb_cg_en/config_data[23]}]  \
  [get_pins {cb_cg_en/config_data[22]}]  \
  [get_pins {cb_cg_en/config_data[21]}]  \
  [get_pins {cb_cg_en/config_data[20]}]  \
  [get_pins {cb_cg_en/config_data[19]}]  \
  [get_pins {cb_cg_en/config_data[18]}]  \
  [get_pins {cb_cg_en/config_data[17]}]  \
  [get_pins {cb_cg_en/config_data[16]}]  \
  [get_pins {cb_cg_en/config_data[15]}]  \
  [get_pins {cb_cg_en/config_data[14]}]  \
  [get_pins {cb_cg_en/config_data[13]}]  \
  [get_pins {cb_cg_en/config_data[12]}]  \
  [get_pins {cb_cg_en/config_data[11]}]  \
  [get_pins {cb_cg_en/config_data[10]}]  \
  [get_pins {cb_cg_en/config_data[9]}]  \
  [get_pins {cb_cg_en/config_data[8]}]  \
  [get_pins {cb_cg_en/config_data[7]}]  \
  [get_pins {cb_cg_en/config_data[6]}]  \
  [get_pins {cb_cg_en/config_data[5]}]  \
  [get_pins {cb_cg_en/config_data[4]}]  \
  [get_pins {cb_cg_en/config_data[3]}]  \
  [get_pins {cb_cg_en/config_data[2]}]  \
  [get_pins {cb_cg_en/config_data[1]}]  \
  [get_pins {cb_cg_en/config_data[0]}]  \
  [get_pins cb_cg_en/config_en] ]
set_false_path -from [list \
  [get_ports {config_addr[31]}]  \
  [get_ports {config_addr[30]}]  \
  [get_ports {config_addr[29]}]  \
  [get_ports {config_addr[28]}]  \
  [get_ports {config_addr[27]}]  \
  [get_ports {config_addr[26]}]  \
  [get_ports {config_addr[25]}]  \
  [get_ports {config_addr[24]}]  \
  [get_ports {config_addr[23]}]  \
  [get_ports {config_addr[22]}]  \
  [get_ports {config_addr[21]}]  \
  [get_ports {config_addr[20]}]  \
  [get_ports {config_addr[19]}]  \
  [get_ports {config_addr[18]}]  \
  [get_ports {config_addr[17]}]  \
  [get_ports {config_addr[16]}]  \
  [get_ports {config_addr[15]}]  \
  [get_ports {config_addr[14]}]  \
  [get_ports {config_addr[13]}]  \
  [get_ports {config_addr[12]}]  \
  [get_ports {config_addr[11]}]  \
  [get_ports {config_addr[10]}]  \
  [get_ports {config_addr[9]}]  \
  [get_ports {config_addr[8]}]  \
  [get_ports {config_addr[7]}]  \
  [get_ports {config_addr[6]}]  \
  [get_ports {config_addr[5]}]  \
  [get_ports {config_addr[4]}]  \
  [get_ports {config_addr[3]}]  \
  [get_ports {config_addr[2]}]  \
  [get_ports {config_addr[1]}]  \
  [get_ports {config_addr[0]}]  \
  [get_ports {config_data[31]}]  \
  [get_ports {config_data[30]}]  \
  [get_ports {config_data[29]}]  \
  [get_ports {config_data[28]}]  \
  [get_ports {config_data[27]}]  \
  [get_ports {config_data[26]}]  \
  [get_ports {config_data[25]}]  \
  [get_ports {config_data[24]}]  \
  [get_ports {config_data[23]}]  \
  [get_ports {config_data[22]}]  \
  [get_ports {config_data[21]}]  \
  [get_ports {config_data[20]}]  \
  [get_ports {config_data[19]}]  \
  [get_ports {config_data[18]}]  \
  [get_ports {config_data[17]}]  \
  [get_ports {config_data[16]}]  \
  [get_ports {config_data[15]}]  \
  [get_ports {config_data[14]}]  \
  [get_ports {config_data[13]}]  \
  [get_ports {config_data[12]}]  \
  [get_ports {config_data[11]}]  \
  [get_ports {config_data[10]}]  \
  [get_ports {config_data[9]}]  \
  [get_ports {config_data[8]}]  \
  [get_ports {config_data[7]}]  \
  [get_ports {config_data[6]}]  \
  [get_ports {config_data[5]}]  \
  [get_ports {config_data[4]}]  \
  [get_ports {config_data[3]}]  \
  [get_ports {config_data[2]}]  \
  [get_ports {config_data[1]}]  \
  [get_ports {config_data[0]}]  \
  [get_ports config_read]  \
  [get_ports config_write]  \
  [get_ports {tile_id[15]}]  \
  [get_ports {tile_id[14]}]  \
  [get_ports {tile_id[13]}]  \
  [get_ports {tile_id[12]}]  \
  [get_ports {tile_id[11]}]  \
  [get_ports {tile_id[10]}]  \
  [get_ports {tile_id[9]}]  \
  [get_ports {tile_id[8]}]  \
  [get_ports {tile_id[7]}]  \
  [get_ports {tile_id[6]}]  \
  [get_ports {tile_id[5]}]  \
  [get_ports {tile_id[4]}]  \
  [get_ports {tile_id[3]}]  \
  [get_ports {tile_id[2]}]  \
  [get_ports {tile_id[1]}]  \
  [get_ports {tile_id[0]}]  \
  [get_ports reset] ] -to [list \
  [get_ports {out_BUS1_S0_T0[0]}]  \
  [get_ports {out_BUS1_S0_T1[0]}]  \
  [get_ports {out_BUS1_S0_T2[0]}]  \
  [get_ports {out_BUS1_S0_T3[0]}]  \
  [get_ports {out_BUS1_S0_T4[0]}]  \
  [get_ports {out_BUS1_S1_T0[0]}]  \
  [get_ports {out_BUS1_S1_T1[0]}]  \
  [get_ports {out_BUS1_S1_T2[0]}]  \
  [get_ports {out_BUS1_S1_T3[0]}]  \
  [get_ports {out_BUS1_S1_T4[0]}]  \
  [get_ports {out_BUS1_S2_T0[0]}]  \
  [get_ports {out_BUS1_S2_T1[0]}]  \
  [get_ports {out_BUS1_S2_T2[0]}]  \
  [get_ports {out_BUS1_S2_T3[0]}]  \
  [get_ports {out_BUS1_S2_T4[0]}]  \
  [get_ports {out_BUS1_S3_T0[0]}]  \
  [get_ports {out_BUS1_S3_T1[0]}]  \
  [get_ports {out_BUS1_S3_T2[0]}]  \
  [get_ports {out_BUS1_S3_T3[0]}]  \
  [get_ports {out_BUS1_S3_T4[0]}]  \
  [get_ports {out_BUS16_S0_T0[15]}]  \
  [get_ports {out_BUS16_S0_T0[14]}]  \
  [get_ports {out_BUS16_S0_T0[13]}]  \
  [get_ports {out_BUS16_S0_T0[12]}]  \
  [get_ports {out_BUS16_S0_T0[11]}]  \
  [get_ports {out_BUS16_S0_T0[10]}]  \
  [get_ports {out_BUS16_S0_T0[9]}]  \
  [get_ports {out_BUS16_S0_T0[8]}]  \
  [get_ports {out_BUS16_S0_T0[7]}]  \
  [get_ports {out_BUS16_S0_T0[6]}]  \
  [get_ports {out_BUS16_S0_T0[5]}]  \
  [get_ports {out_BUS16_S0_T0[4]}]  \
  [get_ports {out_BUS16_S0_T0[3]}]  \
  [get_ports {out_BUS16_S0_T0[2]}]  \
  [get_ports {out_BUS16_S0_T0[1]}]  \
  [get_ports {out_BUS16_S0_T0[0]}]  \
  [get_ports {out_BUS16_S0_T1[15]}]  \
  [get_ports {out_BUS16_S0_T1[14]}]  \
  [get_ports {out_BUS16_S0_T1[13]}]  \
  [get_ports {out_BUS16_S0_T1[12]}]  \
  [get_ports {out_BUS16_S0_T1[11]}]  \
  [get_ports {out_BUS16_S0_T1[10]}]  \
  [get_ports {out_BUS16_S0_T1[9]}]  \
  [get_ports {out_BUS16_S0_T1[8]}]  \
  [get_ports {out_BUS16_S0_T1[7]}]  \
  [get_ports {out_BUS16_S0_T1[6]}]  \
  [get_ports {out_BUS16_S0_T1[5]}]  \
  [get_ports {out_BUS16_S0_T1[4]}]  \
  [get_ports {out_BUS16_S0_T1[3]}]  \
  [get_ports {out_BUS16_S0_T1[2]}]  \
  [get_ports {out_BUS16_S0_T1[1]}]  \
  [get_ports {out_BUS16_S0_T1[0]}]  \
  [get_ports {out_BUS16_S0_T2[15]}]  \
  [get_ports {out_BUS16_S0_T2[14]}]  \
  [get_ports {out_BUS16_S0_T2[13]}]  \
  [get_ports {out_BUS16_S0_T2[12]}]  \
  [get_ports {out_BUS16_S0_T2[11]}]  \
  [get_ports {out_BUS16_S0_T2[10]}]  \
  [get_ports {out_BUS16_S0_T2[9]}]  \
  [get_ports {out_BUS16_S0_T2[8]}]  \
  [get_ports {out_BUS16_S0_T2[7]}]  \
  [get_ports {out_BUS16_S0_T2[6]}]  \
  [get_ports {out_BUS16_S0_T2[5]}]  \
  [get_ports {out_BUS16_S0_T2[4]}]  \
  [get_ports {out_BUS16_S0_T2[3]}]  \
  [get_ports {out_BUS16_S0_T2[2]}]  \
  [get_ports {out_BUS16_S0_T2[1]}]  \
  [get_ports {out_BUS16_S0_T2[0]}]  \
  [get_ports {out_BUS16_S0_T3[15]}]  \
  [get_ports {out_BUS16_S0_T3[14]}]  \
  [get_ports {out_BUS16_S0_T3[13]}]  \
  [get_ports {out_BUS16_S0_T3[12]}]  \
  [get_ports {out_BUS16_S0_T3[11]}]  \
  [get_ports {out_BUS16_S0_T3[10]}]  \
  [get_ports {out_BUS16_S0_T3[9]}]  \
  [get_ports {out_BUS16_S0_T3[8]}]  \
  [get_ports {out_BUS16_S0_T3[7]}]  \
  [get_ports {out_BUS16_S0_T3[6]}]  \
  [get_ports {out_BUS16_S0_T3[5]}]  \
  [get_ports {out_BUS16_S0_T3[4]}]  \
  [get_ports {out_BUS16_S0_T3[3]}]  \
  [get_ports {out_BUS16_S0_T3[2]}]  \
  [get_ports {out_BUS16_S0_T3[1]}]  \
  [get_ports {out_BUS16_S0_T3[0]}]  \
  [get_ports {out_BUS16_S0_T4[15]}]  \
  [get_ports {out_BUS16_S0_T4[14]}]  \
  [get_ports {out_BUS16_S0_T4[13]}]  \
  [get_ports {out_BUS16_S0_T4[12]}]  \
  [get_ports {out_BUS16_S0_T4[11]}]  \
  [get_ports {out_BUS16_S0_T4[10]}]  \
  [get_ports {out_BUS16_S0_T4[9]}]  \
  [get_ports {out_BUS16_S0_T4[8]}]  \
  [get_ports {out_BUS16_S0_T4[7]}]  \
  [get_ports {out_BUS16_S0_T4[6]}]  \
  [get_ports {out_BUS16_S0_T4[5]}]  \
  [get_ports {out_BUS16_S0_T4[4]}]  \
  [get_ports {out_BUS16_S0_T4[3]}]  \
  [get_ports {out_BUS16_S0_T4[2]}]  \
  [get_ports {out_BUS16_S0_T4[1]}]  \
  [get_ports {out_BUS16_S0_T4[0]}]  \
  [get_ports {out_BUS16_S1_T0[15]}]  \
  [get_ports {out_BUS16_S1_T0[14]}]  \
  [get_ports {out_BUS16_S1_T0[13]}]  \
  [get_ports {out_BUS16_S1_T0[12]}]  \
  [get_ports {out_BUS16_S1_T0[11]}]  \
  [get_ports {out_BUS16_S1_T0[10]}]  \
  [get_ports {out_BUS16_S1_T0[9]}]  \
  [get_ports {out_BUS16_S1_T0[8]}]  \
  [get_ports {out_BUS16_S1_T0[7]}]  \
  [get_ports {out_BUS16_S1_T0[6]}]  \
  [get_ports {out_BUS16_S1_T0[5]}]  \
  [get_ports {out_BUS16_S1_T0[4]}]  \
  [get_ports {out_BUS16_S1_T0[3]}]  \
  [get_ports {out_BUS16_S1_T0[2]}]  \
  [get_ports {out_BUS16_S1_T0[1]}]  \
  [get_ports {out_BUS16_S1_T0[0]}]  \
  [get_ports {out_BUS16_S1_T1[15]}]  \
  [get_ports {out_BUS16_S1_T1[14]}]  \
  [get_ports {out_BUS16_S1_T1[13]}]  \
  [get_ports {out_BUS16_S1_T1[12]}]  \
  [get_ports {out_BUS16_S1_T1[11]}]  \
  [get_ports {out_BUS16_S1_T1[10]}]  \
  [get_ports {out_BUS16_S1_T1[9]}]  \
  [get_ports {out_BUS16_S1_T1[8]}]  \
  [get_ports {out_BUS16_S1_T1[7]}]  \
  [get_ports {out_BUS16_S1_T1[6]}]  \
  [get_ports {out_BUS16_S1_T1[5]}]  \
  [get_ports {out_BUS16_S1_T1[4]}]  \
  [get_ports {out_BUS16_S1_T1[3]}]  \
  [get_ports {out_BUS16_S1_T1[2]}]  \
  [get_ports {out_BUS16_S1_T1[1]}]  \
  [get_ports {out_BUS16_S1_T1[0]}]  \
  [get_ports {out_BUS16_S1_T2[15]}]  \
  [get_ports {out_BUS16_S1_T2[14]}]  \
  [get_ports {out_BUS16_S1_T2[13]}]  \
  [get_ports {out_BUS16_S1_T2[12]}]  \
  [get_ports {out_BUS16_S1_T2[11]}]  \
  [get_ports {out_BUS16_S1_T2[10]}]  \
  [get_ports {out_BUS16_S1_T2[9]}]  \
  [get_ports {out_BUS16_S1_T2[8]}]  \
  [get_ports {out_BUS16_S1_T2[7]}]  \
  [get_ports {out_BUS16_S1_T2[6]}]  \
  [get_ports {out_BUS16_S1_T2[5]}]  \
  [get_ports {out_BUS16_S1_T2[4]}]  \
  [get_ports {out_BUS16_S1_T2[3]}]  \
  [get_ports {out_BUS16_S1_T2[2]}]  \
  [get_ports {out_BUS16_S1_T2[1]}]  \
  [get_ports {out_BUS16_S1_T2[0]}]  \
  [get_ports {out_BUS16_S1_T3[15]}]  \
  [get_ports {out_BUS16_S1_T3[14]}]  \
  [get_ports {out_BUS16_S1_T3[13]}]  \
  [get_ports {out_BUS16_S1_T3[12]}]  \
  [get_ports {out_BUS16_S1_T3[11]}]  \
  [get_ports {out_BUS16_S1_T3[10]}]  \
  [get_ports {out_BUS16_S1_T3[9]}]  \
  [get_ports {out_BUS16_S1_T3[8]}]  \
  [get_ports {out_BUS16_S1_T3[7]}]  \
  [get_ports {out_BUS16_S1_T3[6]}]  \
  [get_ports {out_BUS16_S1_T3[5]}]  \
  [get_ports {out_BUS16_S1_T3[4]}]  \
  [get_ports {out_BUS16_S1_T3[3]}]  \
  [get_ports {out_BUS16_S1_T3[2]}]  \
  [get_ports {out_BUS16_S1_T3[1]}]  \
  [get_ports {out_BUS16_S1_T3[0]}]  \
  [get_ports {out_BUS16_S1_T4[15]}]  \
  [get_ports {out_BUS16_S1_T4[14]}]  \
  [get_ports {out_BUS16_S1_T4[13]}]  \
  [get_ports {out_BUS16_S1_T4[12]}]  \
  [get_ports {out_BUS16_S1_T4[11]}]  \
  [get_ports {out_BUS16_S1_T4[10]}]  \
  [get_ports {out_BUS16_S1_T4[9]}]  \
  [get_ports {out_BUS16_S1_T4[8]}]  \
  [get_ports {out_BUS16_S1_T4[7]}]  \
  [get_ports {out_BUS16_S1_T4[6]}]  \
  [get_ports {out_BUS16_S1_T4[5]}]  \
  [get_ports {out_BUS16_S1_T4[4]}]  \
  [get_ports {out_BUS16_S1_T4[3]}]  \
  [get_ports {out_BUS16_S1_T4[2]}]  \
  [get_ports {out_BUS16_S1_T4[1]}]  \
  [get_ports {out_BUS16_S1_T4[0]}]  \
  [get_ports {out_BUS16_S2_T0[15]}]  \
  [get_ports {out_BUS16_S2_T0[14]}]  \
  [get_ports {out_BUS16_S2_T0[13]}]  \
  [get_ports {out_BUS16_S2_T0[12]}]  \
  [get_ports {out_BUS16_S2_T0[11]}]  \
  [get_ports {out_BUS16_S2_T0[10]}]  \
  [get_ports {out_BUS16_S2_T0[9]}]  \
  [get_ports {out_BUS16_S2_T0[8]}]  \
  [get_ports {out_BUS16_S2_T0[7]}]  \
  [get_ports {out_BUS16_S2_T0[6]}]  \
  [get_ports {out_BUS16_S2_T0[5]}]  \
  [get_ports {out_BUS16_S2_T0[4]}]  \
  [get_ports {out_BUS16_S2_T0[3]}]  \
  [get_ports {out_BUS16_S2_T0[2]}]  \
  [get_ports {out_BUS16_S2_T0[1]}]  \
  [get_ports {out_BUS16_S2_T0[0]}]  \
  [get_ports {out_BUS16_S2_T1[15]}]  \
  [get_ports {out_BUS16_S2_T1[14]}]  \
  [get_ports {out_BUS16_S2_T1[13]}]  \
  [get_ports {out_BUS16_S2_T1[12]}]  \
  [get_ports {out_BUS16_S2_T1[11]}]  \
  [get_ports {out_BUS16_S2_T1[10]}]  \
  [get_ports {out_BUS16_S2_T1[9]}]  \
  [get_ports {out_BUS16_S2_T1[8]}]  \
  [get_ports {out_BUS16_S2_T1[7]}]  \
  [get_ports {out_BUS16_S2_T1[6]}]  \
  [get_ports {out_BUS16_S2_T1[5]}]  \
  [get_ports {out_BUS16_S2_T1[4]}]  \
  [get_ports {out_BUS16_S2_T1[3]}]  \
  [get_ports {out_BUS16_S2_T1[2]}]  \
  [get_ports {out_BUS16_S2_T1[1]}]  \
  [get_ports {out_BUS16_S2_T1[0]}]  \
  [get_ports {out_BUS16_S2_T2[15]}]  \
  [get_ports {out_BUS16_S2_T2[14]}]  \
  [get_ports {out_BUS16_S2_T2[13]}]  \
  [get_ports {out_BUS16_S2_T2[12]}]  \
  [get_ports {out_BUS16_S2_T2[11]}]  \
  [get_ports {out_BUS16_S2_T2[10]}]  \
  [get_ports {out_BUS16_S2_T2[9]}]  \
  [get_ports {out_BUS16_S2_T2[8]}]  \
  [get_ports {out_BUS16_S2_T2[7]}]  \
  [get_ports {out_BUS16_S2_T2[6]}]  \
  [get_ports {out_BUS16_S2_T2[5]}]  \
  [get_ports {out_BUS16_S2_T2[4]}]  \
  [get_ports {out_BUS16_S2_T2[3]}]  \
  [get_ports {out_BUS16_S2_T2[2]}]  \
  [get_ports {out_BUS16_S2_T2[1]}]  \
  [get_ports {out_BUS16_S2_T2[0]}]  \
  [get_ports {out_BUS16_S2_T3[15]}]  \
  [get_ports {out_BUS16_S2_T3[14]}]  \
  [get_ports {out_BUS16_S2_T3[13]}]  \
  [get_ports {out_BUS16_S2_T3[12]}]  \
  [get_ports {out_BUS16_S2_T3[11]}]  \
  [get_ports {out_BUS16_S2_T3[10]}]  \
  [get_ports {out_BUS16_S2_T3[9]}]  \
  [get_ports {out_BUS16_S2_T3[8]}]  \
  [get_ports {out_BUS16_S2_T3[7]}]  \
  [get_ports {out_BUS16_S2_T3[6]}]  \
  [get_ports {out_BUS16_S2_T3[5]}]  \
  [get_ports {out_BUS16_S2_T3[4]}]  \
  [get_ports {out_BUS16_S2_T3[3]}]  \
  [get_ports {out_BUS16_S2_T3[2]}]  \
  [get_ports {out_BUS16_S2_T3[1]}]  \
  [get_ports {out_BUS16_S2_T3[0]}]  \
  [get_ports {out_BUS16_S2_T4[15]}]  \
  [get_ports {out_BUS16_S2_T4[14]}]  \
  [get_ports {out_BUS16_S2_T4[13]}]  \
  [get_ports {out_BUS16_S2_T4[12]}]  \
  [get_ports {out_BUS16_S2_T4[11]}]  \
  [get_ports {out_BUS16_S2_T4[10]}]  \
  [get_ports {out_BUS16_S2_T4[9]}]  \
  [get_ports {out_BUS16_S2_T4[8]}]  \
  [get_ports {out_BUS16_S2_T4[7]}]  \
  [get_ports {out_BUS16_S2_T4[6]}]  \
  [get_ports {out_BUS16_S2_T4[5]}]  \
  [get_ports {out_BUS16_S2_T4[4]}]  \
  [get_ports {out_BUS16_S2_T4[3]}]  \
  [get_ports {out_BUS16_S2_T4[2]}]  \
  [get_ports {out_BUS16_S2_T4[1]}]  \
  [get_ports {out_BUS16_S2_T4[0]}]  \
  [get_ports {out_BUS16_S3_T0[15]}]  \
  [get_ports {out_BUS16_S3_T0[14]}]  \
  [get_ports {out_BUS16_S3_T0[13]}]  \
  [get_ports {out_BUS16_S3_T0[12]}]  \
  [get_ports {out_BUS16_S3_T0[11]}]  \
  [get_ports {out_BUS16_S3_T0[10]}]  \
  [get_ports {out_BUS16_S3_T0[9]}]  \
  [get_ports {out_BUS16_S3_T0[8]}]  \
  [get_ports {out_BUS16_S3_T0[7]}]  \
  [get_ports {out_BUS16_S3_T0[6]}]  \
  [get_ports {out_BUS16_S3_T0[5]}]  \
  [get_ports {out_BUS16_S3_T0[4]}]  \
  [get_ports {out_BUS16_S3_T0[3]}]  \
  [get_ports {out_BUS16_S3_T0[2]}]  \
  [get_ports {out_BUS16_S3_T0[1]}]  \
  [get_ports {out_BUS16_S3_T0[0]}]  \
  [get_ports {out_BUS16_S3_T1[15]}]  \
  [get_ports {out_BUS16_S3_T1[14]}]  \
  [get_ports {out_BUS16_S3_T1[13]}]  \
  [get_ports {out_BUS16_S3_T1[12]}]  \
  [get_ports {out_BUS16_S3_T1[11]}]  \
  [get_ports {out_BUS16_S3_T1[10]}]  \
  [get_ports {out_BUS16_S3_T1[9]}]  \
  [get_ports {out_BUS16_S3_T1[8]}]  \
  [get_ports {out_BUS16_S3_T1[7]}]  \
  [get_ports {out_BUS16_S3_T1[6]}]  \
  [get_ports {out_BUS16_S3_T1[5]}]  \
  [get_ports {out_BUS16_S3_T1[4]}]  \
  [get_ports {out_BUS16_S3_T1[3]}]  \
  [get_ports {out_BUS16_S3_T1[2]}]  \
  [get_ports {out_BUS16_S3_T1[1]}]  \
  [get_ports {out_BUS16_S3_T1[0]}]  \
  [get_ports {out_BUS16_S3_T2[15]}]  \
  [get_ports {out_BUS16_S3_T2[14]}]  \
  [get_ports {out_BUS16_S3_T2[13]}]  \
  [get_ports {out_BUS16_S3_T2[12]}]  \
  [get_ports {out_BUS16_S3_T2[11]}]  \
  [get_ports {out_BUS16_S3_T2[10]}]  \
  [get_ports {out_BUS16_S3_T2[9]}]  \
  [get_ports {out_BUS16_S3_T2[8]}]  \
  [get_ports {out_BUS16_S3_T2[7]}]  \
  [get_ports {out_BUS16_S3_T2[6]}]  \
  [get_ports {out_BUS16_S3_T2[5]}]  \
  [get_ports {out_BUS16_S3_T2[4]}]  \
  [get_ports {out_BUS16_S3_T2[3]}]  \
  [get_ports {out_BUS16_S3_T2[2]}]  \
  [get_ports {out_BUS16_S3_T2[1]}]  \
  [get_ports {out_BUS16_S3_T2[0]}]  \
  [get_ports {out_BUS16_S3_T3[15]}]  \
  [get_ports {out_BUS16_S3_T3[14]}]  \
  [get_ports {out_BUS16_S3_T3[13]}]  \
  [get_ports {out_BUS16_S3_T3[12]}]  \
  [get_ports {out_BUS16_S3_T3[11]}]  \
  [get_ports {out_BUS16_S3_T3[10]}]  \
  [get_ports {out_BUS16_S3_T3[9]}]  \
  [get_ports {out_BUS16_S3_T3[8]}]  \
  [get_ports {out_BUS16_S3_T3[7]}]  \
  [get_ports {out_BUS16_S3_T3[6]}]  \
  [get_ports {out_BUS16_S3_T3[5]}]  \
  [get_ports {out_BUS16_S3_T3[4]}]  \
  [get_ports {out_BUS16_S3_T3[3]}]  \
  [get_ports {out_BUS16_S3_T3[2]}]  \
  [get_ports {out_BUS16_S3_T3[1]}]  \
  [get_ports {out_BUS16_S3_T3[0]}]  \
  [get_ports {out_BUS16_S3_T4[15]}]  \
  [get_ports {out_BUS16_S3_T4[14]}]  \
  [get_ports {out_BUS16_S3_T4[13]}]  \
  [get_ports {out_BUS16_S3_T4[12]}]  \
  [get_ports {out_BUS16_S3_T4[11]}]  \
  [get_ports {out_BUS16_S3_T4[10]}]  \
  [get_ports {out_BUS16_S3_T4[9]}]  \
  [get_ports {out_BUS16_S3_T4[8]}]  \
  [get_ports {out_BUS16_S3_T4[7]}]  \
  [get_ports {out_BUS16_S3_T4[6]}]  \
  [get_ports {out_BUS16_S3_T4[5]}]  \
  [get_ports {out_BUS16_S3_T4[4]}]  \
  [get_ports {out_BUS16_S3_T4[3]}]  \
  [get_ports {out_BUS16_S3_T4[2]}]  \
  [get_ports {out_BUS16_S3_T4[1]}]  \
  [get_ports {out_BUS16_S3_T4[0]}]  \
  [get_ports gout]  \
  [get_ports {read_data[31]}]  \
  [get_ports {read_data[30]}]  \
  [get_ports {read_data[29]}]  \
  [get_ports {read_data[28]}]  \
  [get_ports {read_data[27]}]  \
  [get_ports {read_data[26]}]  \
  [get_ports {read_data[25]}]  \
  [get_ports {read_data[24]}]  \
  [get_ports {read_data[23]}]  \
  [get_ports {read_data[22]}]  \
  [get_ports {read_data[21]}]  \
  [get_ports {read_data[20]}]  \
  [get_ports {read_data[19]}]  \
  [get_ports {read_data[18]}]  \
  [get_ports {read_data[17]}]  \
  [get_ports {read_data[16]}]  \
  [get_ports {read_data[15]}]  \
  [get_ports {read_data[14]}]  \
  [get_ports {read_data[13]}]  \
  [get_ports {read_data[12]}]  \
  [get_ports {read_data[11]}]  \
  [get_ports {read_data[10]}]  \
  [get_ports {read_data[9]}]  \
  [get_ports {read_data[8]}]  \
  [get_ports {read_data[7]}]  \
  [get_ports {read_data[6]}]  \
  [get_ports {read_data[5]}]  \
  [get_ports {read_data[4]}]  \
  [get_ports {read_data[3]}]  \
  [get_ports {read_data[2]}]  \
  [get_ports {read_data[1]}]  \
  [get_ports {read_data[0]}] ]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports clk_in]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[31]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[30]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[29]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[28]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[27]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[26]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[25]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[24]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[23]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[22]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[21]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[20]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[19]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[18]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[17]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[16]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_addr[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[31]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[30]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[29]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[28]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[27]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[26]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[25]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[24]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[23]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[22]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[21]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[20]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[19]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[18]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[17]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[16]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {config_data[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports config_read]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports config_write]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S0_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S0_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S0_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S0_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S0_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S1_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S1_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S1_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S1_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S1_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S2_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S2_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S2_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S2_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S2_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S3_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S3_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S3_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S3_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS1_S3_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S0_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S1_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S2_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {in_BUS16_S3_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports gin_0]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports gin_1]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports gin_2]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports gin_3]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {tile_id[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S0_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S0_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S0_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S0_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S0_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S1_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S1_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S1_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S1_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S1_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S2_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S2_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S2_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S2_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S2_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S3_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S3_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S3_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S3_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS1_S3_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S0_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S1_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S2_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {out_BUS16_S3_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports gout]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[31]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[30]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[29]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[28]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[27]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[26]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[25]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[24]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[23]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[22]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[21]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[20]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[19]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[18]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[17]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[16]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 0.2 [get_ports {read_data[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports clk_in]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[31]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[30]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[29]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[28]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[27]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[26]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[25]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[24]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[23]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[22]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[21]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[20]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[19]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[18]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[17]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[16]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_addr[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[31]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[30]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[29]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[28]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[27]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[26]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[25]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[24]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[23]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[22]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[21]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[20]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[19]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[18]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[17]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[16]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {config_data[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports config_read]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports config_write]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S0_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S0_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S0_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S0_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S0_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S1_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S1_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S1_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S1_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S1_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S2_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S2_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S2_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S2_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S2_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S3_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S3_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S3_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S3_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS1_S3_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S0_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S1_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S2_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T0[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T1[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T2[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T3[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {in_BUS16_S3_T4[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports gin_0]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports gin_1]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports gin_2]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports gin_3]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[15]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[14]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[13]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[12]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[11]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[10]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[9]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[8]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {tile_id[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S0_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S0_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S0_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S0_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S0_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S1_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S1_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S1_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S1_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S1_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S2_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S2_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S2_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S2_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S2_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S3_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S3_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S3_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S3_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS1_S3_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S0_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S1_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S2_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T0[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T1[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T2[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T3[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {out_BUS16_S3_T4[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports gout]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[31]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[30]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[29]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[28]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[27]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[26]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[25]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[24]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[23]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[22]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[21]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[20]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[19]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[18]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[17]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[16]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[15]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[14]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[13]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[12]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[11]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[10]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[9]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[8]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.0 [get_ports {read_data[0]}]
set_input_transition 0.2 [get_ports clk_in]
set_input_transition 0.2 [get_ports {config_addr[31]}]
set_input_transition 0.2 [get_ports {config_addr[30]}]
set_input_transition 0.2 [get_ports {config_addr[29]}]
set_input_transition 0.2 [get_ports {config_addr[28]}]
set_input_transition 0.2 [get_ports {config_addr[27]}]
set_input_transition 0.2 [get_ports {config_addr[26]}]
set_input_transition 0.2 [get_ports {config_addr[25]}]
set_input_transition 0.2 [get_ports {config_addr[24]}]
set_input_transition 0.2 [get_ports {config_addr[23]}]
set_input_transition 0.2 [get_ports {config_addr[22]}]
set_input_transition 0.2 [get_ports {config_addr[21]}]
set_input_transition 0.2 [get_ports {config_addr[20]}]
set_input_transition 0.2 [get_ports {config_addr[19]}]
set_input_transition 0.2 [get_ports {config_addr[18]}]
set_input_transition 0.2 [get_ports {config_addr[17]}]
set_input_transition 0.2 [get_ports {config_addr[16]}]
set_input_transition 0.2 [get_ports {config_addr[15]}]
set_input_transition 0.2 [get_ports {config_addr[14]}]
set_input_transition 0.2 [get_ports {config_addr[13]}]
set_input_transition 0.2 [get_ports {config_addr[12]}]
set_input_transition 0.2 [get_ports {config_addr[11]}]
set_input_transition 0.2 [get_ports {config_addr[10]}]
set_input_transition 0.2 [get_ports {config_addr[9]}]
set_input_transition 0.2 [get_ports {config_addr[8]}]
set_input_transition 0.2 [get_ports {config_addr[7]}]
set_input_transition 0.2 [get_ports {config_addr[6]}]
set_input_transition 0.2 [get_ports {config_addr[5]}]
set_input_transition 0.2 [get_ports {config_addr[4]}]
set_input_transition 0.2 [get_ports {config_addr[3]}]
set_input_transition 0.2 [get_ports {config_addr[2]}]
set_input_transition 0.2 [get_ports {config_addr[1]}]
set_input_transition 0.2 [get_ports {config_addr[0]}]
set_input_transition 0.2 [get_ports {config_data[31]}]
set_input_transition 0.2 [get_ports {config_data[30]}]
set_input_transition 0.2 [get_ports {config_data[29]}]
set_input_transition 0.2 [get_ports {config_data[28]}]
set_input_transition 0.2 [get_ports {config_data[27]}]
set_input_transition 0.2 [get_ports {config_data[26]}]
set_input_transition 0.2 [get_ports {config_data[25]}]
set_input_transition 0.2 [get_ports {config_data[24]}]
set_input_transition 0.2 [get_ports {config_data[23]}]
set_input_transition 0.2 [get_ports {config_data[22]}]
set_input_transition 0.2 [get_ports {config_data[21]}]
set_input_transition 0.2 [get_ports {config_data[20]}]
set_input_transition 0.2 [get_ports {config_data[19]}]
set_input_transition 0.2 [get_ports {config_data[18]}]
set_input_transition 0.2 [get_ports {config_data[17]}]
set_input_transition 0.2 [get_ports {config_data[16]}]
set_input_transition 0.2 [get_ports {config_data[15]}]
set_input_transition 0.2 [get_ports {config_data[14]}]
set_input_transition 0.2 [get_ports {config_data[13]}]
set_input_transition 0.2 [get_ports {config_data[12]}]
set_input_transition 0.2 [get_ports {config_data[11]}]
set_input_transition 0.2 [get_ports {config_data[10]}]
set_input_transition 0.2 [get_ports {config_data[9]}]
set_input_transition 0.2 [get_ports {config_data[8]}]
set_input_transition 0.2 [get_ports {config_data[7]}]
set_input_transition 0.2 [get_ports {config_data[6]}]
set_input_transition 0.2 [get_ports {config_data[5]}]
set_input_transition 0.2 [get_ports {config_data[4]}]
set_input_transition 0.2 [get_ports {config_data[3]}]
set_input_transition 0.2 [get_ports {config_data[2]}]
set_input_transition 0.2 [get_ports {config_data[1]}]
set_input_transition 0.2 [get_ports {config_data[0]}]
set_input_transition 0.2 [get_ports config_read]
set_input_transition 0.2 [get_ports config_write]
set_input_transition 0.2 [get_ports {in_BUS1_S0_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S0_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S0_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S0_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S0_T4[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S1_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S1_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S1_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S1_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S1_T4[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S2_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S2_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S2_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S2_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S2_T4[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S3_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S3_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S3_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S3_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS1_S3_T4[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S0_T4[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S1_T4[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S2_T4[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T0[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T1[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T2[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T3[0]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[15]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[14]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[13]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[12]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[11]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[10]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[9]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[8]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[7]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[6]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[5]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[4]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[3]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[2]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[1]}]
set_input_transition 0.2 [get_ports {in_BUS16_S3_T4[0]}]
set_input_transition 0.2 [get_ports gin_0]
set_input_transition 0.2 [get_ports gin_1]
set_input_transition 0.2 [get_ports gin_2]
set_input_transition 0.2 [get_ports gin_3]
set_input_transition 0.2 [get_ports reset]
set_input_transition 0.2 [get_ports {tile_id[15]}]
set_input_transition 0.2 [get_ports {tile_id[14]}]
set_input_transition 0.2 [get_ports {tile_id[13]}]
set_input_transition 0.2 [get_ports {tile_id[12]}]
set_input_transition 0.2 [get_ports {tile_id[11]}]
set_input_transition 0.2 [get_ports {tile_id[10]}]
set_input_transition 0.2 [get_ports {tile_id[9]}]
set_input_transition 0.2 [get_ports {tile_id[8]}]
set_input_transition 0.2 [get_ports {tile_id[7]}]
set_input_transition 0.2 [get_ports {tile_id[6]}]
set_input_transition 0.2 [get_ports {tile_id[5]}]
set_input_transition 0.2 [get_ports {tile_id[4]}]
set_input_transition 0.2 [get_ports {tile_id[3]}]
set_input_transition 0.2 [get_ports {tile_id[2]}]
set_input_transition 0.2 [get_ports {tile_id[1]}]
set_input_transition 0.2 [get_ports {tile_id[0]}]
set_wire_load_selection_group "WireAreaForZero" -library "tcbn16ffcllbwp16p90ssgnp0p72vm40c"
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/AN2D16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BHDBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFSKND16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFSKND20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFSKND24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFSKPD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFSKPD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFFSKPD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFTD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFTD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/BUFTD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKBD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKBD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLHQD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLHQD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLHQD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLNQD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLNQD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLNQD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLNQOPTBBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLNQOPTBBD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKLNQOPTBBD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKND16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKND20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/CKND24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DCCKBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DCCKBD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DCCKBD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DCCKND16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DCCKND20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DCCKND24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DFMQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DFMQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DFMQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/DFMQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFCNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFCNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFCNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFCNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/EDFQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GAN2MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GAN2MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GAOI21MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GAOI21MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GAOI22MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GAOI22MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GBUFFMCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GBUFFMCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GBUFFMCOD3BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GBUFFMCOD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GBUFFMCOD8BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP10MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP11MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP12MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP1MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP2MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP3MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP4MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP5MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP6MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP8MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDCAP9MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDFCNQMCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GDFQMCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL10MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL11MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL12MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL1MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL2MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL3MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL4MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL5MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL6MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL8MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GFILL9MCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GINVMCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GINVMCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GINVMCOD3BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GINVMCOD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GINVMCOD8BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GMUX2MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GMUX2MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GMUX2NMCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GMUX2NMCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GND2MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GND2MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GND3MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GND3MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GNR2MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GNR2MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GNR3MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GNR3MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GOAI21MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GOAI21MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GOR2MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GOR2MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GSDFCNQMCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GSDFQMCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GTIEHMCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GTIELMCOBWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GXNR2MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GXNR2MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GXOR2MCOD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/GXOR2MCOD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/IND2OPTPBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INR2OPTPBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVSKND16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVSKND20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVSKND24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVSKPD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVSKPD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/INVSKPD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2D16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2D20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2D24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2OPTPBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2SKNBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2SKNBD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2SKNBD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2SKND16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2SKND20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/ND2SKND24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2D16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2D20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2D24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2OPTPBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2SKPBD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2SKPBD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2SKPBD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2SKPD16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2SKPD20BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/NR2SKPD24BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/OR2D16BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQND0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQND1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQND2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQNOPTBBD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQNOPTBBD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQNOPTBBD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQOPTBBD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQOPTBBD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQOPTBBD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCNQOPTBBD8BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCSNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCSNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFCSNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCSNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCSNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKCSNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKSNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKSNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFKSNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFMQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFMQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFMQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFMQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCNQND0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCNQND1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCNQND2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCSNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCSNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNCSNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQND0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQND1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQND2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNQND4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNSNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNSNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNSNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNSNQND0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNSNQND1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFNSNQND2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQND0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQND1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQND2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQND4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQNOPTBBD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQNOPTBBD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQNOPTBBD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQOPTBBD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQOPTBBD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQOPTBBD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFQOPTBBD8BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQD0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQND0BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQND1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQND2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQNOPTBBD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQNOPTBBD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQNOPTBBD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQOPTBBD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQOPTBBD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQOPTBBD4BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSNQOPTBBD8BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNCNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNCNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNCSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNCSNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNQD2BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNSNQD1BWP16P90]
set_dont_use [get_lib_cells tcbn16ffcllbwp16p90ssgnp0p72vm40c/SDFSYNSNQD2BWP16P90]
set_dont_use [get_lib_cells ts1n16ffcllsblvtc512x16m8s_ssgnp0p72vm40c/sram_512x16m4s]
