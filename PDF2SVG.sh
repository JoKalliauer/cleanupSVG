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
 echo $inkscape #inkscape not defined
else
 echo $inkscape
 alias inkscape=$inkscape
fi

#Input parameters:
#alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com' #2017-10-29 11h06 (by Johannes Kalliauer)
#alias inkscape.exe='/cygdrive/c/Program\ Files/Inkscape/inkscape.exe'
sourceType="pdf"; valid=1
outputType="svg"



count=0
validInput1="svg"
validInput1a="xml"
validInput1b="txt"
validInput2="pdf"
validInput3="eps"

validOutput1="eps"
validOutput2="pdf"
validOutput3="png"
validOutput4="svg"
validOutput5="plain-svg"
validOutput6="inkscape-svg"
validOutput7="inkscapesvg"
validOutput8="ink-svg"
validOutput9="png96"



#echo "This script allows you to convert all files in this folder from one file type to another."



for fileSource in *.$sourceType
do

 export i=$fileSource #i will be overritan later
 export fileN=$(echo $fileSource | cut -f1 -d" ") #remove spaces if exsiting (and everything after)
 export tmp=${fileN%.svg}

 #If you want to overwrite the exisiting file, without any backup, delete the following three lines
 export i=${tmp}.$sourceType
 if [ -f "$i" ]; then
  echo no renaming
 else
  echo move
  mv ./"${fileSource}" $i
 fi
 
 #mv ./"${fileSource}.$sourceType" "./${fileSource}2.xml"

   if [ -f "$i" ]; then    
        count=$((count+1))
        file=${i%.svg}
        echo $count". "$i" -> "${file}n.$outputType
		sed -ri "s/inkscape:version=\"0.4[\. r[:digit:]]+\"//g" $i
		
		if [ "$outputType" = "svg" ];then #  svg
		 inkscape $i --export-plain-$outputType=${file}n.$outputType
		elif [ "$outputType" = "$validOutput6" ] || [ "$outputType" = "$validOutput7" ] || [ "$outputType" = "$validOutput8" ]; then #inkscape-svg
		  cp ./${fileSource} ./${file}Ink.svg
		  mv ./${fileSource} ./${file}.xml
		 inkscape ./${file}Ink.svg --no-convert-text-baseline-spacing --verb=FileSave --verb=FileClose --verb=FileQuit
		else #eps, pdf, plain-svg and others
		 inkscape $i --export-$outputType=$file.$outputType
		fi
    else
        echo "no file $i found!"
    fi
	
	if [ "$outputType" = "svg" ] || [ "$outputType" = "plain-svg" ] || [ "$outputType" = "ink-svg" ]; then
	 mv ./${i} ./${file}bak2.xml
	fi
	
done



echo "$count file(s) converted!"
