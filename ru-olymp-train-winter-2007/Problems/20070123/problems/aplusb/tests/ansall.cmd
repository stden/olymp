javac -d . ..\aplusb_pm.java
dcc32 -cc -E. ..\check.dpr
for %%f in (??) do (
  call ansone %%f
)