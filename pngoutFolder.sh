#!/bin/bash

echo $1

if [ -z $1 ]; then
 pngfiles_1=$(find . -type f -name "*.png" -o -name "*.PNG" -name "*.png.owncloud") # all pdffiles in subfolders
 pngfiles=`echo ${pngfiles_1// /%20}`
 for file in $pngfiles
  do

  echo $file start #Add a empty line to split the output

  # pingo -lossless $file
  optipng "$file"
  pingo.exe -s4 -lossless "$file"
  
  echo $file end #Add a empty line to split the output

  done
 for file in $pngfiles
  do

  echo $file oxipng start #Add a empty line to split the output

  # oxipng -o 6 -Z  "$file" very slow
  oxipng -o 6 "$file"
  
  echo $file oxipng end #Add a empty line to split the output

  done
 for file in $pngfiles
  do

  echo $file pngout start #Add a empty line to split the output
 
  if [ -f "$file" ] && grep -q PNG "$file"; then
   pngout  "$file"
  else
   echo not a png-file
  fi
  
  echo $file pngout end #Add a empty line to split the output

  done
else

 optipng $1
 pingo -s4 -lossless $1
 oxipng -o 6 -Z $1
 if [ -f "$1" ] && grep -q PNG "$1"; then
  pngout  $1
 else
  echo not a png-file
 fi

fi

echo ====ONLY_Waiting====

wait
echo finish

