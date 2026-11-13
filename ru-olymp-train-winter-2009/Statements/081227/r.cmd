@echo off
if exist pics (
 pushd pics
 for %%t in (*.mp) do (
  mp %%~nt.mp
 )
 popd
)
for %%t in (*.tex) do (
 latex %%~nt.tex
 dvips %%~nt.dvi
 dvipdfm -p a4 %%~nt.dvi
)
