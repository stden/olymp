@echo off

javac TestGen.java
java TestGen
del TestGen.class

g++ ..\check.cpp -O2 -o ..\check.exe

call tall mb
call docheck mb
