#!/bin/bash

echo $1

if [ -z $1 ]; then
 
 for file in *.png
  do
  echo $file start #Add a empty line to split the output
  convert -trim "$file" "$file"
  # trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 for file in *.jpg *.jpeg *.JPG
  do
  echo $file start #Add a empty line to split the output
  convert -trim "$file" "$file"
  # trimage -f "$file" &
  echo $file end #Add a empty line to split the output
 done
 for file in *.tif *.tiff; do \
  echo $file start #Add a empty line to split the output
  # trimage -f "$file" &
  echo $file end #Add a empty line to split the output
  out="$file.lzw.tiff"; \
  if tiffcp -c jpeg:50 "$file" "$out"; then \
    touch -r "$file" "$out";
	mv "$out" "$file"; \
  else \
    echo "ERROR with $file"; \
  fi; \
done
 
else

 trimage $1

fi

echo ====ONLY_Waiting====

wait
echo finish

