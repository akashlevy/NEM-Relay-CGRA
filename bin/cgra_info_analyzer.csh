#!/bin/csh -f

set f = $1

echo ""

# grep tile\ type $f; exit

#  <tile type='pe_tile_new' tile_addr='2' row='0' col='2' tracks='BUS1:5 BUS16:5 '>
#  <tile type='memory_tile' tile_addr='3' row='0' col='3' tracks='BUS1:5 BUS16:5 '>

# Find number of rows and columns
# " <tile type='pe_tile_new' tile_addr='2' row='0' col='2' tracks='BUS1:5 BUS16:5 '>"
set maxrow = `grep tile\ type $f | sed "s/.*row='\([0-9]*\)'.*/\1/" | sort -n | tail -n 1`
set maxcol = `grep tile\ type $f | sed "s/.*col='\([0-9]*\)'.*/\1/" | sort -n | tail -n 1`

# Start at zero yes?
@ maxrow = $maxrow + 1
@ maxcol = $maxcol + 1

# echo "Looks like there are $maxrow rows and $maxcol columns"
echo $f:t 
echo "- $maxrow rows and $maxcol columns"




set ntiles = `grep tile\ type $f | wc -l`
set npe  = `grep tile\ type $f | grep pe_tile | wc -l`
set nmem = `grep tile\ type $f | grep memory_tile | wc -l`

# echo "Found $ntiles total tiles in $f"

echo "- $ntiles total tiles"
echo "- $npe    PE tiles"
echo "-  $nmem   mem tiles"
echo ""






# # BEFORE: " <tile type='pe_tile_new' tile_addr=..."
# # AFTER:  "pe_tile_new" 
# grep tile\ type $f | sed 's/.*type=.//' | sed "s/'.*//"\
#   | sort | uniq
# 

