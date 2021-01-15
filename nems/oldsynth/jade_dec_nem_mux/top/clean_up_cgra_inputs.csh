if [ ! -d cgra_info_txt_inputs ]; then
  mkdir cgra_info_txt_inputs
fi

for f in `find . -maxdepth 1 -name "TILE*" -o -name "CB*" -o -name "SB*" -o -name "MEM*"`; do
  mv -f $f cgra_info_txt_inputs/$f
done
