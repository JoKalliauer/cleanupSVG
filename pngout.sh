#!/bin/bash

echo $1

if [ -z $1 ]; then
 for file in *.png
  do

  echo #Add a empty line to split the output

  #pingo $file
  optipng "$file"
  pingo -s9 "$file"
  oxipng -o 6 -Z  "$file"
  pngout  "$file" &

  done
else

 optipng $1
 pingo -s9 $1
 oxipng -o 6 -Z $1
 pngout $1

fi

wait
echo finish

