	const
	alpha = 'abcdefghijklmnopqrstuvwxyz';

var
	k, i, m, j: longint;
	x: int64;
	a, q: array [1..100000] of int64;
	c: array [1..50000] of char;
	beta: array [1..100] of longint;
	p, pnew, pcont: longint;

function rnd(x: int64): int64;
var
	i: longint;
	r: int64;
begin
	r := 0;
	for i := 1 to 10 do begin
		r := (r * 10000 + random(10000)) mod x;
	end;
	rnd := r;
end;


begin
	randseed := -344847024;

    for i := 1 to 4 do begin
    	beta[i] := 1000000000;
    end;                                       

	k := 50000;
	x := 0;
	j := 0;
	pnew := 1;
	pcont := 90;

	for i := 1 to k do begin
		p := random(100);
		if (i = 1) or (p < pnew) then begin
			a[i] := beta[random(4) + 1];
			c[i] := alpha[random(26) + 1];
		end else if (p < pnew + pcont) then begin
			inc(j);
			a[i] := a[j];
			c[i] := c[j];
		end else begin
			j := 1;
			a[i] := a[j];
			c[i] := c[j];
		end;
		x := x + a[i];
	end;
	m := 100000;
	for i := 1 to m do begin
		q[i] := rnd(x + 1);
	end;

	for i := 1 to k do begin
		write(a[i], c[i]);
	end;
	writeln;
	writeln(m);
	for i := 1 to m do begin
		write(q[i]);
		if (i < m) then
			write(' ');
	end;
	writeln;

end.