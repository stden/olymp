cl ..\omax_dd.cpp

cl /GX gen4-6.cpp
cl /GX gen7-8.cpp
cl /GX gen9-20.cpp
cl /GX gen21-23.cpp

gen4-6.exe
gen7-8.exe
gen9-20.exe
gen21-23.exe

for %%i in (??) do (
	copy %%i omax.in
	omax_dd.exe
	copy omax.out %%i.a
)

