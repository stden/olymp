@echo off
echo Test %1
copy %1 aplusb.in
del aplusb.out
java -cp . aplusb_pm
copy aplusb.out %1.a
check aplusb.in aplusb.out aplusb.out

