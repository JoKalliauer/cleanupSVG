#!/bin/bash

echo $1

if [ -z $1 ]; then
 for file in *.png
  do

  echo $file pngout start #Add a empty line to split the output

  pngout  "$file" &
  
  echo $file pngout end #Add a empty line to split the output

  done
else
 pngout $1

fi

echo ====ONLY_Waiting====

wait
echo finish

