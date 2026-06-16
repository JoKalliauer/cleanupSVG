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
export file=$1
#for file in *.pdf ./**/*.pdf ./**/**/*.pdf ./**/**/**/*.pdf ./**/**/**/**/*.pdf ./**/**/**/**/**/*.pdf ./**/**/**/**/**/**/*.pdf  #https://stackoverflow.com/a/15088473/6747994
 #echo "$file"
 export file="${file//%20/ }" # convert %20 to whitespace
 export tmp=${file%.pdf} #remove .pdf at the end 
 export outputfile="./${tmp}_decrypt.pdf"
 
 if [[ "$file" == *_ocrmypdf.pdf || "$file" == *_pdfA.pdf ]]; then
  echo skipping $file
  #echo
 elif [ -f "$file" ]; then
 #elif [ -f "$file" ] && ! grep -q ocrmypdf "$file"; then
  chmod u+r "${file}"
  echo converting "${file}" #ocrmypdf --optimize 01 -l deu+eng "${file}" #to "$outputfile" 
   
   qpdf --decrypt "${file}" "$outputfile"
   # gs -o tmp_repaired.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sColorConversionStrategy=UseDeviceIndependentColor -dPDFA=1 -dPDFACompatibilityPolicy=0 tmp_decrypted.pdf /home/jkalliau/prgm/ghostscript-10.03.1/lib/PDFA_def.ps #https://ghostscript.readthedocs.io/en/gs10.0.0/VectorDevices.html#creating-a-pdf-a-document
   #ocrmypdf -j 1 --optimize 01 -l deu+eng tmp_decrypted.pdf "$outputfile"  --skip-text #--redo-ocr #https://www.heise.de/ratgeber/Durchsuchbare-PDF-Dokumente-mit-OCRmyPDF-erstellen-4607592.html?seite=2
   # rm tmp_repaired.pdf tmp_decrypted.pdf
  
   if [ -f "$outputfile" ]; then
    echo exift,tou,mov
    #cpdf -set-metadata metadata.xml in.pdf -o out.pdf
    exiftool -TagsFromFile "$file" -All:All --CreatorTool --MetadataDate -XMPToolkit= "$outputfile" -overwrite_original
    touch -d @$(stat -c "%Y" "$file") "$outputfile"
	mv -f "$outputfile" "$file"
    #rm "$file"
   else
	gs -o "$outputfile" -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress "${file}"
   fi
 fi
 
