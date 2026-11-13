@echo off
call dcc32 -cc -M -U%testlib% -I%testlib% %1 %2 %3 %4 %5
