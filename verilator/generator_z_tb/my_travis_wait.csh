#!/bin/csh -f

set max = $1
set i = 0

while ($i < $max)
  echo MY TRAVIS WAIT $i/$max
  sleep 60
  @ i = $i + 1
end
