const
	alpha = 'abcdefghijklmnopqrstuvwxyz';

var
	i, j, k: longint;

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
	for i := 1 to 50000 do begin
		j := i and (-i);
		k := 0;
		while (j > 0) do begin
			j := j shr 1;
			k := k + 1;
		end;
		write(1000000000 - random(2), alpha[k]);
	end;
	writeln;
	writeln(100000);
	for i := 1 to 100000 do begin
		write(rnd(int64(1) * 1000000000 * 50000) + 1);
		if (i < 100000) then
			write(' ');
	end;
	writeln;
end.