#!/bin/bash

echo $1

if [ -z $1 ]; then
 
 for file in *.png
  do
  echo $file start #Add a empty line to split the output
  convert -trim "$file" "$file"
  trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 for file in *.jpg
  do
  echo $file start #Add a empty line to split the output
  convert -trim "$file" "$file"
  trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 for file in *.jpeg
  do
  echo $file start #Add a empty line to split the output
  trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 for file in *.JPG
  do
  echo $file start #Add a empty line to split the output
  trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 for file in *.tiff
  do
  echo $file start #Add a empty line to split the output
  trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 for file in *.tif
  do
  echo $file start #Add a empty line to split the output
  trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 
else

 trimage $1

fi

echo ====ONLY_Waiting====

wait
echo finish

