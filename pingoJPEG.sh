#!/bin/bash

for file in *.JPG
do

echo #Add a empty line to split the output

pingo -s9 $file
optipng $file
oxipng -o 6 -Z "$file"
  # pngout  "$file" & converts to damaged pngs

done

for file in *.jpg
do

echo #Add a empty line to split the output

pingo -s9 $file
optipng $file
oxipng -o 6 -Z "$file"
  # pngout  "$file" & converts to damaged pngs

done


wait