label
	cont;
var
	m, n: longint;
	i, j: longint;
	a: array [1..500, 1..500] of longint;
	b, c, x: array [1..500] of longint;
	maxc, maxb, maxx: longint;
	s, t: longint;
	ok: boolean;
begin
	randseed := 470934724;
	m := 400;
	n := 500;
	maxb := 10000;
	maxc := 10000;
	maxx := 10000;

	for i := 1 to n do begin
		repeat
			s := random(m) + 1;
			t := random(m) + 1;
		until (s <= t) and (t - s < 30);
		for j := s to t do begin
			a[j][i] := 1;
		end;
	end;

	repeat
    	for i := 1 to n do begin
    		x[i] := random(maxx + 1);
    	end;

    	ok := true;
    	for i := 1 to m do begin
    		b[i] := 0;
    		for j := 1 to n do begin
    			b[i] := b[i] + a[i][j] * x[j];
    			if (b[i] > maxb) then begin
    				ok := false;
    				goto cont;
    			end;
    		end;
    	end;
    	cont:
    	dec(maxx);
    until ok;

	for i := 1 to n do begin
		c[i] := random(maxc + 1);
	end;

	writeln(m, ' ', n);
	for i := 1 to m do begin
		for j := 1 to n do begin
			write(a[i][j]);
			if (j < n) then write(' ');
		end;
		writeln;
	end;
	for i := 1 to m do begin
		write(b[i]);
		if (i < m) then write(' ');
	end;
	writeln;
	for i := 1 to n do begin
		write(c[i]);
		if (i < n) then write(' ');
	end;
	writeln;
end.