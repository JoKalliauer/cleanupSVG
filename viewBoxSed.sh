#!/bin/bash

#Input (obligatory)
#1...SVG-File(Input=Output)
#2...x-start
#3...y-start
#4...width
#5...height

#Input (optional)
#6...scale preview

if [ -z ${6+x} ]; then
 input6=0
else 
 input6=$6
 www=`echo "$4 * $6" | bc -l` #https://stackoverflow.com/a/20233797/6747994
 hhh=`echo "$5 * $6" | bc -l`
fi

if [ $HOSTNAME = LAPTOP-K1FUMMIP ]; then
 PC=local
elif [ $HOSTNAME = jkalliau-Z87M-D3H ]; then
 PC=local
elif [ $HOSTNAME = tools-sgebastion-07 ]; then
 PC=WikiMedia
fi
 
#solved librsvg-Bug T194192 https://phabricator.wikimedia.org/T194192
sed -ri "s/<svg([-[:alnum:]=\"\.\/: ]*) viewBox=\"0,0,([[:digit:]\.]*),([[:digit:]\.]*)\"/<svg viewBox=\"0 0 \2 \3\"\1/g" $1

#remove ampersents in xmlns (they confuse inkscape anyway in xmlns)
sed -ri "s/ xmlns:x=\"([amp38;\#\&\])+ns_extend;\"/ xmlns:x=\"http:\/\/ns.adobe.com\/Extensibility\/1.0\/\"/" $1 #Inkscape doesnt handle Adobe Ilustrator xmlns right (or maybe xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml")
sed -ri "s/=\"([amp38;\#\&\])+ns_ai;\"/=\"http:\/\/ns.adobe.com\/AdobeIllustrator\/10.0\/\"/" $1 #Inkscape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns:graph=\"([amp38;\#\&\])+ns_graphs;\"/ xmlns:graph=\"http:\/\/ns.adobe.com\/Graphs\/1.0\/\"/" $1 #Inkscape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_svg;\"/ xmlns=\"http:\/\/www.w3.org\/2000\/svg\"/" $1
sed -ri "s/ xmlns:xlink=\"([amp38;\#\&\])+ns_xlink;\"/ xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\"/" $1

#remove linebreaks
sed -ri 's/\r/ /g' $1 #remove carriage return in the whole file
for i in {1..14}; do
 sed -ri 's/<svg([-[:alnum:]é=\" \.\/\\:;\,\(\)_#]*)[[:space:]	]+/<svg\1 /g' $1 # convert all spaces in svg-tag to a singe normal space
 sed -ri ':a;N;$!ba;s/<svg([-[:alnum:]é=\" 	\.\/\\:;\,\(\)_#]*)\n[[:space:]]*/<svg\1 /g' $1 # replace newlines with single normal spaces
done


#put viewBox, width, height at the beginning
sed -ri "s/<svg([-[:alnum:]é=\"\' 	\.\/\\:;\,\(\)_#]+) height=\"([[:digit:].]+)(px|mm|pt|pc|cm|in|)*\"/<svg height=\"\2\"\1/" $1
sed -ri "s/<svg([-[:alnum:]é=\"\' 	\.\/\\:;\,\(\)_#]+) width=\"([[:digit:].]+)(px|mm|pt|pc|cm|in|)*\"/<svg width=\"\2\"\1/" $1
sed -ri "s/<svg([-[:alnum:]é=\"\' 	\.\/\\:;\,\(\)_#]+) viewBox=\"([-[:digit:] \.]+)\"/<svg viewBox=\"\2\"\1/" $1

#if viewBox exist remove width="[[:digit:].]+(px|mm|pt|pc|cm|in)*" height="[[digit].]+(px|mm|pt|pc|cm|in)*"
sed -ri "s/<svg([-[:alnum:]é=\"\' 	\.\/\\:;\,\(\)_#]*) viewBox=\"([-[:digit:] \.]+)\"([-[:alnum:]é=\"\' \.\/\\:;\,\(\)_#]*) width=\"[[:digit:].]+(px|mm|pt|pc|cm|in)*\"/<svg viewBox=\"\2\"\1\3/" $1
sed -ri "s/<svg([-[:alnum:]é=\"\' 	\.\/\\:;\,\(\)_#]*) viewBox=\"([-[:digit:] \.]+)\"([-[:alnum:]é=\"\' \.\/\\:;\,\(\)_#]*) height=\"[[:digit:].]+(px|mm|pt|pc|cm|in)*\"/<svg viewBox=\"\2\"\1\3/" $1

#if no viewBox exists convert  width="[[:digit:].]+" height="[[:digit:].]+" to viewBox:
sed -ri "s/<svg([-[:alnum:]=\"\' 	\.\/:;\,#]*) width=\"([[:digit:].]+)\" height=\"([[:digit:].]+)\"([-[:alnum:]é=\"\' \.\/\\:\,#\(\)_;]+)>/<svg viewBox=\"0 0 \2 \3\"\1\4>/" $1

if [ $input6 = 0 ]; then
 #Replace the old four numbers with the new four numbers
 sed -ri "s/<svg([-[:alnum:]=\"\' 	\.\/:;\,#]*) viewBox=\"[-[:digit:]\.]+ [-[:digit:]\.]+ [[:digit:]\.]+ [[:digit:]\.]+\"([-[:alnum:]é=\"\' \.\/\\:\,#\(\)_;]+)>/<svg viewBox=\"$2 $3 $4 $5\"\1\2>/" $1
else
 #Replace the old four numbers with the new six numbers
 sed -ri "s/<svg([-[:alnum:]=\"\' 	\.\/:;\,#]*) viewBox=\"[-[:digit:]\.]+ [-[:digit:]\.]+ [[:digit:]\.]+ [[:digit:]\.]+\"([-[:alnum:]é=\"\' \.\/\\:\,#\(\)_;]+)>/<svg viewBox=\"$2 $3 $4 $5\" width=\"$www\" height=\"$hhh\"\1\2>/" $1
fi
 

