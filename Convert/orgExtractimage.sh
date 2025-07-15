#!/bin/sh

#Author: Johannes Deml, Johannes Kalliauer
#Source: http://www.inkscapeforum.com/viewtopic.php?t=16743
#Download: http://ge.tt/7C8JFmF1/v/0?c
#Download date: 2017-10-29

#last Changes: (by Johannes Kalliauer)
#2017-10-29 11h06 defined inkscape alias (Johannes Kalliauer)

echo
#needed if in the bashrc ist defined: export alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com'
if [ -z ${inkscape+x} ]; then
 echo not def
else
 echo $inkscape
 alias inkscape=$inkscape
fi

#Input parameters:
#alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com' #2017-10-29 11h06 (by Johannes Kalliauer)
#alias inkscape.exe='/cygdrive/c/Program\ Files/Inkscape/inkscape.exe'
# sourceType="svg"
outputType="svg"
valid=1


count=0
validInput1="svg"
validInput2="pdf"
validInput3="eps"
validInput4="emf"
validInput5="wmf"
validOutput1="eps"
validOutput2="pdf"
validOutput3="png"
validOutput4="svg"
validOutput5="plain-svg"


#echo "This script allows you to convert all files in this folder from one file type to another."

valid=0
while [ "$valid" != "1" ]
do
    echo "Allowed file types for source: $validInput1, $validInput2, $validInput3, $validInput4"
	read -p "What file type do you want to use as a source? " sourceType
    if [ "$sourceType" = "$validInput1" ] || [ "$sourceType" = "$validInput2" ] || [ "$sourceType" = "$validInput3" ] || [ "$sourceType" = "$validInput4" ] || [ "$sourceType" = "$validInput5" ]; then
        valid=1
    else
        echo "Invalid input! Please use one of the following: $validInput1, $validInput2, $validInput3"
    fi
done

for fileSource in *.$sourceType

do
 if [ -f "$fileSource" ]; then    
   count=$((count+1))
   file=$(echo $fileSource | cut -d'.' -f1)
   echo $count". "$fileSource" -> "${file}u.$outputType
   inkscape ./${fileSource} --actions="select-all;object-ungroup;object-ungroup;object-ungroup;object-ungroup;export-filename:${fileSource}.png;export-type:png;export-do;export-overwrite;file-close"
   #mv ./${fileSource} ./${file}DEL.xml
   echo ${fileSource}.png start #Add a empty line to split the output
   convert -trim "${fileSource}.png" "${fileSource}.png"
   trimage -f "${fileSource}.png" &
   echo ${fileSource}.png end #Add a empty line to split the output

 else
     echo "no file $fileSource found!"
 fi
 
 
 
done

wait

echo "$count file(s) converted!"
