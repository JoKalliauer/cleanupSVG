#!/bin/bash

echo $1

if [ -z $1 ]; then
 for file in *.pdf
  do

  echo #Add a empty line to split the output
  
  export filename=${file%.pdf}
  export mvfile=${filename}_old.pdf
  export outfile=${filename}.pdf
  
  mv "$file" $mvfile
  
  qpdf --qdf $mvfile - | python strip_page_group.py | fix-qdf > $outfile
  rm $mvfile

  done
else

  export file=$1
  export filename=${file%.pdf}
  export outfile=${filename}_.pdf
  
  qpdf --qdf "$file" - | python strip_page_group.py | fix-qdf > $outfile

fi

wait
echo finish
