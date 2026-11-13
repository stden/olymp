@echo off
dcc32 -cc check.dpr
pushd tests
rar x tests.rar
popd
call test
