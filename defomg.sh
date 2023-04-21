#!/bin/bash

for file in *.svg;do
chmod u+r "${file}"
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}o.svg

echo #Add a empty line to split the output

svgo -i ${file} -o $i --pretty --indent=1 # --disable=removeXMLProcInst --disable=removeDoctype

mv ./${file} ./${tmp}5.xml


done

