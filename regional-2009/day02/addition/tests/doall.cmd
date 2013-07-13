@echo off

call dcc32 -cc ..\check.dpr

call dcc32 write_tests.dpr
call write_tests

call tall ft
docheck ft
