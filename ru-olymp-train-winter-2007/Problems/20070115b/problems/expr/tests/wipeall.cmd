for /l %%i in (2 1 9) do (
  del 0%%i
)
for /l %%i in (10 1 99) do (
  del %%i
)
del *.a
del *.exe
del *.in
del *.out
del *.ans
del *.class

