proc place_ios {width height} {
  redirect io_file {puts "##"}
  redirect -append io_file {puts "(globals\n    version = 3\n    io_order = default\n)"}
  redirect -append io_file {puts "(iopin"}
  for {set i 0} {$i < 4} {incr i} {
    if {$i==0} {set tag right}
    if {$i==1} {set tag bottom}
    if {$i==2} {set tag left}
    if {$i==3} {set tag top}
    redirect -append io_file {puts "  ($tag"}
    set pports ""
    set qports ""
    set rports ""
    set sports ""
    set xports ""
    if {$i==0} {
      set pports [get_ports in_*_BUS1_${i}*]
      set qports [get_ports out_*_BUS1_${i}*]
      set rports [get_ports in_*_BUS16_${i}*]
      set sports [get_ports out_*_BUS16_${i}*]
      set xports [get_ports config_*]
    }
    if {$i==1} {
      set pports [get_ports in_*_BUS1_${i}_*]
      set qports [get_ports out_*_BUS1_${i}_*]
      set rports [get_ports in_*_BUS16_${i}_*]
      set sports [get_ports out_*_BUS16_${i}_*]
      set xports [get_ports {gin* gout*}]
    }
    if {$i==3} {
      set pports [get_ports out_*_BUS1_${i}_*]
      set qports [get_ports in_*_BUS1_${i}_*]
      set rports [get_ports out_*_BUS16_${i}_*]
      set sports [get_ports in_*_BUS16_${i}_*]
      set xports [get_ports {clk_in reset}]
    }
    set remaining_ports [remove_from_collection [get_ports *] [get_ports {*_BUS* config_* clk_in reset}]]
    if {$i==2} {
      set pports [get_ports out_*_BUS1_${i}*]
      set qports [get_ports in_*_BUS1_${i}*]
      set rports [get_ports out_*_BUS16_${i}*]
      set sports [get_ports in_*_BUS16_${i}*]
      set xports $remaining_ports
    }
    set offset 0.4
    set off_incr 0.3
    if {$i==0 || $i==2} {
      set layer [list 4 6]
      set max $height
    } else {
      set layer [list 3 5]
      set max $width
      set offset 36
    }
    set layer_index 0
    set pports [sort_collection $pports full_name]
    set qports [sort_collection $qports full_name]
    set rports [sort_collection $rports full_name]
    set sports [sort_collection $sports full_name]
    set xports [sort_collection $xports full_name]
    foreach_in_collection p $pports {
      set pn [get_property $p full_name]
      redirect -append io_file {puts "    (pin name=\"$pn\" offset=$offset layer=[lindex $layer $layer_index] depth=0.1 width=0.04 place_status=fixed)"}
      incr layer_index
      if {$layer_index > [expr [llength $layer] - 1]} {set layer_index 0; set offset [expr $offset + $off_incr]; if {([expr (int($offset-0.8)%10)]==1) && ($i==1||$i==3)} {set offset [expr $offset + 3]}}
      if {$offset > $max} {
        puts "ERROR: Core side $tag less than needed"
      }
    } 
    foreach_in_collection p $qports {
      set pn [get_property $p full_name]
      redirect -append io_file {puts "    (pin name=\"$pn\" offset=$offset layer=[lindex $layer $layer_index] depth=0.1 width=0.04 place_status=fixed)"}
      incr layer_index
      if {$layer_index > [expr [llength $layer] - 1]} {set layer_index 0; set offset [expr $offset + $off_incr]; if {([expr (int($offset-0.8)%10)]==1) && ($i==1||$i==3)} {set offset [expr $offset + 3]}}
      if {$offset > $max} {
        puts "ERROR: Core side $tag less than needed"
      }
    } 
    foreach_in_collection p $rports {
      set pn [get_property $p full_name]
      redirect -append io_file {puts "    (pin name=\"$pn\" offset=$offset layer=[lindex $layer $layer_index] depth=0.1 width=0.04 place_status=fixed)"}
      incr layer_index
      if {$layer_index > [expr [llength $layer] - 1]} {set layer_index 0; set offset [expr $offset + $off_incr]; if {([expr (int($offset-0.8)%10)]==1) && ($i==1||$i==3)} {set offset [expr $offset + 3]}}
      if {$offset > $max} {
        puts "ERROR: Core side $tag less than needed"
      }
    } 
    foreach_in_collection p $sports {
      set pn [get_property $p full_name]
      redirect -append io_file {puts "    (pin name=\"$pn\" offset=$offset layer=[lindex $layer $layer_index] depth=0.1 width=0.04 place_status=fixed)"}
      incr layer_index
      if {$layer_index > [expr [llength $layer] - 1]} {set layer_index 0; set offset [expr $offset + $off_incr]; if {([expr (int($offset-0.8)%10)]==1) && ($i==1||$i==3)} {set offset [expr $offset + 3]}}
      if {$offset > $max} {
        puts "ERROR: Core side $tag less than needed"
      }
    }
    set offset [expr $offset + 1] 
    foreach_in_collection p $xports {
      set pn [get_property $p full_name]
      redirect -append io_file {puts "    (pin name=\"$pn\" offset=$offset layer=[lindex $layer $layer_index] depth=0.1 width=0.04 place_status=fixed)"}
      incr layer_index
      if {$layer_index > [expr [llength $layer] - 1]} {set layer_index 0; set offset [expr $offset + $off_incr]; if {([expr (int($offset-0.8)%10)]==1) && ($i==1||$i==3)} {set offset [expr $offset + 3]}}
      if {$offset > $max} {
        puts "ERROR: Core side $tag less than needed"
      }
    } 
    redirect -append io_file {puts "  )"}   
  }
  redirect -append io_file {puts ")"}
  loadIoFile io_file 
}
