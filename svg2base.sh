#!/bin/bash

#Author: Johannes Deml, Johannes Kalliauer
#Source: http://www.inkscapeforum.com/viewtopic.php?t=16743
#Download: http://ge.tt/7C8JFmF1/v/0?c
#Download date: 2017-10-29

#last Changes: (by Johannes Kalliauer)
#2017-10-29 11h06 defined inkscape alias (Johannes Kalliauer)

echo


#Input parameters:
#alias inkscape='/cygdrive/c/Program\ Files/Inkscape/inkscape.com' #2017-10-29 11h06 (by Johannes Kalliauer)
#alias inkscape.exe='/cygdrive/c/Program\ Files/Inkscape/inkscape.exe'
#sourceType="base64"; valid=1
#outputType="svg"
#outputType="png"


for fileSource in *.svg
do

 export i=$fileSource #i will be overwritten later
 export fileN=$(echo $fileSource | cut -f1 -d" ") #remove spaces if exsiting (and everything after)
 export tmp=${fileN%.base64}

 #If you want to overwrite the exisiting file, without any backup, delete the following three lines
 export i=${tmp}
 if [ -f "$i" ]; then
  echo no renaming
 else
  echo move
  mv "${fileSource}" $i
 fi
 
 #mv "${fileSource}.$sourceType" "${fileSource}2.xml"

 if [ -f "$i" ]; then    
  count=$((count+1))
  file=${i%.base64}
  echo $count". "$i" -> "${file}.base64
  sed -ri "s/iVBORw0KGgoAAAANSUhEUgAA/ \n iVBORw0KGgoAAAANSUhEUgAA/g" $i
  sed -ri "s/\/9j\/4AAQSkZJRgABAg(.)A(....)AAD\/7AARRHVja3kAAQAEAAAAHgAA/ \n \/9j\/4AAQSkZJRgABAg\1A\2AAD\/7AARRHVja3kAAQAEAAAAHgAA/g" $i
  sed -ri "s/(AAAAAElFTkSuQmCC|=)[ ]*\"(\/>| )/\1\n\"\2/g" $i
  sed -ri "s/\r/ /" $i
  sed -ri "s/\n/ /" $i
  
  grep "iVBORw0KGgoAAAANSUhEUgAA" $i > $file.png_base64
  grep "\/9j\/4AAQSkZJRgABAg.A....AAD\/7AARRHVja3kAAQAEAAAAHgAA"  $i > $file.jpeg_base64
  
  linenumbers=$(wc -l $file.png_base64|awk '{print $1}')
  if [ "$linenumbers" -gt 0 ]; then
   if [ "$linenumbers" = 1 ]; then 
    sed -i "s/ /\n/g" $file.png_base64
    base64 --decode ${file}.png_base64 > ${file}.png
    pngfilesize=$(wc -c ${file}.png|awk '{print $1}')
    if [ "$pngfilesize" = "0" ];then
     rm ${file}.png
    fi
   else # [ "$linenumbers" = 1 ]
    for ((ln=1;ln<=$linenumbers;ln++))
	do
	 	echo $ln
     sed -n "${ln}p" $file.png_base64 > $file.png${ln}_base64
     sed -i "s/ /\n/g" $file.png${ln}_base64
     base64 --decode ${file}.png${ln}_base64 > ${file}_File${ln}.png
	done
    #sed -n '2p' $file.png_base64 > $file.png2_base64
    #sed -i "s/ /\n/g" $file.png2_base64
    #base64 --decode ${file}.png2_base64 > ${file}_File2.png
   fi #[ "$linenumbers" = 1 ]
  fi # [ "$linenumbers" -gt 0 ]
   
  
  sed -i "s/ /\n/g" $file.jpeg_base64
  
  
  
  #base64.exe --decode ${file}.base64 > ${file}.png
  
  #if [ "$outputType" = "png" ];then #png
  
  #elif [ "$outputType" = "jpeg" ] || [ "$outputType" = "jpg" ];then
   base64 --decode ${file}.jpeg_base64 > ${file}.jpeg
  #fi
     jpegfilesize=$(wc -c ${file}.jpeg|awk '{print $1}')
  
  
     if [ "$jpegfilesize" = "0" ];then
      rm ${file}.jpeg
     fi
  
  
  
 else
      echo "no file $i found!"
 fi
 
 if [ "$outputType" = "svg" ] || [ "$outputType" = "plain-svg" ] || [ "$outputType" = "ink-svg" ]; then
  mv ${i} ${file}bak2.xml
 fi
	
done



echo "$count file(s) converted!"
