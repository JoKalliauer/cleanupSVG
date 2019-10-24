#!/bin/sh
git config --global core.eol lf
git config core.eol lf
git pull
#git status
git add .
git status


    read -p "Do you wish to proceed?" yn
    case $yn in
        [Yy]* ) git commit -m "Update";git push;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac


#git status

#git status

