uses
	testlib, sysutils;

var
	ja, pa, pc: int64;
	n, m, i, j: longint;
	v: int64;
	a: array [1..500, 1..500] of int64;
	b, c: array [1..500] of int64;
	x: array [1..500] of int64;

begin
	ja := ans.readlongint;
	pa := ouf.readlongint;

	if pa = -1 then begin
		if ja = pa then
			quit(_ok, '-1');
		quit(_wa, '-1 unexpected');
	end;

	m := inf.readlongint;
	n := inf.readlongint;                  

	for i := 1 to m do begin
		for j := 1 to n do begin
			a[i][j] := inf.readlongint;
		end;
	end;

	for i := 1 to m do begin
		b[i] := inf.readlongint;
	end;

	for i := 1 to n do begin
		c[i] := inf.readlongint;
	end;

	for i := 1 to n do begin
		x[i] := ouf.readlongint;
		if (x[i] < 0) or (x[i] > 1000000000) then
			quit(_Wa, format('x[%d] is clearly wrong', [i]));
	end;

	for i := 1 to m do begin
		v := 0;
		for j := 1 to n do begin
			v := v + a[i][j] * x[j];
		end;
		if (v <> b[i]) then
			quit(_wa, format('equation %d is not satisfied', [i]));
	end;

	pc := 0;
	for i := 1 to n do begin
		pc := pc + c[i] * x[i];
	end;

	if pc <> pa then
		quit(_wa, format('promised: %d, actually: %d', [pa, pc]));

	if ja = -1 then
		quit(_fail, 'jury thought it was impossible');

	if ja < pa then
		quit(_wa, format('expected: %d, found: %d', [ja, pa]));
	if ja > pa then
		quit(_fail, format('expected: %d, found: %d', [ja, pa]));

	quit(_ok, format('%d', [ja]));
end.
