tile_module = "pe_tile_new_unq1"
inputs = ["config_addr", "config_data", "config_read", "config_write", "in_BUS1_S0_T0", "in_BUS1_S0_T1", "in_BUS1_S0_T2", "in_BUS1_S0_T3", "in_BUS1_S0_T4", "in_BUS1_S1_T0", "in_BUS1_S1_T1", "in_BUS1_S1_T2", "in_BUS1_S1_T3", "in_BUS1_S1_T4", "in_BUS1_S2_T0", "in_BUS1_S2_T1", "in_BUS1_S2_T2", "in_BUS1_S2_T3", "in_BUS1_S2_T4", "in_BUS1_S3_T0", "in_BUS1_S3_T1", "in_BUS1_S3_T2", "in_BUS1_S3_T3", "in_BUS1_S3_T4", "in_BUS16_S0_T0", "in_BUS16_S0_T1", "in_BUS16_S0_T2", "in_BUS16_S0_T3", "in_BUS16_S0_T4", "in_BUS16_S1_T0", "in_BUS16_S1_T1", "in_BUS16_S1_T2", "in_BUS16_S1_T3", "in_BUS16_S1_T4", "in_BUS16_S2_T0", "in_BUS16_S2_T1", "in_BUS16_S2_T2", "in_BUS16_S2_T3", "in_BUS16_S2_T4", "in_BUS16_S3_T0", "in_BUS16_S3_T1", "in_BUS16_S3_T2", "in_BUS16_S3_T3", "in_BUS16_S3_T4", "gin_0", "gin_1", "gin_2", "gin_3", "tile_id", "reset"]
outputs = ["out_BUS1_S0_T0", "out_BUS1_S0_T1", "out_BUS1_S0_T2", "out_BUS1_S0_T3", "out_BUS1_S0_T4", "out_BUS1_S1_T0", "out_BUS1_S1_T1", "out_BUS1_S1_T2", "out_BUS1_S1_T3", "out_BUS1_S1_T4", "out_BUS1_S2_T0", "out_BUS1_S2_T1", "out_BUS1_S2_T2", "out_BUS1_S2_T3", "out_BUS1_S2_T4", "out_BUS1_S3_T0", "out_BUS1_S3_T1", "out_BUS1_S3_T2", "out_BUS1_S3_T3", "out_BUS1_S3_T4", "out_BUS16_S0_T0", "out_BUS16_S0_T1", "out_BUS16_S0_T2", "out_BUS16_S0_T3", "out_BUS16_S0_T4", "out_BUS16_S1_T0", "out_BUS16_S1_T1", "out_BUS16_S1_T2", "out_BUS16_S1_T3", "out_BUS16_S1_T4", "out_BUS16_S2_T0", "out_BUS16_S2_T1", "out_BUS16_S2_T2", "out_BUS16_S2_T3", "out_BUS16_S2_T4", "out_BUS16_S3_T0", "out_BUS16_S3_T1", "out_BUS16_S3_T2", "out_BUS16_S3_T3", "out_BUS16_S3_T4", "gout", "read_data"]
scope = "TOP.top.core"
pe_prefix = "pe_0x"
pwr_aware = False
design_file = "design/design.vcs.v"
stdcell_file = "/home/shared/COMMON_CHIMERA_V2/adks/tsmc40ulp_V130a/view-standard/stdcells.v"
assign_delay = 0
config_clock_period = 10
global clock_period
clock_period = 4.3
timescale = '1ns/1ps'

app_clk_factors = {
    "cascade": 5, # >2
    "conv_1_2": 2, # <2
    "conv_2_1": 2, # <2
    "conv_3_1": 2, # <2
    "conv_bw": 5, # >2
    "harris": 5, # >2
    "pointwise": 1
}

app_active_cycle_numbers = {
    "cascade": 510,
    "conv_1_2": 52,
    "conv_2_1": 66,
    "conv_3_1": 87,
    "conv_bw": 150,
    "harris": 97,
    "pointwise": 41
}
