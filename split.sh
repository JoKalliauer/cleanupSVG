#!/bin/bash

#Author: Johannes Kalliauer (JoKalliauer)
#created: 2018-01-28

#for file in *.svg;do
export file=5.svg
export i=$file #i will be overritan later
export fileN=$(echo $file | cut -f1 -d" ") #remove spaces if exsiting (and everything after)
export tmp=$(echo $fileN | cut -f1 -d".")
export old=${tmp}

for j in `seq 1 10`; do

#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}${j}.svg
#cp ./"${file}" $i
#mv ./"${file}" ./${tmp}0.xml
mv ./${old}.svg $i


echo 
echo $i start:

sed -i.svg -e '1,10001d' $i
sed -ri '9999i\ \n</svg>\n<!--\n<?xml version="1.0" encoding="UTF-8" standalone="no"?>\n<svg height="800" stroke="#000" width="800" xmlns="http:\/\/www.w3.org\/2000\/svg">' $i


#mv $i ${tmp}_.svg
echo $i finish

export old=${tmp}$j

done

#./cleaner4compression.sh
#./Pathmerge.sh

# sed -ri '/</svg>/d' $i
# sed -ri '/<?xml version="1.0" encoding="UTF-8" standalone="no"?>/d' $i
# sed -ri '/<svg height="800" stroke="#000" width="800" xmlns="http://www.w3.org/2000/svg">/d' $i

#export i=linesAJ.svg

# cat 1a.svg 1b.svg 1c.svg 1d.svg 1e.svg 1f.svg 1g.svg 1h.svg 1i.svg 1j.svg > $i
# cat 2aco.svg 2bco.svg 2cco.svg 2dco.svg 2eco.svg 2fco.svg 2gco.svg 2hco.svg 2ico.svg 2jco.svg > $i
# cat 1.svg 2.svg 3.svg 4.svg 5.svg 6.svg 7.svg 8.svg 9.svg 10.svg 11.svg > $i
# cat 1o.svg 2o.svg 3o.svg 4o.svg 5o.svg 6o.svg 7o.svg 8o.svg 9o.svg 10o.svg 11o.svg > $i

# sed -ri 's/>/>\n/g;s/</\n</g' $i

<svg xmlns="http://www.w3.org/2000/svg" width="800" height="800" stroke="#000">

# sed -ri 's/<svg ([[:alnum:]=\"#\/\.\:]*)>/<svg \1> -->/g;s/<\/svg>/<!--<\/svg>/g' $i




