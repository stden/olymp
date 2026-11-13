@echo off
echo Test %1
copy %1 wordgame.in
del wordgame.out
java -cp . wordgame_pm
copy wordgame.out %1.a
rem check wordgame.in wordgame.out wordgame.out

