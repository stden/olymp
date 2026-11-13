echo off
cp ../forest_pk.java ./
cp ../forest_pk_slow.java ./

javac forest_pk.java
javac forest_pk_slow.java
javac StressGen.java

:start
java StressGen
java forest_pk_slow
copy forest.out forest.ans
java forest_pk
fc forest.out forest.ans
if errorlevel 1 goto end
goto start
:end
