#!/bin/bash

for file in *.svg;do
#export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}s.svg

if [ -z ${minfilesize+x} ]; then
 minfilesize=0
fi

if [ -z ${meta+x} ]; then
  meta=1 #if not specified kept meta to not make a copyright violation
fi

echo #Add a empty line to split the output

 export META= 


if [ $minfilesize == 0 ]; then
 export INDENTs=" --indent=space --nindent=1"
 export INDENTo="--pretty --indent=1" #"--pretty --indent=1" #deactivated because of https://github.com/svg/svgo/issues/878
elif [ $minfilesize == 1 ]; then
 export INDENTs="--indent=none --no-line-breaks"
 export INDENTo="--indent=0"
else
 echo some error minfilesize is $minfilesize
fi

echo scour ${file} to $i begin, min=${minfilesize}, meta=$meta, META= $META, INDENT=$INDENTs

./viewBoxS.sh

mv ./${file} ./${tmp}3.xml

echo scour $i finish

export file=$i
export fileN=$(echo $i | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}o.svg

echo #Add a empty line to split the output

if [ $meta == 1 ]; then
 echo keep metadata
 export META="--disable=removeMetadata"
elif [ $meta == 0 ]; then
 export META="--enable=removeMetadata"
 echo delete META=$META
else
 echo imput not allowed meta is $meta
fi

./viewBoxO.sh


mv ./${file} ./${tmp}5.xml


done

