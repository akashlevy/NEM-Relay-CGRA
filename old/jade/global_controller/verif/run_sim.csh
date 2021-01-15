#!/bin/tcsh
set RTL_FOLDER="genesis_verif"
rm -rf INCA_libs irun.*
irun -top top -timescale 1ns/1ps -l irun.log -access +rwc -notimingchecks -input \
cmd.tcl \
$RTL_FOLDER/top.sv \
$RTL_FOLDER/cfg_and_dbg_unq1.sv \
$RTL_FOLDER/cfg_ifc_unq1.sv \
$RTL_FOLDER/clocker_unq1.sv \
$RTL_FOLDER/flop_unq1.sv \
$RTL_FOLDER/flop_unq2.sv \
$RTL_FOLDER/flop_unq3.sv \
$RTL_FOLDER/JTAGDriver.sv \
$RTL_FOLDER/jtag_unq1.sv \
$RTL_FOLDER/tap_unq1.sv \
$RTL_FOLDER/template_ifc_unq1.sv \
$RTL_FOLDER/test_unq1.sv \
$RTL_FOLDER/global_controller.sv \
$SYNOPSYS/dw/sim_ver/DW_tap.v
