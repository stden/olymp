@echo off
for %%t in (*.tex) do (
 latex %%~nt.tex
 dvips %%~nt.dvi
 dvipdfm -p a4 %%~nt.dvi
)
