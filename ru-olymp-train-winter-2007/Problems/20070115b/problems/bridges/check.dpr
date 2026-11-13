uses 
	testlib, sysutils;

var
	n, ja, pa: longint;
begin
	n := 0;
	while not ans.seekeof do begin
		inc(n);
		ja := ans.readlongint;
		pa := ouf.readlongint;
		if ja <> pa then
			quit(_wa, 'number ' + inttostr(n) + ' - expected: ' + inttostr(ja) + ', found: ' + inttostr(pa));
	end;
	quit (_ok, '');
end.
