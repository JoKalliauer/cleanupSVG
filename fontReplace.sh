#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2017-10

#Last Edits:
#2017-10-29 13h14 new filename (by JoKalliauer)
#2017-11-01 delte style in text, Doctype minior changes, Remove stroke-width in text, not adding lineforwards, english explantations (by JoKalliauer)
#2017-11-20 dasharray due to stroke-dasharray="37.10, 37.10"
#2017-11-22 xml:space="preserve" in simple text removed
#2017-11-22 remove empty text;
#2017-11-22 Remove style in text with .
#2017-11-22 Remove stroke-width in text with .
#2017-11-27 remove style in text also if "[-\#\(\)]" is before
#2017-11-27 remove fill in text if x="..." y="..." is before
#2017-11-27 Remove stroke-width in text edited
#2017-11-27 Remove stroke-width in tspan
#2018-04-07 10h17 put no-filebreakc after definiton of $new, deleted the removement of spaces
#2018-04-28 not remove stroke-width in text
#2018-05-05 restructured

for file in *.svg;do

echo 
#echo $file

## == Remove scecial characters in filename ==

#export i=$file #i will be overritan later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}0.svg
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo $i start:

## ==Change Fonts to WikiFonts ==

#Change to Wikis Fallbackfont https://commons.wikimedia.org/wiki/Help:SVG#fallback to be compatible with https://meta.wikimedia.org/wiki/SVG_fonts
sed -ri 's/ font-family=\"(s|S)ans\"/ font-family=\"DejaVu Sans,sans-serif,Sans\"/g' $i #as automatic
sed -ri 's/ font-family=\"(s|S)erif\"/ font-family=\"DejaVu Serif,serif\"/g' $i #as automatic
sed -ri 's/ font-family=\"(s|S)ans-(s|S)erif\"/ font-family=\"DejaVu Sans,sans-serif\"/g' $i #as automatic

sed -ri 's/ font-family="([-[:alnum:] ]*)MT"/ font-family="\1"/g' $i # I dont know what MT stands for

sed -ri 's/ font-family="([-[:alnum:] ]*)Oblique"/ font-family="\1" font-style=\"oblique\"/g' $i
sed -ri 's/ font-family="([-[:alnum:] ]*)Italic"/ font-family="\1" font-style=\"italic\"/g' $i
sed -ri 's/ font-family="([[:alnum:] ]*)( |-)Bold"/ font-family="\1" font-weight=\"bold\"/g' $i
sed -ri 's/ font-family="([[:alnum:] ]*)( |-)"/ font-family="\1"/g' $i
sed -i "s/ font-family=\"DejaVu Sans Condensed\"/ font-family=\"DejaVu Sans\" font-stretch=\"condensed\"/g" $i

#Sans
sed -ri 's/ font-family=\"(Arial|MyriadPro|Myriad Pro)/ font-family=\"Liberation Sans,\1/g' $i #as automatic
sed -ri 's/ font-family=\"DejaVuSans\"/ font-family=\"DejaVu Sans\"/g' $i #as automatic
sed -i 's/ font-family=\"Helvetica\"/ font-family=\"Nimbus Sans L,Liberation Sans,Helvetica\"/g' $i #looks similar https://commons.wikimedia.org/wiki/File_talk:Meta_SVG_fonts.svg #https://meta.wikimedia.org/wiki/File:SVG_Text_Font_Test.svg
sed -i "s/ font-family=\"Arial Narrow\"/ font-family=\"Liberation Sans Narrow,Arial Narrow\"/g" $i
sed -ri 's/ font-family=\"(Bitstream Vera Sans|Dialog)\"/ font-family=\"DejaVu Sans,\1\"/g' $i #unknown fonts to DejaVu Sans

sed -ri "s/ font-family=\"GOST type B\"/ font-family=\"Bandal,GOST type B,DejaVu Sans,Bitstream Vera Sans\"/g" $i

#Serif
sed -i 's/ font-family=\"Bitstream Vera Serif\"/ font-family=\"DejaVu Serif,Bitstream Vera Serif\"/g' $i #as automatic
sed -ri 's/ font-family=\"(Times New Roman|Times-Roman|CMMI10|CMR10|LnrxdlTimes|JnsptfTimes|PkbwthTimes|Times|CghgsrSymbol|TimesNewRomanPS|TimesNewRomanPSMT)\"/ font-family=\"Liberation Serif,\1\"/g' $i #as automatic

#monospace
sed -ri 's/ font-family=\"(monospace|Bitstream Vera Sans Mono)\"/ font-family=\"DejaVu Sans Mono,Bitstream Vera Sans Mono,monospace\"/g' $i #as automatic
sed -i 's/ font-family=\"Courier New\"/ font-family=\"Liberation Mono,Courier New,Courier,monospace\"/g' $i #as automatic

#simpifying text
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<text([[:lower:][:digit:]= #,-\,\"\-\.\(\)]*)>[[:space:]]*<tspan/<text\1><tspan/g" $i #remove spaces and linebreaks between text and tspan
sed -ri -e ':a' -e 'N' -e '$!ba' -e "s/<\/tspan>[[:space:]]*<\/text>/<\/tspan><\/text>/g" $i #remove spaces and linebreaks between text and tspan
sed -ri "s/<text ([-[:lower:][:digit:].,\"= ]+) xml:space=\"preserve\">([-[:alnum:]\\\$\']+)<\/text>/<text \1>\2<\/text>/g" $i #remove xml:space="preserve" in text if unnecesarry
sed -ri 's/<text [-[:lower:][:digit:]= \"\:\.]+\/>//g' $i #remove empty text
sed -ri 's/<tspan [-[:lower:][:digit:]= \"\.\:\;]+\/>//g' $i #remove selfclosing tspan
sed -i "s/<tspan x=\"0\" y=\"0\">/<tspan>/g" $i #reduce options in tspan
sed -ri "s/<tspan>([]\[[:alnum:]\$\^\\\_\{\}= #\,\"\.\(\)\’\&\;\/Επιβάτες¸−-]*)<\/tspan>([ ]*)/\1/g" $i #remove unnecesarry <tspan>...</tspan> without attributes
sed -ri "s/<tspan[-[:lower:][:digit:]= \"\.]+> <\/tspan>([ ]*)//g" $i #remove useless <tspan (...)> </tspan> without text


## == Workarounds for Librsvg ==

#Change "'font name'" to 'font name'(solves librsvg-Bug) https://commons.wikimedia.org/wiki/File:T184369.svg
# font-family="Liberation Serif,'Times New Roman'"
sed -ri "s/font-family=\"([-[:alnum:] ,']*)'([-[:alnum:] ]*)'([-[:lower:][:upper:], ']*)\"/font-family=\"\1\2\3\"/g" $i


echo $i finish



done

##as automatic

#Arial           -> Liberation Sans,Arial,Nimbus Sans L,Helvetica,sans-serif
#Times New Roman -> Liberation Serif,Times New Roman,Times,Times-Roman,serif
#Helvetica       -> Nimbus Sans L,Ubuntu,Liberation Sans,Helvetica,Arial,sans-serif
#Courier New     -> Liberation Mono,Courier New,Courier,monospace
#Calibri         -> Liberation Sans,Carlito,Calibri,Segoe UI,Myriad,UnDotum,Optima,Tahoma,Arial,sans-serif
#Verdana         -> Liberation Sans,Verdana,Geneva,Montserrat,quatro-1,quatro-2,Arial Black,Droid Sans,sans-serif

#'Segoe UI', Myriad, Calibri, UnDotum, Optima, Tahoma, sans-serif #https://github.com/ether/etherpad-lite/issues/2713



#sed -i 's/ font-family=\"Albany embedded\"/ font-family=\"Loma\"/g' $i #as automatic
#sed -i 's/ fill=\"#002060\" font-family=\"Swis721 BlkCn BT\" font-size=\"/ fill=\"#002060\" font-family=\"Liberation Sans\" font-weight=\"bold\" font-size=\"/g' $i #looks similar https://www.dafontfree.net/freefonts-swis721-blkcn-bt-f61164.htm
#sed -i "s/ font-family=\"Blue Highway Condensed\"/ font-family=\"Padauk\" font-stretch=\"condensed\"/g" $i
#sed -i 's/ font-family=\"Nimbus Sans L\"/ font-family=\"Liberation Sans\"/g' $i 
#sed -ri 's/ font-family=\"(Arial|Myriad Pro|ArialNarrow|ArialMT)\"/ font-family=\"Liberation Sans\"/g' $i #all Sans to Liberation
#sed -ri 's/ font-family=\"(Minion Pro|Times|Times New Roman|SVGTimes)\"/ font-family=\"Liberation Serif\"/g' $i #all Serif to Liberation
#sed -ri 's/ font-family=\"(Benguiat|BenguiatStd-Book|Benguiat-Book)\"/ font-family=\"Tibetan Machine Uni,Garuda,Liberation Sans,Liberation Serif\"/g' $i #looks similar # http://www.fontpalace.com/font-details/Benguiat+Bold/
#sed -ri 's/ font-family=\"(Sanvito|Sanvito-Roman|SanvitoPro-Regular)\"/ font-family=\"Purisa,Garuda,Liberation Sans,Liberation Serif\"/g' $i #looks similar # https://www.myfonts.com/fonts/adobe/sanvito/
#sed -ri 's/ font-family=\"(Tiepolo|TiepoloStd-Book|Tiepolo-Black|Tiepolo-Book)\"/ font-family=\"Norasi,Garuda,Liberation Sans,Liberation Serif\"/g' $i #looks similar # https://www.myfonts.com/fonts/itc/tiepolo/
#sed -i "s/ font-family=\"Myriad-Roman\"/ font-family=\"UnBom,Liberation Sans\"/g" $i #looks similar https://de.wikipedia.org/wiki/Myriad_(Schriftart)
#sed -ri "s/ font-family=\"Blue( |)Highway\"/ font-family=\"Padauk\"/g" $i #looks similar https://www.dafont.com/de/blue-highway.font
#sed -ri "s/ font-family=\"(Blue Highway D Type|BlueHighwayDType)\"/ font-family=\"Padauk\" text-transform=\"uppercase\"/g" $i
#sed -ri 's/ font-family=\"DejaVu Sans Bold\"/ font-family=\"DejaVu Sans\" font-weight=\"bold\"/g' $i
#sed -ri "s/ font-family=\"GOST type B\"/ font-family=\"Bandal,GOST type B\"/g" $i
