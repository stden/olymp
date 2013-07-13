@echo off

call dcc32 -cc gentests.dpr
call gentests.exe

dcc32 -cc ..\check.dpr

call tall rs
call docheck rs

