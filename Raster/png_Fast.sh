#!/bin/bash

echo $1

if [ -z $1 ]; then
 for file in *.png
  do

  echo $file start #Add a empty line to split the output

  #pingo $file
  optipng "$file"
  pingo -s9 "$file" &
  
  echo $file end #Add a empty line to split the output

  done
else

 optipng $1
 pingo -s9 $1

fi

echo ====ONLY_Waiting====

wait
echo finish

