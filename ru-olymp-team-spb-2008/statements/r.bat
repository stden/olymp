for %%i in (*.tex) do (
latex %%~ni.tex
dvips %%~ni.dvi
dvipdfm -p a4 %%~ni.dvi
)