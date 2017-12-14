# cleanupSVG
It makes SVG W3C-Valid, removes librsvg-Bugs and cleans up useless stuff.

Download [master.zip](https://github.com/JoKalliauer/cleanupSVG/archive/master.zip) or the three files seperatly.
Each of the files work independedly.

**[svg2validsvg.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/svg2validsvg.sh)** ist a simple stringreplace

**[InkscapeBatchConverter.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/InkscapeBatchConverter.sh)** uses [Inkscape](https://inkscape.org/en/develop/getting-started/) for rewriting SVG to plain-SVG

**[scour4compression.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/scour4compression.sh)** uses [scour](https://github.com/scour-project/scour) for removing useless staff/metadata, enables viewbox, groups elemtents,...

**[cleaner4compression.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/cleaner4compression.sh)++ uses [RazrFalcon/svgcleaner](https://github.com/RazrFalcon/svgcleaner)


The following script can be run in shell-terminal:
```bash
#!/bin/bash

export minfilesize=0 #1..min file size (1...no line breaks)
export precisiondigits=2 #number of dicits for control points
export precisiondigitsN=4 #number of dicits
export meta=0 #0 removes metadata

export prepost=1
./svg2validsvg.sh

./InkscapeBatchConverter.sh

./scour4compression.sh
./cleaner4compression.sh #only tested on Windows

if minfilesize==0; then
 export prepost=2 #Some Postprocessing needs linebreaks to work correctly
else
 export prepost=0
fi
./svg2validsvg.sh


```

This script is tested on<br/>
-[Ubuntu](https://www.ubuntu.com/download/desktop) 16.04<br/>
-Windows with [Cygwin](https://cygwin.com/install.html)

Similar scripts<br/>
-[SVGOMG](https://github.com/jakearchibald/svgomg)<br/>
-[svgo](https://github.com/svg/svgo)

I am working on a grafical userinterface:<br/>
https://jokalliauer.github.io/cleanupSVG/

Some parts are from:<br/>
-[SVGOMG](https://github.com/jakearchibald/svgomg)<br/>
-[InkscapeBatchConverter](http://ge.tt/7C8JFmF1/v/0?c)
