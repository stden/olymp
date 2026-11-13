const
	alpha = 'abcdefghijklmnopqrstuvwxyz';

var
	k, i, m: longint;
	x: int64;
	a, q: array [1..100000] of int64;
	c: array [1..50000] of char;

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
	randseed := 297430724;                                                     

	k := 50000;
	x := 0;
	for i := 1 to k do begin
		a[i] := random(1000000000) + 1;
		c[i] := alpha[random(length(alpha)) + 1];
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