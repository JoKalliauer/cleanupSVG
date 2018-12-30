#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

#./ScourFull.sh #damit man einzeilTags hat
##./einzeilTags.sh

for file in *.svg;do

## == Remove scecial characters in filename ==

#export i=$file #i will be overwritten later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

#If you want to overwrite the existing file, without any backup, delete the following three lines
export i=${tmp}_.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml
echo ${tmp}
echo $file

sleep 1

echo 
echo $i start:
 
 #----
    #!/bin/bash
    
    #defining file
    #export i=test.svg
    
    #Define file as a variable
    export h=$(sed -r 's/<svg ([-[:alnum:]=\" \.\/:\,]+) viewBox="([-[:digit:]]+) ([-[:digit:]]+) ([[:digit:]]+)\.([[:digit:]])([[:digit:]]*) ([[:digit:]]+)\.([[:digit:]])([[:digit:]]*)"([-[:alnum:]=\" \.\/:\,]+)>/<svg \1 viewBox="0 0 \2\3.\40 \5\6.\70"\8><g transform="scale(10)">/' $i)
    
    #Reading out the relevant line
    export j=$(ls -l|grep -E "viewBox=\"[-[:digit:].]{1,5} [-[:digit:].]{1,5} [[:digit:].]{3,7} [[:digit:].]{3,7}" $i)
    
    #Insert a special character to define the point of splitting
    export l=$(echo $j | sed -e "s/viewBox=\"/>/g" )
    
    #split at this special character and take the part afterwards
    export m=$(echo $l | cut -f2 -d">")
    
    #Multiply the four numbers by a factor of 10
    export n=$(echo $m | awk  '{printf "%f %f %f %f\n",$1*10,$2*10,$3*10,$4*10}')
    
    #Replace the old four numbers with the new four numbers
    sed -ri "s/<svg([-[:alnum:]=\" \.\/:;\,#]*) viewBox=\"[-[:digit:]\.]+ [-[:digit:]\.]+ [[:digit:]\.]+ [[:digit:]\.]+\"([-[:alnum:]=\" \.\/:\,#]+)>/<svg \1 viewBox=\"$n\"\2><g transform=\"scale(10)\">/" $i
	#<svg id="svg562" version="1.1" viewBox="0 0 640 360" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xlink="http://www.w3.org/1999/xlink">
 #----

  sed -ri 's/<\/svg>/<\/g><\/svg>/' $i

 
echo $i finish



done
comment=<<END
./CleanerFull.sh #wegen Inkscape-Bug

#./PosibleUngroup.sh
./UngroupByInkscape.sh #for removing the groups and increasing font-size
#./einzeilTags.sh
./Rounding.sh #for removing rounding errors


#./CleanerFull.sh
./IskartOptimizer.sh #for reducing file size

./svg2validsvg.sh #for correcting the png-files and adding DTD
#./cleaner4compression.sh
#./o4compression.sh #https://github.com/svg/svgo/issues/1001
#./scour4compression.sh #https://github.com/scour-project/scour/issues/202
#./CleanerFull.sh
#./RasterOptimizer.sh
./fontReplace.sh #for replacing Arial with Liberation Sans
#./validBycleaner.sh
#./svg2validsvg.sh
#./validByScour.sh
END
