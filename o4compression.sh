#!/bin/bash

for file in *.svg;do
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}o.svg

if [ -z ${minfilesize+x} ]; then
 minfilesize=0
fi

if [ -z ${meta+x} ]; then
  meta=1 #if not specified kept meta to not make a copyright violation
fi

echo #Add a empty line to split the output

if [ $meta == 1 ]; then
 echo keep metadata
 export META="--enable=removeDoctype --disable=removeMetadata"
elif [ $meta == 0 ]; then
 export META="--disable=removeDoctype --enable=removeMetadata"
 echo delete META=$META
else
 echo imput not allowed meta is $meta
fi

if [ $minfilesize == 0 ]; then
 export INDENT="" #"--pretty --indent=1" #deactivated because of https://github.com/svg/svgo/issues/878
elif [ $minfilesize == 1 ]; then
 export INDENT="--indent=0"
else
 echo some error minfilesize is $minfilesize
fi

echo optizer ${file} to $i begin, min=${minfilesize}, meta=$meta, META= $META, INDENT=$INDENT

svgo -i ${file} -o $i -p 3 $META --enable=removeScriptElement --disable=removeXMLProcInst --disable=removeUnknownsAndDefaults --disable=mergePaths $INDENT --disable=convertPathData --disable=convertStyleToAttrs --enable=cleanupAttrs --enable=cleanupEnableBackground --enable=cleanupIDs --enable=cleanupNumericValues --enable=collapseGroups --enable=convertColors --enable=convertShapeToPath --enable=convertTransform --enable=inlineStyles  --enable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems  --enable=removeAttrs --enable=removeComments --enable=removeDesc --enable=removeEditorsNSData --enable=removeElementsByAttr --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeHiddenElems --enable=removeNonInheritableGroupAttrs --disable=removeRasterImages  --enable=removeStyleElement --enable=removeTitle --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=sortAttrs # --enable=cleanupListOfValues

# --disable=mergePaths # https://github.com/svg/svgo/issues/872

#--disable=removeXMLProcInst # valid (Warning)

#--disable=removeUnknownsAndDefaults # removes Flowtext

# -p 3 #https://commons.wikimedia.org/wiki/File:Decoy_Receptor_Figure.svg

# --enable=removeDimensions
##Changes size of view

#  --disable=convertStyleToAttrs #https://commons.wikimedia.org/wiki/File:2016_Angola_and_DR_Congo_yellow_fever_outbreak.svg

# do not define: --enable=prefixIds #Standard_time_zones_of_the_world

#--enable=cleanupListOfValues  https://github.com/svg/svgo/issues/923

#--enable=convertPathData # https://github.com/svg/svgo/issues/880

#echo mv ./${file} ./${tmp}5.xml
mv ./${file} ./${tmp}5.xml

#echo svgo $i finish

done

DeactivateEverything=<<END

svgo -i min.svg -o output.svg --pretty --indent=1 --disable=addAttributesToSVGElement --disable=addClassesToSVGElement --disable=cleanupAttrs --disable=cleanupEnableBackground --disable=cleanupIDs --disable=cleanupListOfValues --disable=cleanupNumericValues --disable=collapseGroups --disable=convertColors --disable=convertPathData --disable=convertShapeToPath --disable=convertStyleToAttrs --disable=convertTransform --disable=inlineStyles --disable=mergePaths --disable=minifyStyles --disable=moveElemsAttrsToGroup --disable=moveGroupAttrsToElems --disable=prefixIds --disable=removeAttrs --disable=removeComments --disable=removeDesc --disable=removeDimensions --disable=removeDoctype --disable=removeEditorsNSData --disable=removeElementsByAttr --disable=removeEmptyAttrs --disable=removeEmptyContainers --disable=removeEmptyText --disable=removeHiddenElems --disable=removeMetadata --disable=removeNonInheritableGroupAttrs --disable=removeRasterImages --disable=removeScriptElement --disable=removeStyleElement --disable=removeTitle --disable=removeUnknownsAndDefaults --disable=removeUnusedNS --disable=removeUselessDefs --disable=removeUselessStrokeAndFill --disable=removeViewBox --disable=removeXMLNS --disable=removeXMLProcInst --disable=sortAttrs

END


ActivateEverything=<<END

svgo -i min.svg -o output.svg --enable=cleanupAttrs --enable=cleanupEnableBackground --enable=cleanupIDs --enable=cleanupListOfValues --enable=cleanupNumericValues --enable=collapseGroups --enable=convertColors --enable=convertPathData --enable=convertShapeToPath --enable=convertStyleToAttrs --enable=convertTransform --enable=inlineStyles --enable=mergePaths --enable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems --enable=removeAttrs --enable=removeComments --enable=removeDesc --enable=removeDimensions --enable=removeDoctype --enable=removeEditorsNSData --enable=removeElementsByAttr --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeHiddenElems --enable=removeMetadata --enable=removeNonInheritableGroupAttrs --enable=removeRasterImages --enable=removeScriptElement --enable=removeStyleElement --enable=removeTitle --enable=removeUnknownsAndDefaults --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=removeXMLProcInst --enable=sortAttrs --pretty --indent=1  --disable=removeXMLNS --disable=prefixIds

END