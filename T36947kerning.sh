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
export i=${tmp}k.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml
echo ${tmp}
echo $file

sleep 1

# export i=test.txt

echo 
echo $i start:
 
 #----
    #!/bin/bash
    
    #defining file
    #export i=test.txt
    
	#<svg width="1e3" height="1e3" font-family="Liberation Sans" font-weight="bold" letter-spacing="0" word-spacing="0" inkscape:version="0.92.3 (2405546, 2018-03-11)" sodipodi:docname="Belfast City Council Election, 2014 Map.svg" viewBox="0 0 264.583 264.583" xmlns="http://www.w3.org/2000/svg" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape" xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd">
	
#solved librsvg-Bug T194192 https://phabricator.wikimedia.org/T194192
#<svg font-family="ScriptS" font-size="5" viewBox="0,0,128,128"
sed -ri "s/<svg([-[:alnum:]=\"\.\/: ]*) viewBox=\"0,0,([[:digit:]\.]*),([[:digit:]\.]*)\"/<svg viewBox=\"0 0 \2 \3\"\1/g" $i

	
	#put viewBox at the beginning (otherwise I will have a variable to less)
	
	#<svg xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="815px" height="505px" viewBox="0 0 163 101" style="stroke-linecap :round; stroke-linejoin :round;">

	sed -ri 's/<svg([-[:alnum:]=\" \.\/:\,\(\)_#]+) viewBox="([-[:digit:] \.]+)"([-[:alnum:]=\" \.\/:\,\(\);]*)>/<svg viewBox="\2"\1\3>/' $i
	sed -ri 's/\r/\n/g' $i
	
    #Define file as a variable
    export h=$(sed -r 's/<svg viewBox="([-[:digit:]]+) ([-[:digit:]]+) ([[:digit:]]+)\.([[:digit:]])([[:digit:]]*) ([[:digit:]]+)\.([[:digit:]])([[:digit:]]*)"([-[:alnum:]=\" \.\/:\,\(\)_;]+)>/<svg viewBox="\1 \2 \3\4.\50 \6\7.\80"\9><g transform="scale(10)">/' $i)
    
    #Reading out the relevant line
    export j=$(ls -l|grep -E "viewBox=\"[-[:digit:].]{1,5} [-[:digit:].]{1,5} [[:digit:].]{2,10} [[:digit:].]{2,8}" $i)
    
    #Insert a special character to define the point of splitting
    export l=$(echo $j | sed -e "s/viewBox=\"/>/g" )
    
    #split at this special character and take the part afterwards
    export m=$(echo $l | cut -f2 -d">")
    
    #Multiply the four numbers by a factor of 10
    export n=$(echo $m | awk  '{printf "%f %f %f %f\n",$1*10,$2*10,$3*10,$4*10}')
    
    #Replace the old four numbers with the new four numbers
    sed -ri "s/<svg([-[:alnum:]=\" \.\/:;\,#]*) viewBox=\"[-[:digit:]\.]+ [-[:digit:]\.]+ [[:digit:]\.]+ [[:digit:]\.]+\"([-[:alnum:]=\" \.\/:\,#\(\)_;]+)>/<svg\1 viewBox=\"$n\"\2>\n<g transform=\"scale(10)\">/" $i
	#<svg id="svg562" version="1.1" viewBox="0 0 640 360" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xlink="http://www.w3.org/1999/xlink">
 #----

  sed -ri 's/<\/svg>/<\/g>\n<\/svg>/' $i

 
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
