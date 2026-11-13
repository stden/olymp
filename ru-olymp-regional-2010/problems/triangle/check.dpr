uses
    testlib, sysutils;

const
    eps = 1.1e-6;

var
    ja, pa: extended;
    i, l : longint;

begin
	l := 0;
	for i := 1 to 2 do begin
		inc(l);
        ja := ans.readreal;
        pa := ouf.readreal;

        if abs(ja - pa) > eps then
            quit(_wa, 'Number ' + inttostr(l) + ' - expected: ' + floattostr(ja) + ', found: ' + floattostr(pa));
	end;
    quit(_ok, inttostr(l) + ' numbers');
end.