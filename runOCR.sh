#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2023-07-08

#Last Edits:
#2023-07-08 JK: created file

#if [ -f "/etc/debian_version" ]; then
# apt list python3 ghostscript pngquant ocrmypdf libxml2 python3-pip ghostscript qpdf libxml2 tesseract-ocr tesseract-ocr-deu tesseract-ocr-eng pngquant unpaper librsvg2-bin poppler-utils autoconf automake ghostscript-x ocrmypdf-doc img2pdf libtool libleptonica-dev
#fi
#if [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
# dnf list python3 tesseract ghostscript pngquant ocrmypdf tesseract-osd libxml2 python3 python3-pip ghostscript qpdf libxml2 tesseract-ocr tesseract-ocr-deu jbig2enc pngquant unpaper
#fi

#pip install --upgrade ocrmypdf
#pip install --upgrade pikepdf


# loop over all pdf-files
for file in *.pdf; do
chmod u+r "${file}"
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
export tmp=${new%.pdf}
export outputfile=${tmp}_ocrmypdf.pdf

echo converting ocrmypdf --optimize 01 -l deu+eng "${file}" $outputfile # --skip-text

#if outputfile exist, it might be overwritten without warning
ocrmypdf --optimize 01 -l deu+eng "${file}" $outputfile # --skip-text #https://www.heise.de/ratgeber/Durchsuchbare-PDF-Dokumente-mit-OCRmyPDF-erstellen-4607592.html?seite=2
#--optimize : 00... no optimization; 01 ... lossless optimization; 02...hardly visible optimization; 03...lossy file size reduction
#-l deu+eng : deu... German ; eng... Englisch

if [ -f "$outputfile" ]; then
 touch -d @$(stat -c "%Y" "$file") "$outputfile"
fi

done # end of for file in *.pdf; do
