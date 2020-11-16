#!/bin/sh
chmod u+rx *.sh
chmod u+r *
#rm -f *.svg *.xml *.xsvg
git config --global core.eol lf
git config core.eol lf
git config pull.rebase false # Merge (Standard-Strategie)
git pull
#git status
git add .
git reset -- *.svg *.xml *.xsvg
git status


    read -p "Do you wish to proceed?" yn
    case $yn in
        [Yy]* ) git commit -m "Update";git push;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac


#git status

#git status

