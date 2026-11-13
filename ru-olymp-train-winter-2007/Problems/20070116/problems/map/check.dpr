uses
	testlib, sysutils;
var
	ja, pa: string;
	n, m, i, j: longint;
	found: boolean;
	a, b, c, d: array [1..1000] of longint;
	v: array [1..1000] of longint;
	u: array [1..1000] of boolean;
	mp: array [1..1000] of boolean;
begin
	ja := ans.readword(blanks, blanks);
	pa := ouf.readword(blanks, blanks);

	if (ja <> 'YES') and (ja <> 'NO') then
		quit(_pe, 'YES or NO expected, ' + pa + ' found');


	if pa = 'NO' then begin
		if ja = 'NO' then
			quit(_ok, 'NO');
		quit(_wa, 'NO unexpected');
	end;

	m := inf.readlongint;
	for i := 1 to m - 1 do begin
		a[i] := inf.readlongint;
		b[i] := inf.readlongint;
	end;
	n := inf.readlongint;
	for i := 1 to n - 1 do begin
		c[i] := inf.readlongint;
		d[i] := inf.readlongint;
	end;

	for i := 1 to m do begin	
		v[i] := ouf.readlongint;
		if (v[i] < 1) or (v[i] > n) then
			quit(_wa, 'wrong mapping');
		if mp[v[i]] then
			quit(_wa, 'at least two vertices mapped to vertex ' + inttostr(v[i]));
		mp[v[i]] := true;
	end;

	for i := 1 to m - 1 do begin
		found := false;
		for j := 1 to n - 1 do begin 
			if not u[j] and ((c[j] = v[a[i]]) and (d[j] = v[b[i]])) 
					or (c[j] = v[b[i]]) and (d[j] = v[a[i]]) then begin
				u[j] := true;
				found := true;
				break;
			end
		end;
		if not found then
			quit(_wa, 'wrong embedding');
	end;

	quit(_ok, 'YES');
end.