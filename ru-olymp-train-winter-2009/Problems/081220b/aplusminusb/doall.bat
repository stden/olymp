@echo off
call gen_dat
call gen_ans solution_dkmike.cpp sub
addsymmetric.py
