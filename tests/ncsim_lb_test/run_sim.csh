#!/bin/tcsh
set RTL_FOLDER="../../hardware/generator_z/top/genesis_verif"
rm -rf INCA_libs irun.*
irun -top lb_tb -timescale 1ns/1ps -l irun.log -access +rwc -notimingchecks -input cmd.tcl lb_tb.sv $RTL_FOLDER/mem_unq1.v $RTL_FOLDER/memory_core_unq1.v $RTL_FOLDER/linebuffer_control_unq1.v $RTL_FOLDER/fifo_control_unq1.v $RTL_FOLDER/input_sr_unq1.v $RTL_FOLDER/output_sr_unq1.v ../../verilator/generator_z_tb/sram_stub.v

