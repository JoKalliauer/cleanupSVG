#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output

 resvg "$file" "${file%.svg}_re0_11.png"
 #cargo run --manifest-path ~Documents/GitHub/resvg/Cargo.toml --release -- in.svg out.png
 #/home/jkalliau/prgm/resvg-0.9.0/target/release/rendersvg "$file" "${file%.svg}_re09.png"
 /usr/bin/rsvg-convert "$file" >"${file%.svg}_r248.png"
 ##/home/jkalliau/prgm/librsvg-2.47.3/rsvg-convert "$file" >"${file%.svg}_r247.png"
 /snap/inkscape/current/bin/inkscape "$file" --export-type="png"
 ##inkscape "$file" --export-type="png"
 ##inkscape "$file" --export-png="${file%.svg}_ink092.png"
 java -jar /home/jkalliau/prgm/batik-1.12/batik-rasterizer-1.12.jar "$file" -d "${file%.svg}_batik.png"

done
  
  
