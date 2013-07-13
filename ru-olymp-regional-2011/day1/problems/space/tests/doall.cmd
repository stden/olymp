@echo off

for %%i in (*.t) do (
  copy %%i %%~ni > nul
)

call javac gen_space.java -encoding utf8 
call java gen_space
del gen_space*.class

if EXIST ..\check.cpp g++ ..\check.cpp -o ..\check.exe -O2
if EXIST ..\check.dpr dcc32 -cc ..\check.dpr
if EXIST ..\Check.java (
pushd ..
	mkdir __chktmp
	call javac -classpath testlib4j.jar -d __chktmp Check.java -encoding utf8 
	pushd __chktmp
	call jar cf Check.jar *.class
	xcopy /Y Check.jar ..
	popd
	rmdir /S /Q __chktmp
popd
)

call tall ab
call docheck ab

