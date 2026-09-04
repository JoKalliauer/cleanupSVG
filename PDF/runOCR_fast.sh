#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2023-07-08

#Last Edits:
#2023-07-08 JK: created file
#2023-08-17 JK: touch time, rm old file

# loop over all pdf-files
#cd "/mnt/c/Users/johannes.kalliauer/sonstiges"
#cd ~/Documents
#mkdir OCR
#echo $(find . -name '*.pdf')
pdffiles_1=$(find . -type f -name "*.pdf" -o -name "*.PDF" -name "*.pdf.owncloud") # all pdffiles in subfolders
pdffiles=`echo ${pdffiles_1// /%20}` # replace all whitespaces with %20
for file in $pdffiles #https://superuser.com/a/363438/631374
#for file in *.pdf ./**/*.pdf ./**/**/*.pdf ./**/**/**/*.pdf ./**/**/**/**/*.pdf ./**/**/**/**/**/*.pdf ./**/**/**/**/**/**/*.pdf  #https://stackoverflow.com/a/15088473/6747994
 do
 #echo "$file"
 export file="${file//%20/ }" # convert %20 to whitespace
 #export file_spaces2underline="${file// /_}" # convert whitespace to underlinee
 #export file_normaliced="${file_spaces2underline//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}" #remove all special characters in filename
 export tmp=${file%.pdf} #remove .pdf at the end 
 export outputfile="./${tmp}_pdfA.pdf"
 
 if [[ "$file" == *_ocrmypdf.pdf || "$file" == *_pdfX.pdf ]]; then
  echo skipping $file
  #echo
 elif [ -f "$file" ] && ! grep -q ocrmypdf "$file"; then
 #elif [ -f "$file" ] && ! grep -q "%¿÷¢þ" "$file"; then
  chmod u+r "${file}"
  echo converting "${file}" #ocrmypdf --optimize 01 -l deu+eng "${file}" #to "$outputfile" 
  
   ocrmypdf -j 1 --optimize 01 -l deu+eng "${file}" "$outputfile"  --skip-text --output-type pdf # --redo-ocr
  
   if [ -f "$outputfile" ]; then
    #cpdf -set-metadata metadata.xml in.pdf -o out.pdf
    exiftool -TagsFromFile "$file" -All:All --CreatorTool --MetadataDate -XMPToolkit= "$outputfile" -overwrite_original
    touch -d @$(stat -c "%Y" "$file") "$outputfile"
	mv -f "$outputfile" "$file"
    #rm "$file"
   fi
 fi
 
 #echo 
 #echo
 #sleep 0.05

done # end of for file in *.pdf; do


uselessfiles_1=$(find . -type f -name "Thumbs.db" -o -name "*:Zone.Identifier" -o -name "Thumbs.db:encryptable") # all uselessfiles in subfolders
uselessfiles=`echo ${uselessfiles_1// /%20}` # replace all whitespaces with %20
for file in $uselessfiles; do #https://superuser.com/a/363438/631374
#for file in Thumbs.db ./**/Thumbs.db; do
 export file="${file//%20/ }" # convert %20 to whitespace
 if [ -f "$file" ]; then
  rm "$file"
  echo "$file" deleted
 else
  echo "$file" not found
 fi
done
