@echo off
%ctstman%\arcname %*
call __tmp__.bat
%ctstman%\sildel __tmp__.bat
