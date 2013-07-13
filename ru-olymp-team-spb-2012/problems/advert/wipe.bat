@echo off
del /Q tests\*
rmdir tests
del /S *.class *.jar *.exe *.in *.out *.o
rm src/testcomments.txt