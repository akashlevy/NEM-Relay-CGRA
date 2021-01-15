package test_pe_dual.vpf;
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use Exporter;
use FileHandle;
use Env; # Make environment variables available


use Genesis2::Manager 1.00;
use Genesis2::UniqueModule 1.00;

@ISA = qw(Exporter Genesis2::UniqueModule);
@EXPORT = qw();
@EXPORT_OK = qw();
$VERSION = '1.0';
sub get_SrcSuffix {Genesis2::UniqueModule::private_to_me(); return ".tclp";};
sub get_OutfileSuffix {Genesis2::UniqueModule::private_to_me(); return ".tcl"};
############################### Module Starts Here ###########################


  sub to_verilog{ 
      # START PRE-GENERATED TO_VERILOG PREFIX CODE >>>
      my $self = shift;
      
      print STDERR "$self->{BaseModuleName}->to_verilog: Start user code\n" 
	  if $self->{Debug} & 8;
      # <<< END PRE-GENERATED TO_VERILOG PREFIX CODE
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_dual.vpf');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_dual.vpf PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_dual.vpf"
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_pe.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_pe_red.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_pe_comp.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_pe_comp_dual.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_lut.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_full_add.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_cmpr.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_mult_add.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_opt_reg.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_simple_shift.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } './test_shifter.svp';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/pe_new/pe/rtl/test_pe_dual.vpf PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
