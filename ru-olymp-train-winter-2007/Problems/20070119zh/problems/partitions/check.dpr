uses
	testlib, sysutils;
var
	ja, pa, n: longint;
begin
	n := 0;
	while not ans.seekeof do begin
		inc(n);
    	ja := ans.readlongint;
    	pa := ouf.readlongint;
    	if ja <> pa then
    		quit(_wa, format('number %d wrong - expected: %d, found: %d', [n, ja, pa]));
    	if ans.seekeoln and not ouf.seekeoln then
    		quit(_wa, format('end of line expected after number %d', [n]));
    	if not ans.seekeoln and ouf.seekeoln then
    		quit(_wa, format('end of line unexpected after number %d', [n]));
	end;
	quit(_ok, format('%d numbers', [n, ja]));
end.