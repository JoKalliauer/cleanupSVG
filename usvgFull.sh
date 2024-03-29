#!/bin/bash

for file in *.svg;do
chmod u+r "${file}"
# export file=min.svg
export fileN=$(echo $file | cut -f1 -d" ")
export tmp=${fileN%.svg}
export i=${tmp}U.svg

echo #Add a empty line to split the output

echo usvg ${file} to $i begin

time usvg "$file" $i --indent 1

#--properties-precision 2 # https://commons.wikimedia.org/wiki/File:Mn_coa_%C3%B6v%C3%B6rkhangai_aimag.svg  --properties-precision 3 https://commons.wikimedia.org/wiki/File:France_-_Density_of_Monuments_historiques_by_commune,_with_departments.svg
#--transforms-precision 4 # https://commons.wikimedia.org/wiki/File:Mn_coa_%C3%B6v%C3%B6rkhangai_aimag.svg
#--transforms-precision 7 # https://commons.wikimedia.org/wiki/File:Flag-map_of_the_world.svg
# --paths-coordinates-precision 4(min) https://commons.wikimedia.org/wiki/File:FlagOfYorkshire.svg , https://commons.wikimedia.org/wiki/File:France_-_Density_of_Monuments_historiques_by_commune,_with_departments.svg

#--paths-to-relative no # https://github.com/RazrFalcon/svgcleaner/issues/124
# leads to --apply-transform-to-paths no
# and to --remove-unused-segments yes
# and to --convert-segments no

#--join-style-attributes no # I prefer font-size="20px" than style="font-size:20px;"

#--remove-declarations no #valid-warning https://github.com/RazrFalcon/svgcleaner/issues/121

#--remove-nonsvg-elements  # removes flowtext

#--join-arcto-flags no # https://github.com/svg/svgo/issues/949

# --resolve-use no # https://github.com/RazrFalcon/svgcleaner/issues/159


#echo mv ./${file} ./${tmp}4.xml
mv "./${file}" ./${tmp}4.xml

#echo cleaner $i finish

done

DeactivateEverything=<<END

svgcleaner.exe min.svg output.svg --allow-bigger-file --indent 1 --apply-transform-to-gradients no --apply-transform-to-shapes no --convert-segments no --convert-shapes no --group-by-style no --join-arcto-flags no --join-style-attributes no --merge-gradients no --regroup-gradient-stops no --remove-comments no --remove-declarations no --remove-default-attributes no --remove-desc no --remove-dupl-cmd-in-paths no --remove-dupl-fegaussianblur no --remove-dupl-lineargradient no --remove-dupl-radialgradient no --remove-gradient-attributes no --remove-invalid-stops no --remove-invisible-elements no --remove-metadata no --remove-needless-attributes no --remove-nonsvg-attributes no --remove-nonsvg-elements no --remove-text-attributes no --remove-title no --remove-unreferenced-ids no --remove-unresolved-classes no --remove-unused-coordinates no --remove-unused-defs no --remove-unused-segments no --paths-to-relative no --remove-version no --remove-xmlns-xlink-attribute no --resolve-use no --simplify-transforms no --trim-colors no --trim-ids no --trim-paths no --ungroup-defs no --ungroup-groups no --use-implicit-cmds no --apply-transform-to-paths no  # --copy-on-error

END

ActivateEverything=<<END


svgcleaner min.svg output.svg --allow-bigger-file --indent 1 --apply-transform-to-gradients yes --apply-transform-to-shapes yes --convert-shapes yes --group-by-style yes --join-arcto-flags yes --join-style-attributes all --merge-gradients yes --regroup-gradient-stops yes --remove-comments yes --remove-declarations yes --remove-default-attributes yes --remove-desc yes --remove-dupl-cmd-in-paths yes --remove-dupl-fegaussianblur yes --remove-dupl-lineargradient yes --remove-dupl-radialgradient yes --remove-gradient-attributes yes --remove-invalid-stops yes --remove-invisible-elements yes --remove-metadata yes --remove-needless-attributes yes --remove-nonsvg-attributes yes --remove-nonsvg-elements yes --remove-text-attributes yes --remove-title yes --remove-unreferenced-ids yes --remove-unresolved-classes yes --remove-unused-coordinates yes --remove-unused-defs yes --remove-version yes --remove-xmlns-xlink-attribute yes --resolve-use yes --simplify-transforms yes --trim-colors yes --trim-ids yes --trim-paths yes --ungroup-defs yes --ungroup-groups yes --use-implicit-cmds yes --list-separator comma --paths-to-relative yes --remove-unused-segments yes --convert-segments yes --apply-transform-to-paths yes

END

