##
##for ($i=1;$i<=18;$i++) {
##  $cmd = "cat abc | awk '{print \$${i}}' > out";
##  system $cmd;
##  open FH,"<out";
##  $count=0;
##  while (<FH>) {
##    $line = $_;
##    $line =~ m/_0x(\S*)/;
##    $num = $1;
##    $count++;
##    $old_count = $count - 1;
##    print "\nwire [31:0] col_${i}_row_${count};";
##    if ($old_count == 0) {
##      print "\nassign col_${i}_row_${count} = read_data_${num};";
##    } else {
##      for ($x=0;$x<32;$x++) {
##      print "\nOR2D1BWP16P90 my_or${x}_${i}_${count}(.A1(read_data_${num}\[${x}\]),  .A2(col_${i}_row_${old_count}[${x}]),  .Z(col_${i}_row_${count}[${x}]));";
##      }
##    } 
##  }
##}
##
##
##for ($i=1;$i<=18;$i++) {
##  $cmd = "cat xyz | awk '{print \$${i}}' > out";
##  system $cmd;
##  open FH,"<out";
##  $count=0;
##  $old_num="";
##  while (<FH>) {
##    $line = $_;
##    $line =~ m/_0x(\S*)/;
##    $num = $1;
##    $count++;
##    $old_count = $count - 1;
##    if ($old_num eq "") {
##      for ($x=0;$x<32;$x++) {
##        print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_addr (.I(config_addr[${x}]), .Z(config_addr_${num}\[${x}\]));";      
##        print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_data (.I(config_data[${x}]), .Z(config_data_${num}\[${x}\]));";      
##      }
##      print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_read (.I(config_read), .Z(config_read_${num}));";      
##      print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_write (.I(config_write), .Z(config_write_${num}));";      
##    } else {
##      for ($x=0;$x<32;$x++) {
##        print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_addr (.I(config_addr_${old_num}\[${x}\]), .Z(config_addr_${num}\[${x}\]));";
##        print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_data (.I(config_data_${old_num}\[${x}\]), .Z(config_data_${num}\[${x}\]));";
##      }
##      print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_read (.I(config_read_${old_num}), .Z(config_read_${num}));";      
##      print "\nBUFFD1BWP16P90 my_buf${x}_${i}_${count}_config_write (.I(config_write_${old_num}), .Z(config_write_${num}));";      
##    }
##    $old_num = $num;
##  }
##}
##
##
##for ($i=18;$i>=1;$i--) {
##    $old_count = $i + 1;    
##    print "\nwire [31:0] top_col_${i};";
##    if ($old_count > 18) {
##      print "\nassign top_col_${i} = col_${i}_row_16;";
##    } else {
##      for ($x=0;$x<32;$x++) {
##      print "\nOR2D1BWP16P90 my_or${x}_top_${i}(.A1(top_col_${old_count}\[${x}\]),  .A2(col_${i}_row_16[${x}]),  .Z(top_col_${i}[${x}]));";
##      }
##    } 
##}

print "\n\/\/ TOP BOTTOM IO\n";
for ($i=16;$i>=1;$i--) {
  my $num = sprintf("%X", ($i+309));
    print "\nwire [31:0] io0_col_${i};";
    $old_count = $i + 1;
    $nxt = $i - 18 + 309;
  my $num2 = sprintf("%X", ($nxt));

    print "\nassign config_addr_${num} = config_addr_${num2};";
    print "\nassign config_data_${num} = config_data_${num2};";
    print "\nassign config_write_${num} = config_write_${num2};";
    print "\nassign config_read_${num} = config_read_${num2};";
    if ($old_count > 16) {
      print "\nassign io0_col_${i} = read_data_${num};";
    } else {
      for ($x=0;$x<32;$x++) {
      print "\nOR2D1BWP16P90  my_io0_or${x}_${i}(.A1(read_data_${num}\[${x}\]),  .A2(io0_col_${old_count}[${x}]),  .Z(io0_col_${i}[${x}]));";
      }
    }   
}

for ($i=16;$i>=1;$i--) {
  my $num = sprintf("%X", ($i+309));
    print "\nwire [31:0] io1_col_${i};";
    $old_count = $i + 1;
    if ($old_count > 16) {
      print "\nassign io1_col_${i} = read_data_${num};";
    } else {
      for ($x=0;$x<32;$x++) {
      print "\nOR2D1BWP16P90  my_io1_or${x}_${i}(.A1(read_data_${num}\[${x}\]),  .A2(io1_col_${old_count}[${x}]),  .Z(io1_col_${i}[${x}]));";
      }
    }   
}




