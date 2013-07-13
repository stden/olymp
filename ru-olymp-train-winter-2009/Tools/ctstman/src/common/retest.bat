@echo off
call %ctstman%\recreate %1
call test %1
