@echo off
cd src
for %%i in (*.exe *.~dpr *.dof *.dsk *.cfg *.in *.out *.a *.obj ?? *.class *.log *.desc testcomments.txt) do del %%i
pushd ..
for %%i in (*.exe *.~dpr *.dof *.dsk *.cfg *.in *.out *.a *.obj ?? *.class *.log *.desc Check.jar Validate.jar check.log) do del %%i
popd
cd ..
pushd tests
    del ?? ??.a
popd
rmdir /S /Q tests