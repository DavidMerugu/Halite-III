#!/bin/bash

if [[ ! -f ../config.py ]]; then
   echo "Can't find config.py in containing directory."
   exit 1
fi

# Make sure we aren't deploying uncommited changes
# https://stackoverflow.com/questions/5143795
if ! git diff-index --quiet HEAD --; then
    echo "This Git repository has uncommited changes."
    echo "Please use a clean clone of the repository."
    exit 1
fi

cp ../config.py apiserver/apiserver/config.py

# TODO: build the website

# Wrap directories in archive in top-level Halite/ folder via a
# replacement
tar cvzf ../Halite.tgz -s ',^,Halite/,' \
    apiserver environment website

git checkout -- apiserver/apiserver/config.py
