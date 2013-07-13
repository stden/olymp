@echo off
echo Test %1
copy %1 expr.in
del expr.out
expr_pm
copy expr.out %1.a
check expr.in expr.out expr.out

