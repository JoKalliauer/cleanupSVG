#!/bin/sh

#Author: Johannes Deml, Johannes Kalliauer
#Source: http://www.inkscapeforum.com/viewtopic.php?t=16743
#Download: http://ge.tt/7C8JFmF1/v/0?c
#Download date: 2017-10-29

#last Changes: (by Johannes Kalliauer)
#2017-10-29 11h06 defined inkscape alias (Johannes Kalliauer)
#2023-06-13 +emf

echo
#needed if in the bashrc ist defined: export alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com'
if [ -z ${inkscape+x} ]; then
 echo $inkscape #inkscape not defined
else
 echo $inkscape
 alias inkscape=$inkscape
fi

#Input parameters:
sourceType="svg";



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
validOutput0="emf"



if [ -z ${outputType+x} ]; then
  valid=0 #ask it output is not defined
fi

while [ "$valid" != "1" ]
do
    echo "Allowed file types for output: $validOutput1, $validOutput2, $validOutput3, $validOutput4 (plain), $validOutput5, $validOutput8"
	read -p "What file type do you want to convert to? " outputType
    if [ "$outputType" = "$validOutput1" ] || [ "$outputType" = "$validOutput2" ] || [ "$outputType" = "$validOutput3" ] || [ "$outputType" = "$validOutput4" ] || [ "$outputType" = "$validOutput5" ] || [ "$outputType" = "$validOutput6" ] || [ "$outputType" = "$validOutput7" ] || [ "$outputType" = "$validOutput8" ] || [ "$outputType" = "$validOutput9" ] || [ "$outputType" = "$validOutput0" ]; then
        valid=1
    else
        echo "Invalid input! Please use one of the following: $validOutput1, $validOutput2, $validOutput3, $validOutput4, $validOutput0"
    fi
done

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
        #echo $count". "$i" -> "${file}n.$outputType
		sed -ri "s/inkscape:version=\"0.4[\. r[:digit:]]+\"//g" $i
		
		if [ "$outputType" = "png" ];then #png
		 read -p "With what dpi should it be exported (e.g. 300, default: 96)? " dpi
		 inkscape $i --export-$outputType=$file.$outputType --export-dpi=$dpi
		elif [ "$outputType" = "svg" ] || [ "$outputType" = "plain-svg" ];then #  svg  #plain-svg
		 echo $count". "$i" -> "${file}n.$outputType
		 #inkscape $i --export-plain-$outputType=${file}n.$outputType
		 #cp $i ./${file}n.$outputType
		 inkscape --export-type="$outputType" ./${file}.$outputType
		 sed -ri "s/font-family:([-[:alnum:] ,']*)'([-[:alnum:] ]*)'([-[:lower:][:upper:], ']*)/font-family:\1\2\3/g" ${file}n.svg
		elif [ "$outputType" = "$validOutput6" ] || [ "$outputType" = "$validOutput7" ] || [ "$outputType" = "$validOutput8" ]; then #inkscape-svg
		  cp ./${fileSource} ./${file}Ink.svg
		  mv ./${fileSource} ./${file}.xml
		 inkscape ./${file}Ink.svg --no-convert-text-baseline-spacing --verb=FileSave --verb=FileClose --verb=FileQuit
		 sed -ri "s/font-family:([-[:alnum:] ,']*)'([-[:alnum:] ]*)'([-[:lower:][:upper:], ']*)/font-family:\1\2\3/g" ./${file}Ink.svg
		elif  [ "$outputType" = "$validOutput9" ];then #png96
		 #inkscape $i --export-png=$file.png
		 inkscape $i --export-type="png"
		else #eps, pdf and others
		 echo $count". "$i" -> "${file}.$outputType
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
