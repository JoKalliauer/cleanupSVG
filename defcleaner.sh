#!/bin/bash

for file in *.svg;do
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}c.svg
echo #Add a empty line to split the output

echo cleaner ${file} to $i begin, min=${minfilesize}, METAdelete=$META, INDENT=$INDENT

svgcleaner $file $i --allow-bigger-file --indent 1

mv ./${file} ./${tmp}4.xml

#echo cleaner $i finish

done

