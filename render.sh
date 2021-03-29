#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output
  echo $file

 #resvg "$file" "${file%.svg}_re0_11.png"
 #cargo run --manifest-path ~/Documents/GitHub/resvg/Cargo.toml --release -- in.svg out.png
 ~/Dokumente/GitDesktop/resvg/target/release/resvg "$file" "${file%.svg}_rendersvg.png"
 
 rsvg-convert "$file" >"${file%.svg}_librsvg.png"
 
 #/snap/inkscape/current/bin/inkscape "$file" --export-type="png"
 inkscape "$file" --export-type="png"
 ##inkscape "$file" --export-png="${file%.svg}_ink092.png"
 mv "${file%.svg}.png" "${file%.svg}_Inkscape.png"
 
 
 java -jar ~/prgm/batik-1.14/batik-rasterizer-1.14.jar "$file" -d "${file%.svg}_batik.png"

done
  
  
