@echo off
copy %1 psyche.in
del psyche.out
..\psyche_pm
copy psyche.out %1.a
