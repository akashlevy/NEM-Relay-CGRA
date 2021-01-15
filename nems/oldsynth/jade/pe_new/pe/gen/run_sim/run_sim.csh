#!/bin/tcsh
set RTL_FOLDER="../genesis_verif"
rm -rf INCA_libs irun.*
irun    -top test_pe_tb \
        -timescale 1ns/1ps \
        -l irun.log \
        -access +rwc \
        -notimingchecks \
        -input cmd.tcl ${RTL_FOLDER}/*.sv ${RTL_FOLDER}/*.v 
