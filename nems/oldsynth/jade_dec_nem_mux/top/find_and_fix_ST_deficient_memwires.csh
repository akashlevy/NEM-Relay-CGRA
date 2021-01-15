#!/bin/csh -f

egrep '(in|out)_[01]_BUS(1|16)_[0-9]' cgra_info.txt > /tmp/tmp$$

set nlines = `cat /tmp/tmp$$ | wc -l`
if ($nlines == 0) then
  echo Congratulations, no ST errors found
  exit 0
endif

echo "ERROR cgra_info.txt has one or more incorrect wire designations:"
echo "ERROR cgra_info.txt has one or more incorrect wire designations:"
echo "ERROR cgra_info.txt has one or more incorrect wire designations:"
echo
head -n 4 /tmp/tmp$$
echo

#     <mux snk='sb_wire_out_1_BUS16_3_3' reg='1' configh='37' configl='36' configr='58'>
#       <src sel='0'>in_1_BUS16_0_3</src>
#       <src sel='1'>in_1_BUS16_1_3</src>
#       <src sel='2'>in_1_BUS16_2_3</src>

cp cgra_info.txt cgra_info.txt.pre_st_fix

cat cgra_info.txt \
| sed -r 's/(in|out)_([01])_BUS(1|16)_([0-9])_([0-9])/\1_\2_BUS\3_S\4_T\5/' \
> /tmp/tmp$$

diff cgra_info.txt /tmp/tmp$$ | head
echo
cp /tmp/tmp$$ cgra_info.txt

echo WARNING patched cgra_info.txt ST boo-boos

