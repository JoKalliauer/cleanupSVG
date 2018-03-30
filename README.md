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
-[svgo](https://github.com/svg/svgo)<br/>
-[scour](https://github.com/scour-project/scour)c
-[svgcleaner](https://github.com/RazrFalcon/svgcleaner)

## Installation on Windows:

1)Inkscape<br/>
1a)Download&Install https://inkscape.org/release/0.92.3/ (Don't forget to choose your language)<br/>
2)Scour<br/>
2a)Download&Install Python 2.7: https://www.python.org/downloads/<br/>
2b)Add "C:\Python27" and "C:\Python27\Scripts" to enviroment variable %Path%<br/>
 -(Option-i)Run cmd.exe; type ```set PYTHONPATH=C:\Python27``` and ```set PATH=%PATH%;%PYTHONPATH%;C:\Python27\Scripts```<br/>
 -(Option-ii)Run Sysdm.cpl; to to the advanced-Tab; Environemt variables...; click Path, click Edit; add ```C:\Python27``` and ```C:\Python27\Scripts```<br/>
2c)Run cmd.exe<br/>
2c,i)```python -m pip install --upgrade pip```<br/>
2c,ii)```pip install https://github.com/codedread/scour/archive/master.zip```<br/>
3)svgcleaner<br/>
3a)Download "Visual Studio Community 2017" https://www.visualstudio.com/downloads/ (Don't forget to choose your language)<br/>
3b)Download&Install https://www.rust-lang.org/ (Don't forget to choose your language)<br/>
3c)Add "%USERPROFILE%\.cargo\bin" to enviroment variable %Path%<br/>
 -(Option-i)Run cmd.exe; type ```set PATH=%PATH%;%USERPROFILE%\.cargo\bin```<br/>
 -(Option-ii)Run Sysdm.cpl; to to the advanced-Tab; Environemt variables...; click Path, click Edit; add ```C:\Users\jkalliau\.cargo\bin```<br/>
3b)cmd.exe: ```cargo install svgcleaner```<br/>
4)SVGOptimizer<br/>
4a)Install node.js: https://nodejs.org/  (Don't forget to choose your language)<br/>
4b)cmd.exe: ```npm install -g svgo```<br/>
5)Cygwin<br/>
5a)Download&Install (32bit or 64bit) https://cygwin.com/install.html

