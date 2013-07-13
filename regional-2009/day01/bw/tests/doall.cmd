@echo off

dcc32 -cc generateTests.dpr
generateTests

call tall rs
call docheck rs
