#!/bin/bash

export sourceType="svg" #for convertin in InkscapeBatchConverter
export minfilesize=0 #1..min file size (1...no line breaks)
export meta=0 #0 removes metadata
export outputType="svg" #just to not get asked by Inkscape
export file=min.svg # just used for debugging
export i=min.svg # just used for debugging

./T36947kerning.sh
./T35245singleXcoordinate.sh
./svg2validsvg.sh
#./pre.sh

#./Vacuumdefs.sh # this might add ids
#./minscour4compression.sh
#./between.sh
#./mincleaner4compression.sh #deactivate if CSS
#./mino4compression.sh
#./validBySed.sh


#./svg2validsvg.sh


#./styleNomincleaner4compression.sh

#export meta=0
#./minscour4compression.sh
./o4compression.sh
./CleanerFull.sh
./fontReplace.sh
# ./post.sh
 #./T35245singleXcoordinate.sh
 ./T36947kerning.sh; ./delX.sh

 #-------------------
 
#./mincleaner4compression.sh


#  ./UngroupByInkscape.sh;
#  ./validBycleaner.sh
 
comment=<<END


Please use: [[Commons:Commons_SVG_Checker]]
 
Errors:
# [[phab:T36947]] kerning;  ([[:en:Wikipedia:SVG_help#bad_letter-alignment_on_small_font-size]])
# [[phab:T55899]] blur; 
# [[phab:T35245]] multiple x-kordintes in tspan; ([[:de:Wikipedia:Probleme_mit_SVGs#Warum_ist_mein_Text_verschoben_(verschwunden)?]]

 
END
 
 