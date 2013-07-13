@echo off
for %%t in (01 02 03 04 05 06 07 08 09 10) do (
 copy %%t %%t.temp
)
erase ??
erase ??.a
for %%t in (01 02 03 04 05 06 07 08 09 10) do (
 move %%t.temp %%t
)
