#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output
  echo $file

 #resvg "$file" "${file%.svg}_re0_11.png"
 #cargo run --manifest-path ~/Documents/GitHub/resvg/Cargo.toml --release -- "$file" "${file%.svg}_re.png"
 time ~/Dokumente/GitDesktop/resvg/target/release/resvg "$file" "${file%.svg}_rendersvg.png"

 time /home/jokalliau/prgm/librsvg-2.40.20/rsvg-convert "$file" >"${file%.svg}_librsvg24020.png"
 time /home/jokalliau/prgm/librsvg-2.40.21/rsvg-convert "$file" >"${file%.svg}_librsvg24021.png"

 time rsvg-convert "$file" >"${file%.svg}_librsvg.png"

 time /home/jokalliau/Dokumente/GitDesktop/librsvg/rsvg-convert "$file" >"${file%.svg}_librsvg251.png"

 #/snap/inkscape/current/bin/inkscape "$file" --export-type="png"
 time inkscape "$file" --export-type="png"
 ##inkscape "$file" --export-png="${file%.svg}_ink092.png"
 mv "${file%.svg}.png" "${file%.svg}_Inkscape.png"


 time java -jar ~/prgm/batik-1.14/batik-rasterizer-1.14.jar "$file" -d "${file%.svg}_batik.png"


done


