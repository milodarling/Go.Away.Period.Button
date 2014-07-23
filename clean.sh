#!/bin/bash
make clean

echo "removing Packages"
rm -rf Packages

echo "removing .theos"
find . -name .theos -exec rm -rf {} \;

echo "removing .DS_Store"
find . -name .DS_Store -exec rm -rf {} \;

echo "done."
