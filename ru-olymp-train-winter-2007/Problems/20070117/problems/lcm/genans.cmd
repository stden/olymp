@echo off
if "%1"=="" exit
%1
splitout.py
rar mf -m5 -s -r %~n1.rar ??.out
