uses
    sysutils;
const
	maxd = 300000;
var
	n, i, v1, v2, x, j, s: longint;
	x1, x2, y1, y2, xx, yy: array [1..maxd] of int64;
	maxc, minc: int64;
	diry, dx, dy, sx, sy: int64;
	ok: boolean;
	spready: longint;
	pwalk: longint;
begin
	randseed := 771265645;
	
	n := 100000;

	writeln(n);
	for i := 1 to n do begin
		writeln(round(1000000000 * cos(i / n * 2 * pi)), ' ',round(1000000000 * sin(i / n * 2 * pi)));
	end;
end.