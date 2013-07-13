@echo off
for %%f in (??) do (
  if exist do%%f.* (
    del %%f
  )
)
del *.a
del *.exe
del *.in
del *.out
del *.ans
del *.class

