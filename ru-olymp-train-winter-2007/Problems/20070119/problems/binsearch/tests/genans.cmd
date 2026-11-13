for /l %%i in (0,1,9) do (
	for /l %%j in (0,1,9) do (
		if exist %%i%%j (

		copy %%i%%j 31415926.in
		binsearch_vg
		copy 31415926.out %%i%%j.a
		)
	)
)