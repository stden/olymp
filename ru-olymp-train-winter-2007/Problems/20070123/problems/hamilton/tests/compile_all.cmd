@echo off

cl /GX /O2 ..\hamilton_sk.cpp
cl /GX /O2 ..\check.cpp
cl /GX /O2 gen_rand.cpp
cl /GX /O2 gen1.cpp
cl /GX /O2 gen2.cpp
cl /GX /O2 gen3.cpp
cl /GX /O2 gen_hard.cpp
cl /GX /O2 gen_hard_old.cpp
cl /GX /O2 code.cpp

del *.obj