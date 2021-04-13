export APPNAME=$1
export DESIGNTYPE=$2
export EXPERIMENT=$3
cp -f $DESIGNTYPE/design.pt.sdc .
perl -i -p0e 's/}\][\n\s]+append_to_collection __coll_\d+\s+\[get_pins {/      /gms' design.pt.sdc
pt_shell -f ptpx.tcl | tee logs/${APP}_pt.log

