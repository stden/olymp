dcc32 -cc -E. ..\expr_pm.dpr
dcc32 -cc -E. ..\check.dpr
for %%f in (??) do (
  call ansone %%f
)