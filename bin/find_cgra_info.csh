#!/bin/csh -f

# set top = ../genesis_verif/top.v
set top = $1

set topdir = $top:h

echo ""
echo "${0:t} WARNING $0:t is deprecated/unnecessary, use $top/bin/show_cgra.csh instead"
echo "${0:t} WARNING $0:t is deprecated/unnecessary, use $top/bin/show_cgra.csh instead"
echo "${0:t} WARNING $0:t is deprecated/unnecessary, use $top/bin/show_cgra.csh instead"
echo ""
exec $top/bin/show_cgra_info.csh $topdir
exit


# set topdir = $top:h
# set work = $topdir/../genesis_work
# 
# if (! -e $top) then
#   echo "Cannot find TOP '$top'"
#   exit -1
# endif
# 
# echo "find_cgra_info.csh: built $top"
# echo "--------------------------------------------------------------------"
# echo "Here is what I built (it's supposed to look like an array of tiles)."
# echo
# egrep '^//t' $top  | sed 's/^../    /' | sed 's/\.\.\.\.\.\. /..... /g'
# 
# egrep '^//(io1|[.][.][.])' $top | expand \
#   | sed 's/^..//' \
#   | sed 's/0x\(.\) /0x0\1/g' \
#   | sed 's/0x//g' \
#   | sed 's/  / /g' | sed 's/  / /g' \
#   | sed 's/\.\.\.\.\.\. /..... /g' \
#   | sed 's/\.  \./. ./g'\
#   | sed 's/\(mem_..\) pe/\1  pe/g'
# 
# 
# 
# echo "--------------------------------------------------------------------"
# 
# # E.g.
# #     --------------------------------------------
# #     t0#0_0#0    t0#0_1#0    t0#0_2#0    t0#0_3#0    
# #     t0#1_0#0    t0#1_1#0    t0#1_2#0    t0#1_3#0    
# #     t0#2_0#0    t0#2_1#0    t0#2_2#0    t0#2_3#0    
# #     t0#3_0#0    t0#3_1#0    t0#3_2#0    t0#3_3#0    
# #     -------------------------------------------
# 
# # echo ''
# # echo 'Each tile is designated as <tile_type>#<tile_loc(x,y)>#<tile_section>'
# # echo 'E.g. current default in top.vp calls stamp_pattern('top') where top is defined as'
# # echo ''
# 
# # egrep 'tile_pattern.*=' $work/top.pm
# 
# # echo '   $tile_pattern {'p1'} = "t0_1_1";'
# # echo '   $tile_pattern {'top'} = "p1_2_2";'
# 
# # echo ''
# # echo ' resulting in a 4x4 grid of "t0" tiles, where each tile looks like'
# # echo ''
# # 
# # cat $work/top.pm | awk '            \
# #   /all_segments/ {if (p==1) exit 0} \
# #   /tile_config.*=/ {p=1}            \
# #   p==1 {print "   " $0}            \
# # '
# 
# 
# 
# # echo '    $tile_config->{ 't0' } = {'
# # echo '         type => 'pe_tile_new','
# # echo '         sides => $sides,'
# # echo '         is_bidi => 0,'
# # echo '         bus_config => $bus_config,'
# # echo '         cb_connections => $cb_connections,'
# # echo '         has_constant => 1,'
# # echo '         tile_height => 1,'
# # echo '         tile_width => 1,'
# # echo '         reg_inputs => 0,'
# # echo '         reg_out => 0, '
# # echo '         use_add => 1,'
# # echo '         bool_inps => 1,'
# # echo '         use_shift => 1,'
# # echo '         mult_mode => 1,'
# # echo '         sb_fs => $sb_fs,'
# # echo '         all_segments_for_all_tiles => $all_segments_for_all_tiles'
# # echo '   };'
# # echo '-------------------------------------------------------------------'
# # echo ''
