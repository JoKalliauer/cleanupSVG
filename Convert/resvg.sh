#!/bin/bash

for file in *.svg
 do
 chmod u+r "${file}" #for running in cygwin

 echo #Add a empty line to split the output

 resvg "$file" "${file%.svg}_re.png"
 #/usr/bin/rsvg-convert "$file" >"${file%.svg}_r.png"

done


