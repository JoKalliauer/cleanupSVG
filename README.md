# cleanupSVG
It makes SVG W3C-Valid, removes librsvg-Bugs and cleans up useless stuff.

The following script can be run in shell-terminal:
```bash
#!/bin/bash

export minfilesize=1 #1..min file size
export precisiondigits=0 #number of dicits if minfilesize==1
export meta=0 #0 removes metadata, only if minfilesize==0

./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh

./svg2validsvg.sh
```
