package input_sr;
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
sub get_SrcSuffix {Genesis2::UniqueModule::private_to_me(); return ".vp";};
sub get_OutfileSuffix {Genesis2::UniqueModule::private_to_me(); return ".v"};
############################### Module Starts Here ###########################


  sub to_verilog{ 
      # START PRE-GENERATED TO_VERILOG PREFIX CODE >>>
      my $self = shift;
      
      print STDERR "$self->{BaseModuleName}->to_verilog: Start user code\n" 
	  if $self->{Debug} & 8;
      # <<< END PRE-GENERATED TO_VERILOG PREFIX CODE
	$self->SUPER::to_verilog('/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_core/input_sr.vp');
# START USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_core/input_sr.vp PARSED INTO PACKAGE >>>
# line 1 "/Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_core/input_sr.vp"
    use POSIX;
    my $backtick = "`";
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '///////////////////////////////////////////////////////////////////';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '// CGRA memory generator';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '//////////////////////////////////////////////////////////////////';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ''; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $backtick; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'define xassert(condition, message) if(condition) begin $display(message); $finish(1); end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
 my $dwidth   = parameter(Name=>'dwidth', val=> 16, doc=>'word width');
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'module '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } mname; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '(';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'clk,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'reset,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'flush,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'fsm_en,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'data_in,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'wen,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'data_out,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'avail_w1,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'avail_w2,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'ren_w1,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'ren_w2,';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'count';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ');';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input clk;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input reset;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input flush;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input fsm_en;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $dwidth - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] data_in;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ren_w1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input ren_w2;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  input wen;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg avail_w1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg avail_w2;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth * 2) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] data_out;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  reg ['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth*3) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0] data_sr;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  output reg [1:0] count;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  wire ___genesis_wire_'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ${dwidth}; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ';';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   if (fsm_en==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     if (wen==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '       data_sr <= {data_sr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth*2) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0],data_in};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '     end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // assert only ren_w2 or ren_w1 at a time.';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   // asserting both is an error';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '   '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $backtick; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'xassert((ren_w2&ren_w1)==1\'b1 , "both ren_w2 and ren_w1 are asserted" )';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(posedge clk or posedge reset) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (reset==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      count <= 2\'d0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end	';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    else if (flush==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      count <= 2\'d0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    else if (fsm_en==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (wen==1\'b1 && (ren_w2==1\'b0 && ren_w1==1\'b0)) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        count <= count + 2\'d1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $backtick; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'xassert(count >= 2\'d3, "pushing data into sr when count >= 3")';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b1 && ren_w2==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        count <= count - 2\'d1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $backtick; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'xassert(count == 2\'d0, "popping pixel from sr when count == 0. Case A.")';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b0 && ren_w2==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        count <= count - 2\'d2;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $backtick; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'xassert(count <= 2\'d1, "popping two pixels from sr when count <= 1")';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b0 && ren_w1==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        count <= count - 2\'d1;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $backtick; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'xassert(count == 2\'d0, "popping pixel from sr when count ==0. Case B.")';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b1 && ren_w1==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        count <= count;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      avail_w2 <= 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (wen==1\'b0 && ren_w2==1\'b0) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w2 <= (count >= 2\'d2);        ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b0 && ren_w2==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w2 <= 1\'b0;      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b1 && ren_w2==1\'b0) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w2 <= (count >= 2\'d1);      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b1 && ren_w2==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w2 <= (count == 2\'d3);      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      avail_w1 <= 1\'b0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (wen==1\'b0 && ren_w1==1\'b0 && ren_w2==1\'b0) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w1 <= (count >= 2\'d1);      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b0 && ren_w1==1\'b0 && ren_w2==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w1 <= (count == 2\'d3); ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b0 && ren_w1==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w1 <= (count >= 2\'d2);      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b1 && ren_w1==1\'b0 && ren_w2==1\'b0) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w1 <= 1\'b1;      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b1 && ren_w1==1\'b0 && ren_w2==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w1 <= (count >= 2\'d2);';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (wen==1\'b1 && ren_w1==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        avail_w1 <= 1\'b1;      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  always @(*) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    if (ren_w2==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (count==2\'d2) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        data_out <= data_sr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth*2) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (count==2\'d3) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        data_out <= data_sr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth*3) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $dwidth; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '];';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        data_out <= '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth * 2); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      ';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else if (ren_w1==1\'b1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      if (count==2\'d1) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        data_out <= {'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d0, data_sr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':0]};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (count==2\'d2) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        data_out <= {'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d0, data_sr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth*2) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ':'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else if (count==2\'d3) begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        data_out <= {'; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d0, data_sr['; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth*3) - 1; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ': '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth*2); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ']};';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '        data_out <= '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } ($dwidth * 2); print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'h0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end else begin';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '      data_out <= '; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } $dwidth*2; print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '\'d0;';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '    end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '  end';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } 'endmodule';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
print { $Genesis2::UniqueModule::myself->{OutfileHandle} } '';print { $Genesis2::UniqueModule::myself->{OutfileHandle} } "\n"; 
# <<< END USER CODE FROM /Users/akashlevy/OneDrive - Levylab/Documents/Research/Hybrid-RRAM-NEMS/cgra/jade/memory_core/input_sr.vp PARSED INTO PACKAGE


      # START PRE-GENERATED TO_VERILOG SUFFIX CODE >>>
      print STDERR "$self->{BaseModuleName}->to_verilog: Done with user code\n" 
	  if $self->{Debug} & 8;

      #
      # clean up code comes here...
      #
      # <<< END PRE-GENERATED TO_VERILOG SUFFIX CODE
  }
