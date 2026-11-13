@echo off
for /d %%i in (..\problems\*) do (
	if exist ..\problems\%%i\statement\pics\buildPics.cmd (
		pushd ..\problems\%%i\statement\pics
		if exist buildPics.cmd call buildPics.cmd
		if exist r.cmd call r.cmd
		popd
	)
)

for %%i in (*.tex) do (
latex %%~ni.tex
dvips %%~ni.dvi
dvipdfmx -p a4 %%~ni.dvi
)