#!/bin/sh

#Author: Johannes Kalliauer

#last Changes: (by Johannes Kalliauer)
#2025-08-19 22h10 simplified, autodectect extension

echo

count=0

for i in *.base64; do
 [ -f "$i" ] || { echo "no file $i found!"; continue; }
        count=$((count+1))
        file=${i%.base64}
        
        sed -i -e 's/^data:image\/[^;]*;base64,//I' "${file}.base64"
        
        # 1) Base64-Text laden, Data-URI-Präfix entfernen, Whitespaces löschen
       b64="$(cat -- "$i")"
			  
		# 2) Dateityp am Base64-Prefix erkennen (ohne zu dekodieren)
		case "$b64" in 
			iVBORw0KGgoAAAANSUhEUgAA*) ext="png" ;;
			/9j/*)                     ext="jpeg";;
		esac

		
		echo $count". "$i" -> "${file}.$ext
        
		if [ "$ext" = "png" ];then #png
		 base64 --decode ${file}.base64 > ${file}.png
		elif [ "$ext" = "jpeg" ] || [ "$ext" = "jpg" ];then
		 base64 --decode ${file}.base64 > ${file}.jpeg
		fi

	
done



echo "$count file(s) converted!"
