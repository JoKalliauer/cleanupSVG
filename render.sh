#!/bin/bash

for file in *.svg
 do

 echo #Add a empty line to split the output
  echo $file

 echo resvg
 #time ~/Dokumente/GitDesktop/resvg/target/release/resvg "$file" "${file%.svg}_rendersvg.png"
 time taskset -c 0 resvg "$file" "${file%.svg}_rendersvg.png"

 echo c-librsvg:24020,24021,system,251
 #time taskset -c 0 /home/jokalliau/prgm/librsvg-2.40.20/rsvg-convert "$file" >"${file%.svg}_librsvg24020.png"
 PATH=$PATH:~/prgm/libcroco-0.6.13/src/.libs
 time taskset -c 0 ~/prgm/librsvg-2.40.21/rsvg-convert "$file" >"${file%.svg}_librsvg24021.png"

 echo system-librsvg
 time taskset -c 0 rsvg-convert "$file" >"${file%.svg}_librsvg.png"

 #time taskset -c 0 /home/jokalliau/Dokumente/GitDesktop/librsvg/rsvg-convert "$file" >"${file%.svg}_librsvg251.png"

 echo inkscape
 #/snap/inkscape/current/bin/inkscape "$file" --export-type="png"
 time taskset -c 0 inkscape "$file" --export-type="png"
 ##inkscape "$file" --export-png="${file%.svg}_ink092.png"
 mv "${file%.svg}.png" "${file%.svg}_Inkscape.png"

 echo batik
 time taskset -c 0 java -jar ~/prgm/batik-1.14/batik-rasterizer-1.14.jar "$file" -d "${file%.svg}_batik.png"


done


