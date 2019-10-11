#!/bin/bash

for file in *.svg;do

## == Remove scecial characters in filename ==

export i=$file #i will be overritan later, just for debugging
#export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
#if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
# echo "no file, (or filename does not contain any default latin character (a-z) )"
# break
#fi
#export tmp=${new%.svg}
#
##If you want to overwrite the exisiting file, without any backup, delete the following three lines
#export i=${tmp}_.svg
#cp ./"${file}" $i
#mv ./"${file}" ./${tmp}1.xml

echo 
echo $i start:

  #sed -ri 's/<svg ([[:alnum:]=\" \.\/:-]+) viewBox="0 0 ([[:digit:]]+).([[:digit:]])([[:digit:]]*) ([[:digit:]]+).([[:digit:]])([[:digit:]]*)"([[:alnum:]=\" \.\/:-]+)>/<svg \1 viewBox="0 0 \2\3.\40 \5\6.\70"\8><g transform="scale(10)">/' $i

  sed -ri 's/<svg ([[:alnum:]=\" \.\/:-]+) viewBox="0 0 ([[:digit:]]+).([[:digit:]])([[:digit:]]*) ([[:digit:]]+)\.([[:digit:]])([[:digit:]]*)"([[:alnum:]=\" \.\/:-]+)>/<svg \1 viewBox="0 0 \2\3.\40 \5\6.\70"\8>/' $i
  sed -ri 's/<svg ([[:alnum:]=\" \.\/:-]+) viewBox="0 0 ([[:digit:]]+).([[:digit:]])([[:digit:]]*) ([[:digit:]]+)"([[:alnum:]=\" \.\/:-]+)>/<svg \1 viewBox="0 0 \2\3.\40 \50"\6>/' $i
  sed -ri 's/<svg ([[:alnum:]=\" \.\/:-]+)>/<svg \1><g transform="scale(10)">/' $i

   
   sed -ri 's/<\/svg>/<\/g><\/svg>/' $i

 sed -ri "s/<text([-—[:alnum:]=\.\" \#\(\)\;\:\%\'\/\,\*]*)>/<text font-size=\"1\" \1>/g" $i
 sed -ri "s/<tspan([-[:alnum:]=\.\" \#\(\)\;\:\%\,]*)>/<tspan font-size=\"1\" \1>/g" $i
 
 sed -ri "s/ unicode-bidi=\"embed\"//g" $i

echo $i finish



done
