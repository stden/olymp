@echo off
for %%t in (??) do (
 gawk -f a.awk %%t >%%t.temp
 move %%t.temp %%t
)
