#!/bin/sh

#Author: Johannes Deml, Johannes Kalliauer
#Source: http://www.inkscapeforum.com/viewtopic.php?t=16743
#Download: http://ge.tt/7C8JFmF1/v/0?c
#Download date: 2017-10-29

#last Changes: (by Johannes Kalliauer)
#2017-10-29 11h06 defined inkscape alias (Johannes Kalliauer)


count=0

for fileSource in *.png

do
 if [ -f "$fileSource" ]; then
   count=$((count+1))
   
   mv "$fileSource" `echo ${fileSource} | tr ' ' '_'` ;
   file=$(echo $fileSource | cut -d'.' -f1)
   echo $count". "$fileSource" -> "${file}r.png
   
   chmod u+r ./${fileSource}
   convert -trim ./"${fileSource}" ./"${file}r.png"
   mv ./${fileSource} ./${file}.backup_png
  
 else
     echo "no file $fileSource found!"
 fi

done

echo "$count file(s) converted!"
