#!/bin/csh -f

# Must fix e.g.  <depth bith='15' bitl='3'>0</depth>
# should be <fifo_depth bith='15' bitl='3'>0</fifo_depth>

grep depth cgra_info.txt | grep -v fifo_depth > /tmp/tmp$$

set nlines = `cat /tmp/tmp$$ | wc -l`
if ($nlines == 0) then
  echo Congratulations, no fifo_depth errors found
  echo
  exit 0
endif

echo "ERROR cgra_info.txt has one or more incorrect fifo_depth designations"
echo "ERROR cgra_info.txt has one or more incorrect fifo_depth designations"
echo "ERROR cgra_info.txt has one or more incorrect fifo_depth designations:"
echo
head -n 1 /tmp/tmp$$
echo

cp cgra_info.txt cgra_info.txt.pre_depth_fix

cat cgra_info.txt \
| sed 's/depth/fifo_depth/g' \
> /tmp/tmp$$

diff cgra_info.txt /tmp/tmp$$ | head -4
echo
cp /tmp/tmp$$ cgra_info.txt

echo WARNING patched cgra_info.txt fifo_depth boo-boos

