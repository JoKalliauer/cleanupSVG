#!/bin/bash

for file in *.svg;do
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}o.svg

if [ -z ${minfilesize+x} ]; then
 minfilesize=0
fi

if [ -z ${meta+x} ]; then
  meta=1 #if not specified kept meta to not make a copyright violation
fi

echo #Add a empty line to split the output

if [ $meta == 1 ]; then
 # echo keep metadata
 export META="--disable=removeMetadata"
elif [ $meta == 0 ]; then
 export META="--enable=removeMetadata"
 echo delete META=$META
else
 echo imput not allowed meta is $meta
fi

if [ $minfilesize == 0 ]; then
 export INDENT="--pretty --indent=1" #"--pretty --indent=1" #deactivated because of https://github.com/svg/svgo/issues/878
elif [ $minfilesize == 1 ]; then
 export INDENT="--indent=0"
else
 echo some error minfilesize is $minfilesize
fi

#echo optizer ${file} to $i begin, min=${minfilesize}, meta=$meta, META= $META, INDENT=$INDENT

svgo -i ${file} -o $i $INDENT -p 3 --config svgo.RemoveRaster.js # $META --disable=removeHiddenElems --disable=removeUnknownsAndDefaults --disable=convertTransform --disable=convertPathData --disable=mergePaths --enable=removeScriptElement --disable=removeXMLProcInst --disable=convertStyleToAttrs --enable=cleanupAttrs --enable=cleanupEnableBackground --disable=cleanupIDs --disable=cleanupNumericValues --enable=convertColors --disable=convertShapeToPath --disable=inlineStyles  --disable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems  --enable=removeAttrs --disable=removeComments --enable=removeDesc --disable=removeEditorsNSData --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeNonInheritableGroupAttrs --enable=removeRasterImages --disable=removeTitle --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=sortAttrs --disable=removeDoctype --enable={addAttributesToSVGElement}  --disable=collapseGroups  --disable=removeStyleElement

## == min ==
#  --disable=removeComments #keep Comments
#  --disable=cleanupIDs

### === CSS ===
# --disable=inlineStyles # keep CSS
#  --disable=convertStyleToAttrs # CSS-Problem: https://github.com/svg/svgo/issues/1040
#  --disable=removeStyleElement # (default) keep CSS

## == Bug ==

# --disable=mergePaths # https://github.com/svg/svgo/issues/872 # https://github.com/svg/svgo/issues/958 # sometimes Chrome-displaybug

#--disable=removeUnknownsAndDefaults # removes Flowtext # https://github.com/svg/svgo/issues/959

# --disable=convertShapeToPath ##can be problematic for flowtext

#  --disable=convertStyleToAttrs #  CSS-Problem: https://github.com/svg/svgo/issues/1040

# --disable=convertTransform #https://github.com/svg/svgo/issues/986

#--disable=collapseGroups #https://github.com/svg/svgo/issues/1020

#  --disable=cleanupNumericValues #https://github.com/svg/svgo/issues/1080

#--disable=removeXMLProcInst # valid (Warning)

## ==Precission ==
# -p 3 #https://commons.wikimedia.org/wiki/File:Decoy_Receptor_Figure.svg

## ==

# do not define: --enable=prefixIds #Extends the filename to the ID
#--enable=cleanupListOfValues  https://github.com/svg/svgo/issues/923
#--enable=convertPathData # https://github.com/svg/svgo/issues/880
# --enable=removeElementsByAttr # https://github.com/svg/svgo/issues/945 (option does not make sence)
# --enable=removeDimensions ##Changes size of view
# --enable=removeXMLNS ## not valid 
# --enable=addClassesToSVGElement ## i think i dont need to add any classes
# --enable=addClassesToSVGElement #strange warning

#== structure ==
 #--disable=removeTitle
 # --disable=cleanupIDs

#=== old ===
#keep id-names --disable=cleanupIDs

#echo mv ./${file} ./${tmp}5.xml
mv ./${file} ./${tmp}5.xml

#echo svgo $i finish

done


DeactivateEverything=<<END

svgo -i min.svg -o output.svg --pretty --indent=1 -p 10 --disable=collapseGroups --disable=addAttributesToSVGElement --disable=addClassesToSVGElement --disable=cleanupAttrs --disable=cleanupEnableBackground --disable=cleanupIDs --disable=cleanupListOfValues --disable=cleanupNumericValues --disable=convertColors --disable=convertPathData --disable=convertShapeToPath --disable=convertStyleToAttrs --disable=convertTransform --disable=inlineStyles --disable=mergePaths --disable=minifyStyles --disable=moveElemsAttrsToGroup --disable=moveGroupAttrsToElems --disable=prefixIds --disable=removeAttrs --disable=removeComments --disable=removeDesc --disable=removeDimensions --disable=removeDoctype --disable=removeEditorsNSData --disable=removeElementsByAttr --disable=removeEmptyAttrs --disable=removeEmptyContainers --disable=removeEmptyText --disable=removeHiddenElems --disable=removeMetadata --disable=removeNonInheritableGroupAttrs --disable=removeRasterImages --disable=removeScriptElement --disable=removeStyleElement --disable=removeTitle --disable=removeUnknownsAndDefaults --disable=removeUnusedNS --disable=removeUselessDefs --disable=removeUselessStrokeAndFill --disable=removeViewBox --disable=removeXMLNS --disable=removeXMLProcInst --disable=sortAttrs

END


ActivateEverything=<<END

svgo -i min.svg -o output.svg --enable=cleanupAttrs --enable=cleanupEnableBackground --enable=cleanupIDs --enable=cleanupListOfValues --enable=cleanupNumericValues --enable=collapseGroups --enable=convertColors --enable=convertPathData --enable=convertShapeToPath --enable=convertStyleToAttrs --enable=convertTransform --enable=inlineStyles --enable=mergePaths --enable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems --enable=removeAttrs --enable=removeComments --enable=removeDesc --enable=removeDimensions --enable=removeDoctype --enable=removeEditorsNSData --enable=removeElementsByAttr --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeHiddenElems --enable=removeMetadata --enable=removeNonInheritableGroupAttrs --enable=removeRasterImages --enable=removeScriptElement --enable=removeStyleElement --enable=removeTitle --enable=removeUnknownsAndDefaults --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=removeXMLProcInst --enable=sortAttrs --pretty --indent=1  --disable=removeXMLNS --disable=prefixIds

END

avail=<<END

Currently available plugins:
 [ addAttributesToSVGElement ] adds attributes to an outer <svg> element
 [ addClassesToSVGElement ] adds classnames to an outer <svg> element
 [ cleanupAttrs ] cleanups attributes from newlines, trailing and repeating spaces
 [ cleanupEnableBackground ] remove or cleanup enable-background attribute when possible
 [ cleanupIDs ] removes unused IDs and minifies used
 [ cleanupListOfValues ] rounds list of values to the fixed precision
 [ cleanupNumericValues ] rounds numeric values to the fixed precision, removes default ‘px’ units
 [ collapseGroups ] collapses useless groups
 [ convertColors ] converts colors: rgb() to #rrggbb and #rrggbb to #rgb
 [ convertPathData ] optimizes path data: writes in shorter form, applies transformations
 [ convertShapeToPath ] converts basic shapes to more compact path form
 [ convertStyleToAttrs ] converts style to attributes
 [ convertTransform ] collapses multiple transformations and optimizes it
 [ inlineStyles ] inline styles (additional options)
 [ mergePaths ] merges multiple paths in one if possible
 [ minifyStyles ] minifies styles and removes unused styles based on usage data
 [ moveElemsAttrsToGroup ] moves elements attributes to the existing group wrapper
 [ moveGroupAttrsToElems ] moves some group attributes to the content elements
 [ prefixIds ] prefix IDs
 [ removeAttrs ] removes specified attributes
 [ removeComments ] removes comments
 [ removeDesc ] removes <desc>
 [ removeDimensions ] removes width and height in presence of viewBox (opposite to removeViewBox, disable it first)
 [ removeDoctype ] removes doctype declaration
 [ removeEditorsNSData ] removes editors namespaces, elements and attributes
 [ removeElementsByAttr ] removes arbitrary elements by ID or className (disabled by default)
 [ removeEmptyAttrs ] removes empty attributes
 [ removeEmptyContainers ] removes empty container elements
 [ removeEmptyText ] removes empty <text> elements
 [ removeHiddenElems ] removes hidden elements (zero sized, with absent attributes)
 [ removeMetadata ] removes <metadata>
 [ removeNonInheritableGroupAttrs ] removes non-inheritable group’s presentational attributes
 [ removeRasterImages ] removes raster images (disabled by default)
 [ removeScriptElement ] removes <script> elements (disabled by default)
 [ removeStyleElement ] removes <style> element (disabled by default)
 [ removeTitle ] removes <title>
 [ removeUnknownsAndDefaults ] removes unknown elements content and attributes, removes attrs with default values
 [ removeUnusedNS ] removes unused namespaces declaration
 [ removeUselessDefs ] removes elements in <defs> without id
 [ removeUselessStrokeAndFill ] removes useless stroke and fill attributes
 [ removeViewBox ] removes viewBox attribute when possible
 [ removeXMLNS ] removes xmlns attribute (for inline svg, disabled by default)
 [ removeXMLProcInst ] removes XML processing instructions
 [ sortAttrs ] sorts element attributes (disabled by default)


END
