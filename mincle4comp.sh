#!/bin/bash

for file in *.svg;do
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}c.svg

if [ -z ${minfilesize+x} ]; then
 minfilesize=0
fi

if [ -z ${meta+x} ]; then
  meta=1 #if not specified kept meta to not make a copyright violation
fi

echo #Add a empty line to split the output


if [ $minfilesize == 0 ]; then
 export INDENT=1
elif [ $minfilesize == 1 ]; then
 export INDENT=none
else
 echo some error minfilesize is $minfilesize
fi

echo cleaner ${file} to $i begin, min=${minfilesize}, METAdelete=no, INDENT=$INDENT

# Inkscape->svgcleaner
#Change "'font name'" to 'font name'(solves librsvg-Bug) https://commons.wikimedia.org/wiki/File:T184369.svg
# <text id="text2" x="236.39999" y="111.6" font-size="4.98" style="font-family:'Liberation Serif', CMTT8;font-size:66.398px;stroke-width:13.333">1</text>
sed -ri "s/font-family:([-[:alnum:] ,']*)'([-[:alnum:] ]*)'([-[:lower:][:upper:], ']*)/font-family:\1\2\3/g" $file
sed -ri "s/font-family:([-[:alnum:] ,']*)'([-[:alnum:] ]*)'([-[:lower:][:upper:], ']*)/font-family:\1\2\3/g" $file
sed -ri "s/font-family=\"([-[:alnum:] ,']*)'([-[:alnum:] ]*)'([-[:lower:][:upper:], ']*)\"/font-family=\"\1\2\3\"/g" $file
#sed -ri "s/font-family=\"'([-[:alnum:] ]*)'(|,[-[:lower:]]+)\"/font-family=\'\1\'/g" $i

svgcleaner "$file" $i --allow-bigger-file --indent $INDENT --resolve-use no --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes no --group-by-style no --join-arcto-flags no --join-style-attributes no --merge-gradients yes --regroup-gradient-stops yes --remove-comments no --remove-declarations no --remove-default-attributes yes --remove-desc no --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements no --remove-metadata no --remove-needless-attributes yes --remove-nonsvg-attributes no --remove-nonsvg-elements no --remove-text-attributes no --remove-title no --remove-unreferenced-ids no --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --simplify-transforms yes --trim-colors yes --trim-ids no --trim-paths yes --ungroup-defs yes --ungroup-groups no --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths yes --coordinates-precision 2 --paths-coordinates-precision 5 --properties-precision 3 --transforms-precision 7  # --multipass # --copy-on-error # 

## == Issues ==
#--properties-precision 3 #https://commons.wikimedia.org/wiki/File:Simpsons-vector.svg #--properties-precision 2 # https://commons.wikimedia.org/wiki/File:Mn_coa_%C3%B6v%C3%B6rkhangai_aimag.svg
#--transforms-precision 7 # Philippines_orthographic_projection #--transforms-precision 5 # 5 https://commons.wikimedia.org/wiki/File:South_west_Asia.svg ## 4  https://commons.wikimedia.org/wiki/File:Mn_coa_%C3%B6v%C3%B6rkhangai_aimag.svg
# # --paths-coordinates-precision 5 https://github.com/RazrFalcon/svgcleaner/issues/145 # --paths-coordinates-precision 3 # https://commons.wikimedia.org/wiki/File:Flag_of_Budapest_(1873-2011).svg
# --paths-coordinates-precision 4 https://commons.wikimedia.org/wiki/File:FlagOfYorkshire.svg
#--join-style-attributes all # https://github.com/RazrFalcon/svgcleaner/issues/182
#--remove-declarations no #valid-warning
#--remove-nonsvg-elements  # removes flowtext https://github.com/RazrFalcon/svgcleaner/issues/126
#--remove-nonsvg-attributes no # https://github.com/RazrFalcon/svgcleaner/issues/141
#--remove-text-attributes no #keeps xml:space="preserve" for a workaround for https://github.com/scour-project/scour/issues/160 (solved) https://gitlab.com/inkscape/inbox/issues/247
#--join-arcto-flags no # https://github.com/svg/svgo/issues/949 (solved); https://github.com/scour-project/scour/wiki/Documentation#--renderer-workaround-and---no-renderer-workaround
#--remove-unused-segments no # https://github.com/RazrFalcon/svgcleaner/issues/146
# --resolve-use no # https://github.com/RazrFalcon/svgcleaner/issues/159 # https://github.com/RazrFalcon/svgcleaner/issues/204

# == old ==
#--paths-to-relative no # https://github.com/RazrFalcon/svgcleaner/issues/124 (solved)
# leads to --apply-transform-to-paths no
# and to --remove-unused-segments yes
# and to --convert-segments no

# == min ==
# keep id names: --remove-unreferenced-ids no --trim-ids no --ungroup-groups no 
# comments  --remove-comments no
# descriptions  --remove-desc no
# layers --remove-nonsvg-attributes no
# metadata  --remove-metadata no  --remove-nonsvg-elements no
# <?xml version="1.0" encoding="UTF-8"?> --remove-declarations no 

#echo mv ./${file} ./${tmp}4.xml
mv ./${file} ./${tmp}4.xml

#echo cleaner $i finish

done


