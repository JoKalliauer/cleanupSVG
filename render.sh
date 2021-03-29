#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output
  echo $file

<<<<<<< HEAD
 #resvg "$file" "${file%.svg}_re0_11.png"
 #cargo run --manifest-path ~/Documents/GitHub/resvg/Cargo.toml --release -- in.svg out.png
 ~/Dokumente/GitDesktop/resvg/target/release/resvg "$file" "${file%.svg}_rendersvg.png"
 
 rsvg-convert "$file" >"${file%.svg}_librsvg.png"
 
 #/snap/inkscape/current/bin/inkscape "$file" --export-type="png"
 inkscape "$file" --export-type="png"
 ##inkscape "$file" --export-png="${file%.svg}_ink092.png"
 mv "${file%.svg}.png" "${file%.svg}_Inkscape.png"
 
 
 java -jar ~/prgm/batik-1.14/batik-rasterizer-1.14.jar "$file" -d "${file%.svg}_batik.png"
=======
 resvg "$file" "${file%.svg}_re0_11.png"
 cargo run --manifest-path ~/Documents/GitHub/resvg/Cargo.toml --release -- "$file" "${file%.svg}_re.png"
 #/home/jkalliau/prgm/resvg-0.9.0/target/release/rendersvg "$file" "${file%.svg}_re09.png"
 rsvg-convert "$file" >"${file%.svg}_r248.png"
 ##/home/jkalliau/prgm/librsvg-2.47.3/rsvg-convert "$file" >"${file%.svg}_r247.png"
 #/snap/inkscape/current/bin/inkscape "$file" --export-type="png"
 inkscape "$file" --export-type="png"
 ##inkscape "$file" --export-png="${file%.svg}_ink092.png"
 java -jar /home/jkalliau/prgm/batik-1.14/batik-rasterizer-1.14.jar "$file" -d "${file%.svg}_batik.png"
>>>>>>> e4212936e378b9b8f2323d3fbe193d6d6a45cbcb

done
  
  
