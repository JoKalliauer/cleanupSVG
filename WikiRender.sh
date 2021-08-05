#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output
  echo $file

 time ~/prgm/librsvg-2.40.21/rsvg-convert "$file" >"${file%.svg}_librsvg240.png"

done


