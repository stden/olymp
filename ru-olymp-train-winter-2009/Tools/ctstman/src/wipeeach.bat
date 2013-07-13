@echo off
if -%1==- goto exit
if exist %1\wipetask.bat goto cont
if exist %1\*.bat goto cont
if not exist %1 goto exit
:cont
echo Cleaning %1...
cd %1
for %%a in (colorchk.exe *.obj arcname.exe bp.psm *.map *.bak __tmp__.bat) do if exist %%a del %%a
for %%a in (unix2dos.exe rentst.exe) do if exist %%a del %%a
cd ..
:exit