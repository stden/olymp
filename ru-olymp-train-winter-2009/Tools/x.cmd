@echo off
if not exist %1 goto exit
..\..\dos2unix %1 %1_
del %1
ren %1_ %1
..\..\dos2unix %1.a %1_
del %1.a
ren %1_ %1.a
:exit
