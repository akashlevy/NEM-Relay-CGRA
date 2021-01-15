package template_ifc;
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
sub get_SrcSuffix {Genesis2::UniqueModule::private_to_me(); return ".svp";};
sub get_OutfileSuffix {Genesis2::UniqueModule::private_to_me(); return ".sv"};
############################### Module Starts Here ###########################


  sub to_verilog{ 
      # START PRE-GENERATED TO_VERILOG PREFIX CODE >>>
      my $self = shift;
      
      print STDERR "$self->{BaseModuleName}->to_verilog: Start user code\n" 
	  if $self->{Debug} & 8;
      # <<< END PRE-GENERATED TO_VERILOG PREFIX CODE
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/template_ifc.svp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/template_ifc.svp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/template_ifc.svp"
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $io_list = $self->define_param(IO_LIST => []);
 my $num_ios = scalar(@{$io_list});

# Verify correctness of IO parameters:
 my $cnt = 0;
 foreach my $io (@{$io_list}){
   $self->error("IO $cnt is missing it's name!") 
	unless defined $io->{name};
   $self->error("IO $io->{name} (IO\# $cnt) is missing its width!") 
	unless defined $io->{width};
   $self->error("IO $io->{name} (IO\# $cnt) has an illegal width -->$io->{width}<--!") 
	if ($io->{width} < 1);
   $self->error("IO $io->{name} (IO\# $cnt) is missing its direction!") 
	unless defined $io->{direction};
   $self->error("IO $io->{name} (IO\# $cnt) has an invalid direction -->$io->{direction}<--! ".
		   "(allowed values: in/out)") 
	unless ($io->{direction} =~ m/^(in|out)$/i);
   $self->error("IO $io->{name} (IO\# $cnt) does not specify whether it's on the boundary scan!") 
	unless defined $io->{bsr};
   $self->error("IO $io->{name} (IO\# $cnt) has an invalid bsr flag -->$io->{bsr}<--! ".
		   "(allowed values: yes/no)") 
	unless ($io->{bsr} =~ m/^(yes|no)$/i);
   $self->error("IO $io->{name} (IO\# $cnt) does not specify pad type (analog/digital)!") 
	unless defined $io->{pad};
   $self->error("IO $io->{name} (IO\# $cnt) has an invalid pad flag -->$io->{pad}<--! ".
		   "(allowed values: analog/digital)") 
	unless ($io->{pad} =~ m/^(anl|analog|dig)/i);
   $cnt++;
 } # end of "foreach my $io..."

# include ("analog_defs.vph");
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'interface '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $self->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(input Clk, input Reset);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    foreach my $io (@{$io_list}){
    my $type = 'logic';
    $type = 'real' if $io->{pad} =~ m/^(anl|analog)/i;
      if ($io->{width} == 1){
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $type; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '				'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io->{name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }else{
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $type; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io->{width}-1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] 		'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io->{name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
      }
    }
   
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   modport des(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    foreach my $io (@{$io_list}){
      my $dir = 'input'; # default is digital input
      $dir = 'output' if ($io->{direction} =~ m/^out$/i);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $dir; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '				'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io->{name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    }
   
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '	       ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input Clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   input Reset';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '	       );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   modport pwrap';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    $cnt = 1;
    my $comma = ',';
    foreach my $io (@{$io_list}){
      my $dir = 'output'; # default is digital input
      $dir = 'input' if ($io->{direction} =~ m/^out$/i);
      $comma = '' if $cnt==$num_ios;
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $dir; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '				'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io->{name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ' '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $comma; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
    $cnt++;			    
    }
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // define testing modport';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   modport test ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     (';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       foreach my $io (@{$io_list}){
         my $dir = 'output'; # default is digital input
         $dir = 'input' if ($io->{direction} =~ m/^out$/i);
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $dir; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '				'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $io->{name}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ',';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
       }
      
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input Clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    input Reset';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      );';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      endinterface: '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $self->get_module_name(); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/jtag/Template/src/digital/template_ifc.svp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
