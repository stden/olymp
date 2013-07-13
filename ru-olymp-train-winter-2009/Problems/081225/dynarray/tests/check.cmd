echo off
cls
for %%i in (??) do (
    copy %%i dynarray.in >nul
    dynarray_ir_slow.exe
    fc dynarray.out %%i.a
)
