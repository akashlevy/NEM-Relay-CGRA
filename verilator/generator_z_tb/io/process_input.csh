#!/bin/csh -f

# Usage: set input_filename = `process_input.csh <input-filename> (tmpdir> | tail -1`
# Output:
#    <possible several lines of random debug info>
#    <output-filename>

#   if input file has extension ".png" => convert to raw
#   if input file has extension ".raw" => use input file as is

  set vswitch = $1
  set input = $2
  set tmpdir = $3

  unset VERBOSE
  if ("$vswitch" == "-v") set VERBOSE

  set iroot = $input:t; set iroot = $iroot:r
  if ("$input:e" == "png") then
    if ($?VERBOSE) then
      echo "  Converting input file '$input' to '$tmpdir/$iroot.raw'..."
      echo "  io/myconvert.csh $input $tmpdir/$iroot.raw"
      echo
      echo -n "  "
      io/myconvert.csh $input $tmpdir/$iroot.raw || exit 13
    else
      io/myconvert.csh -q $input $tmpdir/$iroot.raw || exit 13
    endif
    set input = "$tmpdir/$iroot.raw"

  else if ("$input:e" == "raw") then
    if ($?VERBOSE) then
      echo "  Using raw input from '$input'..."
      # echo "  cp $input $tmpdir/$iroot.raw"
    endif
    # cp $input $tmpdir/$iroot.raw

  else
    echo "ERROR process_input.csh: Input file '$input' has invalid extension"
    exit -1

  endif
  echo $input
