uses
	testlib, sysutils;

var
	l, jx, px: int64;

begin
	l := 0;
	while not ans.seekeof do begin
		inc(l);
		jx := round(ans.readreal);
		if ouf.seekeof then
			quit(_wa, 'not enough numbers');
		px := round(ouf.readreal);

		if jx <> px then
			quit(_wa, format('number %d wrong, expected: %d, found: %d', [l, jx, px]));
	end;
	if not ouf.seekeof then
		quit(_wa, 'too many numbers');

	quit(_ok, format('%d numbers', [l]));
end.