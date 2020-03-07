#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output

 #/home/jkalliau/prgm/resvg-0.9.0/target/release/rendersvg "$file" "${file%.svg}_re.png"
 /usr/bin/rsvg-convert "$file" >"${file%.svg}_r.png"

done
  
  
