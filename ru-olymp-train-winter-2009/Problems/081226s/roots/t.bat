
if exist tests\%1 (
    copy tests\%1 input.txt > nul
    solution
	copy output.txt tests\%1.a
)