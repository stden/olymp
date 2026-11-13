@echo off
dcc32 -cc check.dpr
pushd tests
for /l %%t in (1,1,9) do (
 if exist do0%%t.dpr (
  dcc32 -cc do0%%t.dpr
  do0%%t >0%%t
 )
)
for /l %%t in (10,1,99) do (
 if exist do%%t.dpr (
  dcc32 -cc do%%t.dpr
  do%%t >%%t
 )
)
rar x answers.rar
rem call test
