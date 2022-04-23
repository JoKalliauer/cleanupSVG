# cleanupSVG
It makes SVG W3C-Valid, removes librsvg-Bugs and cleans up useless stuff.

Download [master.zip](https://github.com/JoKalliauer/cleanupSVG/archive/master.zip) or the three files seperatly.
Each of the files work independedly.

**[svg2validsvg.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/svg2validsvg.sh)** ist a simple stringreplace

**[InkscapeBatchConverter.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/InkscapeBatchConverter.sh)** uses [Inkscape](https://inkscape.org/en/develop/getting-started/) for rewriting SVG to plain-SVG

**[scour4compression.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/scour4compression.sh)** uses [scour](https://github.com/scour-project/scour) for removing useless staff/metadata, enables viewbox, groups elemtents,...

**[cleaner4compression.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/cleaner4compression.sh)** uses [RazrFalcon/svgcleaner](https://github.com/RazrFalcon/svgcleaner)

**[O2.sh](https://github.com/JoKalliauer/cleanupSVG/blob/master/O2.sh)** uses [svgo](https://github.com/svg/svgo))



This script is tested on<br/>
-Fedora 32,33,34,35,36
-[Ubuntu](https://www.ubuntu.com/download/desktop) 16.04, 18.04, 20.04<br/>
-Windows11 Subsystem for Linux (Ubuntu 20.04,22.04)
-Windows with [Cygwin](https://cygwin.com/install.html) (not recommended)<br/>

Similar scripts<br/>
-[SVGOMG](https://github.com/jakearchibald/svgomg)<br/>
-[svgo](https://github.com/svg/svgo)<br/>
-[scour](https://github.com/scour-project/scour)<br/>
-[svgcleaner](https://github.com/RazrFalcon/svgcleaner)

## Install Prerequiaries:

### Linux (for Windows use WSL from Microsoft)


```
if [ -f "/etc/debian_version" ]; then
 sudo apt install python3-pip cargo npm inkscape optipng scour librsvg2-bin  python3-scour
fi
if [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
 sudo dnf install python3-pip cargo npm inkscape optipng python3-scour libcroco
fi
python3 -m pip install --upgrade pip # --user
export PATH=$PATH:~/.local/bin:~/.cargo/bin # add this to your ~/.bashrc
pip3 install --upgrade https://github.com/codedread/scour/archive/master.zip
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh #https://www.rust-lang.org/tools/install
cargo install svgcleaner --force --git https://github.com/RazrFalcon/svgcleaner
cargo install resvg

#wget https://nodejs.org/dist/latest/node-v15.4.0-linux-x64.tar.gz
#tar -zxvf node-v15.4.0-linux-x64.tar.gz
#export PATH=$PATH:~/prgm/node-v15.4.0-linux-x64/bin:
#curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - 
sudo npm i -g npm
sudo npm install -g svgo
```

## Install cleanupSVG (portable if prerequiary exits)
wget https://github.com/JoKalliauer/cleanupSVG/archive/master.zip
unzip master.zip
cd cleanupSVG-master/

Copy your svgs into this folder and then run:
- `./save.sh` if you want to run it safly
- `./Validation.sh` for validation
- `./Intense.sh` for maximum options


## Update Prerequiaries

Windows:
```cmd
python -m pip install --upgrade pip
pip install --upgrade pip
pip3 install --upgrade https://github.com/codedread/scour/archive/master.zip
rustup update
#cargo install svgcleaner --force
cargo install svgcleaner --force --git https://github.com/RazrFalcon/svgcleaner
npm install -g npm
npm install -g svgo
```

----

Linux:
```bash
#python -m pip install --upgrade pip
#sudo python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pip # --user
#sudo pip3 install --upgrade https://github.com/codedread/scour/archive/master.zip
pip3 install --upgrade https://github.com/codedread/scour/archive/master.zip # --user
rustup update
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install svgcleaner --force --git https://github.com/RazrFalcon/svgcleaner
cargo install usvg
cargo install resvg
sudo npm i -g npm
npm i -g npm
#sudo npm install -g svgo
#npm i svgo
npm -g install svgo
#npm -g install --force --git https://github.com/svg/svgo --upgrade
#svgo --version
```

## optional additional software
### Optipng (Rasteroptimization)

Windows: https://sourceforge.net/projects/optipng/<br/>
Linux: `sudo apt install optipng` or `sudo dnf install optipng`

### OXIPNG (Rasteroptimization)
`cargo install oxipng`

### Pingo (Rasteroptimization)
https://css-ig.net/pingo

### PNGOUT (Rasteroptimization)
Windows: http://advsys.net/ken/utils.htm<br/>
Linux: http://www.jonof.id.au/kenutils.html

### librsvg (svg2png)

`sudo dnf install librsvg2-tools`

wihout root:
```bash
dnf download librsvg2-tools
rpm2cpio librsvg2-tools-2.48.9-1.fc32.x86_64.rpm |cpio -idv
```

### resvg (svg2png)
```bash
git clone git@github.com:RazrFalcon/resvg.git
git pull
```

`cargo install resvg --force --git https://github.com/RazrFalcon/resvg/
`
