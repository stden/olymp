@echo off
set include=c:\wc\h;c:\wc\h\nt
set lib=c:\wc\lib
cd src
call wipeall
call create
call wipeall
cd ..
call %ctstman%\sildel *.rar
%ctstman%\arccr ctstman