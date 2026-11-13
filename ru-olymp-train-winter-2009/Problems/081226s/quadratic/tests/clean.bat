for %%i in (??) do (
	if exist do%%i.dpr (
		del %%i
		del do%%i.exe
	)
	del %%i.a
)
