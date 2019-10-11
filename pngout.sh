#!/bin/bash

echo $1

if [ -z $1 ]; then
 for file in *.png
  do

  echo #Add a empty line to split the output
 
  #pingo $file
  optipng $file
  pngout  $file &
  #pingo $file

  done
else

 optipng $1
 pngout $1

fi

wait
echo finish

