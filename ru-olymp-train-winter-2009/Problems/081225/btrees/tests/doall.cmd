fpc gen.pas
fpc genSmall.pas
fpc genMax.pas
fpc genRand.pas
gen 4 2 > 01
gen 20 2 > 02
genSmall 03 15
if errorlevel 1 goto end
genMax 16 41
if errorlevel 1 goto end
rem genRand 61 62 1000000000 347652
rem genRand 42 52 20 237846
gen 226 4 > 42
gen 190 9 > 43
gen 415 2 > 44
gen 301 3 > 45
gen 306 13 > 46
gen 323 17 > 47
gen 116 6 > 48
gen 10 10 > 49
gen 20 20 > 50
gen 30 5 > 51
gen 100 3 > 52
fpc ..\btrees_sb.pas
javac ..\btrees_ir.java
copy ..\btrees_ir.class btrees_ir.class
for %%i in (??) do (
	copy %%i btrees.in
	..\btrees_sb
	move btrees.out %%i.a
	rem java -Xmx256M -Xss64M btrees_ir
	rem fc %%i.a btrees.out
	rem if errorlevel 1 goto end
)
:end
del btrees.in
del btrees.out
