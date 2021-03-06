#!/bin/bash

for file in *.svg;do
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=$(echo $fileN | cut -f1 -d".")
export i=${tmp}O.svg

echo optizer ${file} to $i begin

svgo -i ${file} -o $i -p 4 --pretty --indent=1 --disable=inlineStyles --disable=convertStyleToAttrs --disable=removeStyleElement  --enable=convertTransform --enable=convertPathData --enable=mergePaths --enable=cleanupAttrs --enable=cleanupEnableBackground --enable=cleanupIDs --enable=cleanupListOfValues --enable=cleanupNumericValues --enable=collapseGroups --enable=convertColors --enable=convertShapeToPath --enable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems  --enable=removeAttrs --enable=removeComments --enable=removeDesc --enable=removeDoctype --enable=removeEditorsNSData --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeHiddenElems --enable=removeMetadata --enable=removeNonInheritableGroupAttrs --enable=removeScriptElement --enable=removeTitle --enable=removeUnknownsAndDefaults --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --disable=removeXMLProcInst --enable=sortAttrs --disable=removeXMLNS    --enable={addAttributesToSVGElement} --enable=removeRasterImages  --multipass ## --enable=removeElementsByAttr




## == min ==
#  --disable=removeComments #keep Comments

### === CSS ===
# --disable=inlineStyles # keep CSS
#  --disable=convertStyleToAttrs # CSS-Problem: https://github.com/svg/svgo/issues/1040
#  --disable=removeStyleElement # (default) keep CSS

## == Bugs ==

# --enable=removeElementsByAttr  # https://github.com/svg/svgo/issues/945 (option does not make sence)

# --disable=mergePaths # https://github.com/svg/svgo/issues/872

#--disable=removeXMLProcInst # valid (Warning)

#--disable=removeUnknownsAndDefaults # removes Flowtext

#  --disable=convertStyleToAttrs #https://commons.wikimedia.org/wiki/File:2016_Angola_and_DR_Congo_yellow_fever_outbreak.svg

# --enable=prefixIds leads to mistakes

## == keep id-names == # --disable=cleanupIDs

## == not define ==
# do not define: --enable=prefixIds #Extends the filename to the ID
#--enable=cleanupListOfValues  https://github.com/svg/svgo/issues/923
#--enable=convertPathData # https://github.com/svg/svgo/issues/880 and https://github.com/svg/svgo/issues/1053
# --enable=removeElementsByAttr # https://github.com/svg/svgo/issues/945 (option does not make sence)
# --enable=removeStyleElement # https://github.com/svg/svgo/issues/946
# --enable=removeDimensions ##Changes size of view
# --enable=removeXMLNS ## not valid 
# --enable=addClassesToSVGElement ## i think i dont need to add any classes
#--disable=removeUnknownsAndDefaults # removes Flowtext # https://github.com/svg/svgo/issues/959 (closed)

#echo mv ./${file} ./${tmp}5.xml
mv ./${file} ./${tmp}5.xml

#echo svgo $i finish

done

DeactivateEverything=<<END

svgo -i min.svg -o output.svg --disable=addAttributesToSVGElement --disable=addClassesToSVGElement --disable=cleanupAttrs --disable=cleanupEnableBackground --disable=cleanupIDs --disable=cleanupListOfValues --disable=cleanupNumericValues --disable=collapseGroups --disable=convertColors --disable=convertPathData --disable=convertShapeToPath --disable=convertStyleToAttrs --disable=convertTransform --disable=inlineStyles --disable=mergePaths --disable=minifyStyles --disable=moveElemsAttrsToGroup --disable=moveGroupAttrsToElems --disable=prefixIds --disable=removeAttrs --disable=removeComments --disable=removeDesc --disable=removeDimensions --disable=removeDoctype --disable=removeEditorsNSData --disable=removeElementsByAttr --disable=removeEmptyAttrs --disable=removeEmptyContainers --disable=removeEmptyText --disable=removeHiddenElems --disable=removeMetadata --disable=removeNonInheritableGroupAttrs --disable=removeRasterImages --disable=removeScriptElement --disable=removeStyleElement --disable=removeTitle --disable=removeUnknownsAndDefaults --disable=removeUnusedNS --disable=removeUselessDefs --disable=removeUselessStrokeAndFill --disable=removeViewBox --disable=removeXMLNS --disable=removeXMLProcInst --disable=sortAttrs --pretty --indent=1

END


ActivateEverything=<<END

svgo -i min.svg -o output.svg --enable=cleanupAttrs --enable=cleanupEnableBackground --enable=cleanupIDs --enable=cleanupListOfValues --enable=cleanupNumericValues --enable=collapseGroups --enable=convertColors --enable=convertPathData --enable=convertShapeToPath --enable=convertStyleToAttrs --enable=convertTransform --enable=inlineStyles --enable=mergePaths --enable=minifyStyles --enable=moveElemsAttrsToGroup --enable=moveGroupAttrsToElems --disable=prefixIds --enable=removeAttrs --enable=removeComments --enable=removeDesc --enable=removeDimensions --enable=removeDoctype --enable=removeEditorsNSData --enable=removeElementsByAttr --enable=removeEmptyAttrs --enable=removeEmptyContainers --enable=removeEmptyText --enable=removeHiddenElems --enable=removeMetadata --enable=removeNonInheritableGroupAttrs --enable=removeRasterImages --enable=removeScriptElement --enable=removeStyleElement --enable=removeTitle --enable=removeUnknownsAndDefaults --enable=removeUnusedNS --enable=removeUselessDefs --enable=removeUselessStrokeAndFill --enable=removeViewBox --enable=removeXMLProcInst --enable=sortAttrs --pretty --indent=1  --disable=removeXMLNS

END