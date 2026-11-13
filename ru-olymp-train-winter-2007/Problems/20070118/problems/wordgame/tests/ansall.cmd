javac -d . ..\wordgame_pm.java
dcc32 -cc -E. ..\check.dpr
for %%f in (??) do (
  call ansone %%f
)