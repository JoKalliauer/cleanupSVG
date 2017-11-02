#!/bin/bash

for file in *.svg;do
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}s.svg

if [ -z ${precisiondigits+x} ]; then
 precisiondigits=5
else
 if [ $precisiondigits -le 0 ]; then
  precisiondigitsN=1
 else
  precisiondigitsN=$precisiondigits
 fi
 #echo precisiondigitsN is $precisiondigitsN
fi

if [ -z ${minfilesize+x} ]; then
 minfilesize=0
fi 

echo 
echo scour ${file} to $i begin, dig=${precisiondigits}, min=${minfilesize}, meta=${meta}

if [ $minfilesize == 0 ]; then
 scour -i ${file} -o $i --enable-viewboxing --enable-id-stripping --enable-comment-stripping --shorten-ids --remove-titles --remove-descriptions --disable-embed-rasters --strip-xml-space  --set-precision=${precisiondigitsN} --set-c-precision=${precisiondigits} --remove-metadata --remove-descriptive-elements --create-groups
 if [ -z ${meta+x} ]; then
  echo Metadata keept
 else
  echo $meta
  if [ $meta == 0 ]; then  
   echo delete Metadata
   scour -i ${i} -o ${i}.svg --enable-viewboxing --enable-id-stripping --enable-comment-stripping --shorten-ids --remove-titles --remove-descriptions --remove-metadata --remove-descriptive-elements --disable-embed-rasters --strip-xml-space --set-precision=1 --set-c-precision=0 --create-groups --set-precision=${precisiondigitsN} --set-c-precision=${precisiondigits}
   mv -f ./${i}.svg ./${i}
  fi
 fi
elif [ $minfilesize == 1 ] && [ $meta == 0 ]; then
  scour -i ${file} -o $i --enable-viewboxing --enable-id-stripping --enable-comment-stripping --shorten-ids --remove-titles --remove-descriptions --disable-embed-rasters --strip-xml-space  --set-precision=${precisiondigitsN} --set-c-precision=${precisiondigits} --remove-metadata --remove-descriptive-elements --create-groups --indent=none --no-line-breaks
else
 echo nothing done, please change input variables,current: dig=${precisiondigits}, min=${minfilesize}, meta=${meta}
fi

echo mv ./${file} ./${tmp}bak3.xml
mv ./${file} ./${tmp}bak3.xml

echo scour $i finish

done

