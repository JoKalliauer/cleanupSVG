#!/bin/bash

echo $1

if [ -z $1 ]; then
 for file in *.png
  do

  echo $file start #Add a empty line to split the output

  #pingo $file
  optipng "$file"
  #pingo -s9 "$file"
  
  echo $file end #Add a empty line to split the output

  done
 for file in *.png
  do

  echo $file oxipng start #Add a empty line to split the output

  oxipng -o 6 -Z  "$file"
  
  echo $file oxipng end #Add a empty line to split the output

  done
 for file in *.png
  do

  echo $file pngout start #Add a empty line to split the output

  pngout  "$file"
  
  echo $file pngout end #Add a empty line to split the output

  done
else

 optipng $1
 # pingo -s9 $1 only on Windows maybe on WSL
 oxipng -o 6 -Z $1
 pngout $1

fi

echo ====ONLY_Waiting====

wait
echo finish

