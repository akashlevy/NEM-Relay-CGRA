if [ -d genesis_verif/orig ]; then
  rm -rf genesis_verif/orig
fi
mkdir genesis_verif/orig
for f in `find ./genesis_verif -name "*.*v"`; do
  f_new=${f/.v/.v.orig}
  f_new=${f_new/.sv/.sv.orig}
  f_new=${f_new/genesis_verif/genesis_verif/orig}
 
  mv -f $f $f_new
  grep -v "___genesis_wire" $f_new > $f
done
