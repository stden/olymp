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
 dvips -t landscape %%~nt.dvi
 dvipdfm -p a4 -l %%~nt.dvi
)
