#!/bin/bash

for file in *.svg;do
#export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}s.svg

echo #Add a empty line to split the output

echo scour ${file} to $i begin

scour -i ${file} -o $i  

mv ./${file} ./${tmp}3.xml

echo scour $i finish

done

