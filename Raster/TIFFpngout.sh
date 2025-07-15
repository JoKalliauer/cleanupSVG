#!/bin/bash

echo $1



if [ -z $1 ]; then
tifFiles=$(find . -type f -name "*.tiff" -o -name "*.tif" -o -name "*.TIFF")
 for file in $tifFiles
  do

  echo $file start #Add a empty line to split the output

  #pingo $file
  optipng "$file"
  #pingo -s9 "$file"
  
  echo $file end #Add a empty line to split the output

  done

  #oxipng -o 6 -Z  "$file" https://github.com/shssoichiro/oxipng/issues/643

 for file in $tifFiles
  do

  echo $file pngout start #Add a empty line to split the output

  pngout  "$file" &
  
  echo $file pngout end #Add a empty line to split the output

  done
else

 optipng $1
 pingo -s9 $1
 oxipng -o 6 -Z $1
 pngout $1

fi

echo ====ONLY_Waiting====

wait
echo finish

