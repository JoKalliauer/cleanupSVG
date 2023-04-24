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

chmod u+r *
chmod u+rx *.sh

for file in *.svg;do
chmod u+r "${file}" #for running in cygwin
mv "$file" `echo ${file} | tr ' ' '_'` ;

## == Remove scecial characters in filename ==

export i=$file #i will be overritan later, just for debugging
export new="${file//[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\.\_\+]/}"
if [ $new == '*.svg' ]; then #new has to be controlled because it might have "-" which confuses bash
 echo "no file, (or filename does not contain any default latin character (a-z) )"
 break
fi
export tmp=${new%.svg}

#If you want to overwrite the exisiting file, without any backup, delete the following three lines
export i=${tmp}p.svg
chmod u+r ./"${file}"
cp ./"${file}" $i
mv ./"${file}" ./${tmp}1.xml

echo
echo $i start:


#Inkscape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_flows;\"/=\"http:\/\/ns.adobe.com\/Flows\/1.0\/\"/g" $i
sed -ri "s/ xmlns:x=\"([amp38;\#\&\])+ns_extend;\"/ xmlns:x=\"http:\/\/ns.adobe.com\/Extensibility\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right (or maybe xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml")
sed -ri "s/=\"([amp38;\#\&\])+ns_ai;\"/=\"http:\/\/ns.adobe.com\/AdobeIllustrator\/10.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns:graph=\"([amp38;\#\&\])+ns_graphs;\"/ xmlns:graph=\"http:\/\/ns.adobe.com\/Graphs\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_vars;\"/=\"http:\/\/ns.adobe.com\/Variables\/1.0\/\"/g" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/=\"([amp38;\#\&\])+ns_imrep;\"/=\"http:\/\/ns.adobe.com\/ImageReplacement\/1.0\/\"/g" $i #	<!ENTITY ns_imrep "http://ns.adobe.com/ImageReplacement/1.0/">
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_sfw;\"/ xmlns=\"http:\/\/ns.adobe.com\/SaveForWeb\/1.0\/\"/" $i #Incskape doesnt handle Adobe Ilustrator xmlns right
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_custom;\"/ xmlns=\"http:\/\/ns.adobe.com\/GenericCustomNamespace\/1.0\/\"/" $i
#	<!ENTITY ns_adobe_xpath "http://ns.adobe.com/XPath/1.0/">
sed -ri "s/ xmlns=\"([amp38;\#\&\])+ns_svg;\"/ xmlns=\"http:\/\/www.w3.org\/2000\/svg\"/" $i
sed -ri "s/ xmlns:xlink=\"([amp38;\#\&\])+ns_xlink;\"/ xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\"/" $i
#https://www.w3.org/TR/2000/WD-CCPP-vocab-20000721/
#  <!ENTITY ns-rdf  'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
#  <!ENTITY ns-rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
#  <!ENTITY ns-ccpp 'http://www.w3.org/2000/07/04-ccpp#'>
#  <!ENTITY ns-ccpp-proxy 'http://www.w3.org/2000/07/04-ccpp-proxy#'>
#  <!ENTITY ns-ccpp-client 'http://www.w3.org/2000/07/04-ccpp-client#'>
#  <!ENTITY ns-uaprof 'http://www.wapforum.org/UAPROF/ccppschema-19991014#'>

sed -i "s/<?xpacket begin='﻿' id='/<?xpacket begin='ZeichenEingefuegtVonKalliauer' id='/g" $i


## == Workaround for inkscape bug ==
 sed -ri "s/inkscape:version=\"0.(4[\. r[:digit:]]+|91 r13725)\"//g" $i # https://bugs.launchpad.net/inkscape/+bug/1763190

## == unsave uploads
#https://commons.wikimedia.org/wiki/Commons:Help_desk#Found_unsafe_CSS_in_the_style_element_of_uploaded_SVG_file
sed -i "s/src: url(\"data:font\/woff;charset=utf-8;base64,data:application\/x-font-ttf;base64,AAEAAAAQAQAABAAAR[[:alnum:]+\/]*\");//" $i

echo $i finish



done

