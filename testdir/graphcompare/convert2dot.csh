#!/bin/csh -f

# Convert json or bsa file to dotfile

unset yakky

goto MAIN
USAGE:
  echo ""
  echo "Usage:"
  echo "  $0:t [-v] INFILE OUTFILE [CGRA_INFO_FILE]"
  echo ""
  echo "Where:"
  echo "  INFILE can be json or bsa"
  echo "  <-v> optional verbose mode, else silent"
  echo "  <CGRA_INFO_FILE> recommended for comparing bsa/annotated bitstream file(s)"
  echo ""
  echo "Examples:"
  echo "  $0:t bw_annotated bw_annotated.dot ../cgra_info.txt"
  echo "  $0:t bw_design_top.json bw.json.dot"
  echo ""
  exit

MAIN:
# -v => 'verbose'
if ("$1" == "-v") then
  set yakky
  shift
endif

set scripthome = $0:h
if ("$scripthome" == "$0") set scripthome = .

if ($#argv < 2) goto USAGE
if ($#argv > 3) goto USAGE

set infile = $1
set outfile = $2

if (! -e $infile) then
  echo; echo "ERROR No such file '$infile'"; goto USAGE
else if (-e $outfile) then
  echo; echo "ERROR Don't want to overwrite existing file '$outfile'"; goto USAGE
endif

set type = `$scripthome/filetype.csh $infile`

if ("$type" == "bsa") then
  # CONVERT BSA FILE
  if ($?yakky) echo '$infile' appears to be a bsa file...

  set cgra_info = $3
  if ("$cgra_info" == "") then
    set cgra_info = $scripthome/examples/cgra_info.txt
    echo ""
    echo "WARNING No cgra_info file specified; "
    echo "WARNING will use default $cgra_info"
    echo ""
  endif

  if (! -e $cgra_info) then
    echo; echo "ERROR Cannot find cgra_info file '$cgra_info'"; goto USAGE
  endif

  set viz = $scripthome/../../bitstream/visualizer

  # (For now?) ignore this warning(s):
  # /usr/lib/python2.7/dist-packages/gtk-2.0/gtk/__init__.py:57: GtkWarning: could not open display
  # warnings.warn(str(e), _gtk.Warning)
  # Using config file 'CGRAGenerator/testdir/graphcompare/examples/cgra_info.txt'
  # Xlib:  extension "RANDR" missing on display "neva-2:9".

  if ($?yakky) echo Building "$outfile"...
  $viz/bsview.py -cgra_info $cgra_info $infile -dot $outfile\
    |& grep . | grep -v GtkWarning | grep -v gtk.Warning | grep -v RANDR\
    | grep -v 'Using config'

  if ($?yakky) echo Applying input hack to "$outfile"...
  set tmp = /tmp/tmp.convert2dot.$$
  mv $outfile $tmp
  $scripthome/fix_input_hack.csh $tmp > $outfile
  if ($?yakky) then
    echo BEFORE:
    diff $tmp $outfile | egrep '^<' | grep self
    diff $tmp $outfile | egrep '^<' | grep const
    diff $tmp $outfile | egrep '^<' | egrep -v 'self|const'
    echo AFTER:
    diff $tmp $outfile | egrep '^>'
  endif


else
  # CONVERT JSON FILE
  # echo; echo "ERROR Cannot determine type of file '$f1'"; goto USAGE
  # If it's not bsa it's json :D
  if ($?yakky) echo '$infile' is not a bsa file, so must be json...

  set j2d = $scripthome/json2dot.py
  if ($?yakky) echo Building $outfile...
  $j2d < $infile > $outfile

endif
