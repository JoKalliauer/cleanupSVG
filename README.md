# cleanupSVG
It makes SVG W3C-Valid, removes librsvg-Bugs and cleans up useless stuff.

Download [master.zip](https://github.com/JoKalliauer/cleanupSVG/archive/master.zip) or the three files seperatly.
Each of the files work independedly.

**[svg2validsvg.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/svg2validsvg.sh)** ist a simple stringreplace

**[InkscapeBatchConverter.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/InkscapeBatchConverter.sh)** uses [Inkscape](https://inkscape.org/en/develop/getting-started/) for rewriting SVG to plain-SVG

**[scour4compression.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/scour4compression.sh)** uses [scour](https://github.com/scour-project/scour) for removing useless staff/metadata, enables viewbox, groups elemtents,...

**[cleaner4compression.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/cleaner4compression.sh)** uses [RazrFalcon/svgcleaner](https://github.com/RazrFalcon/svgcleaner)

**[o4compression.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/o4compression.sh)** uses [svgo](https://github.com/svg/svgo))


The following script can be run in shell-terminal:
```bash
#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export precisiondigits=2 #number of dicits for control points
export precisiondigitsN=4 #number of dicits
export meta=0 #0 removes metadata

./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh
./cleaner4compression.sh #only tested on Windows
./o4compression.sh #only tested on Windows
./cleaner4compression.sh #it is fast and makes a good readable file

./svg2validsvg.sh


```

This script is tested on<br/>
-[Ubuntu](https://www.ubuntu.com/download/desktop) 16.04<br/>
-Windows with [Cygwin](https://cygwin.com/install.html)

Similar scripts<br/>
-[SVGOMG](https://github.com/jakearchibald/svgomg)<br/>
-[svgo](https://github.com/svg/svgo)
-[scour](https://github.com/scour-project/scour)
-[svgcleaner](https://github.com/RazrFalcon/svgcleaner)

