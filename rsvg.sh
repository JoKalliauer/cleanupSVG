#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output

 rsvg-convert "$file" >"${file%.svg}_r.png"

done
  
  
