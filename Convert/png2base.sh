#!/bin/sh

#Author: Johannes Deml, Johannes Kalliauer

#last Changes: (by Johannes Kalliauer)
#2025-08-19 simplified

echo

#Input parameters:
#alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com' #2017-10-29 11h06 (by Johannes Kalliauer)
#alias inkscape.exe='/cygdrive/c/Program\ Files/Inkscape/inkscape.exe'
#sourceType="png"; valid=1
outputType="base64"



count=0
validInput1="svg"
validInput1a="xml"
validInput1b="txt"
validInput2="pdf"
validInput3="eps"
validInput4="png"
validInput5="jpg"
validInput6="jpeg"


#echo "This script allows you to convert all files in this folder from one file type to another."

#valid=0
if [ -z $sourceType ]; then
 while [ "$valid" != "1" ]
 do
     echo "Allowed file types for source: $validInput4, $validInput5, $validInput6"
 	read -p "What file type do you want to use as a source? " sourceType
     if [ "$sourceType" = "$validInput1" ] || [ "$sourceType" = "$validInput1a" ] || [ "$sourceType" = "$validInput1b" ] || [ "$sourceType" = "$validInput2" ] || [ "$sourceType" = "$validInput3" ] || [ "$sourceType" = "$validInput4" ] || [ "$sourceType" = "$validInput5" ] || [ "$sourceType" = "$validInput6" ]; then
         valid=1
     else
         echo "Invalid input! Please use one of the following: $validInput1, $validInput2, $validInput3"
     fi
 done
fi


for fileSource in *.$sourceType
 do
  

  export i=$fileSource #i will be overritan later
  echo $i

   if [ -f "$i" ]; then    
        count=$((count+1))
        file=${i%.base64}
        echo $count". "$i" -> "${file}.$outputType
		

		  openssl base64 -in ${file} -out ${file}.txt

    else
        echo "no file $i found!"
    fi

	
 done

 echo "$count file(s) converted!"





