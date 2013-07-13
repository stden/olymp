dcc32 -cc paint
paint <tri.in >test.mp
mpost test.mp
tex mproof test.1
dvips mproof
start mproof.ps
