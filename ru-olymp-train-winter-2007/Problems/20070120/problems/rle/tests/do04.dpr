var
	i: longint;
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
	writeln('1000000000a1000000000b1000000000a1000000000c1000000000a1000000000b1000000000a1000000000d1000000000a1000000000b1000000000a1000000000c1000000000a1000000000b1000000000a');
	writeln(1000);
	for i := 1 to 1000 do begin
		write(rnd(15000000000) + 1);
		if (i < 1000) then
			write(' ');
	end;
	writeln;
end.