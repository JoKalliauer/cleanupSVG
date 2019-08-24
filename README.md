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
-[scour](https://github.com/scour-project/scour)<br/>
-[svgcleaner](https://github.com/RazrFalcon/svgcleaner)

## Installation:

Windows
1)Inkscape<br/>
1a)Download&Install https://inkscape.org/release/0.92.3/ (Don't forget to choose your language)<br/>
2)[scour](https://github.com/scour-project/scour)<br/>
2a)Download&Install CPython 3.7: https://www.python.org/downloads/<br/>
2b)Add "C:\Python37" and "C:\Python37\Scripts" to enviroment variable %Path%<br/>
 -(Option-i)Run cmd.exe; type ```set PYTHONPATH=C:\Python37``` and ```set PATH=%PATH%;%PYTHONPATH%;C:\Python37\Scripts```<br/>
 -(Option-ii)Run Sysdm.cpl; to to the advanced-Tab; Environemt variables...; click Path, click Edit; add ```C:\Python37``` and ```C:\Python37\Scripts```<br/>
2c)Run cmd.exe as a administrator<br/>
2c,i)```python -m pip install --upgrade pip```<br/>
2c,ii)```pip install --upgrade https://github.com/codedread/scour/archive/master.zip```<br/>
3)[svgcleaner](https://github.com/RazrFalcon/svgcleaner)<br/>
3a)Download "Visual Studio Community 2017" https://www.visualstudio.com/downloads/ (Don't forget to choose your language)<br/>
3b)Add `Desktop development with C++`, see https://github.com/rust-lang/rust/issues/49519#issuecomment-377569726
3c)Download&Install https://www.rust-lang.org/ (Don't forget to choose your language)<br/>
3d)Add "%USERPROFILE%\.cargo\bin" to enviroment variable %Path%<br/>
 -(Option-i)Run cmd.exe; type ```set PATH=%PATH%;%USERPROFILE%\.cargo\bin```<br/>
 -(Option-ii)Run Sysdm.cpl; to to the advanced-Tab; Environemt variables...; click Path, click Edit; add ```%USERPROFILE%\.cargo\bin```<br/>
3e)cmd.exe: ```cargo install svgcleaner --force --git https://github.com/RazrFalcon/svgcleaner```<br/>
4)[svgo](https://github.com/svg/svgo)<br/>
4a)Install node.js: https://nodejs.org/  (Don't forget to choose your language)<br/>
4b)cmd.exe: ```npm install -g svgo```<br/>
5)Cygwin<br/>
5a)Download&Install (32bit or 64bit) https://cygwin.com/install.html (in some cases you have to deactivate Virusprotection (e.g. Avast))<br/>
6)cygwin.exe: `/usr/bin/python3 -m pip install scour`

## Update

Windows:
```cmd
python -m pip install --upgrade pip
pip install --upgrade pip
#pip install --upgrade https://github.com/codedread/scour/archive/master.zip
pip3 install --upgrade https://github.com/codedread/scour/archive/master.zip
rustup update
#cargo install svgcleaner --force
cargo install svgcleaner --force --git https://github.com/RazrFalcon/svgcleaner
npm install -g svgo
```

----

Linux:
```bash
#python -m pip install --upgrade pip
#sudo python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pip --user
#pip install --upgrade https://github.com/codedread/scour/archive/master.zip
#sudo pip3 install --upgrade https://github.com/codedread/scour/archive/master.zip
pip3 install --upgrade https://github.com/codedread/scour/archive/master.zip --user
rustup update
cargo install svgcleaner --force --git https://github.com/RazrFalcon/svgcleaner
sudo npm i -g npm 
sudo npm install -g svgo
```
