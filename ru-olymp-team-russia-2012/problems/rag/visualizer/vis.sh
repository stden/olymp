#!/bin/bash

#cp ../src/Visualizer.java .
javac Visualizer.java
java Visualizer $1
pushd $1.vis
mpost rec.mp
latex pics.tex
dvipdf pics.dvi
popd
cp $1.vis/pics.pdf $1.pdf
