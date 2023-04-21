#!/bin/sh


for file in *.svg
do
 inkscape "$file" --export-type="png"
done

