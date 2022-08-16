#!/bin/sh
export HOME=~
chmod u+rx *.sh
chmod u+r *
#rm -f *.svg *.xml *.xsvg
# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"
git config --global core.eol lf
git config core.eol lf
git config pull.rebase false # Merge (Standard-Strategie)
git pull
#git status
git add .
git reset -- *.svg *.xml *.xsvg up3.txt  pattypan*.xls *.png *:Zone.Identifier *.pdf
git status


    read -p "Do you wish to proceed?" yn
    case $yn in
        [Yy]* ) git commit -m "Update";git push;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac


#git status

#git status

