@echo off

if "%1" == "" (
	echo No parameters found
    exit       
)

javac Visualizer.java
java Visualizer "%1"

pushd "%1".vis
  call mp rec.mp
  latex pics.tex
  dvipdfmx pics.dvi
  xcopy pics.pdf /y ..\
popd
rename pics.pdf "%1".vis

goto exit

pushd "%1".vis
for %%i in (*.*) do del %%i
pushd ..

rmdir /S /Q "%1".vis
:exit