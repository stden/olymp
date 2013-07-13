{$r+,q+,o-}
{$apptype console}
uses
	SysUtils, Math;

type
	int = longint;

const
	eps: extended = 1e-7;

var
	x, y: array [1..4] of int;
	xc, yc, rc: extended;

function buildCircle(a, b, c: int): boolean;
var
	dx1, dy1, dx2, dy2: int;
	a1, b1, c1, a2, b2, c2: extended;
	d: extended;

begin
	dx1 := x[b] - x[a];
	dy1 := y[b] - y[a];
	dx2 := x[c] - x[a];
	dy2 := y[c] - y[a];
	if (dx1 * dy2 = dx2 * dy1) then begin
		result := false;
		exit;
	end;

	a1 := x[a] - x[b];
	b1 := y[a] - y[b];
	c1 := -a1 * (x[a] + x[b]) / 2.0 - b1 * (y[a] + y[b]) / 2.0;

	a2 := x[a] - x[c];
	b2 := y[a] - y[c];
	c2 := -a2 * (x[a] + x[c]) / 2.0 - b2 * (y[a] + y[c]) / 2.0;

	d := a1 * b2 - a2 * b1;
	xc := -(a1 * c2 - a2 * c1) / d;
	yc := -(c1 * b2 - c2 * b1) / d;
	rc := hypot(xc - x[a], yc - y[a]);
	result := true;
end;

function buildCircle2(p1, p2, p3, p4: int): boolean;
var
	a1, b1, c1, a2, b2, c2: extended;
	d: extended;

begin
	a1 := x[p2] - x[p1];
	b1 := y[p2] - y[p1];
	c1 := -a1 * (x[p1] + x[p2]) / 2.0 - b1 * (y[p1] + y[p2]) / 2.0;

	a2 := x[p4] - x[p3];
	b2 := y[p4] - y[p3];
	c2 := -a2 * (x[p3] + x[p4]) / 2.0 - b2 * (y[p3] + y[p4]) / 2.0;

	d := a1 * b2 - a2 * b1;
	result := false;
	if (abs(d) < eps) then
		exit;

	xc := -(c1 * b2 - c2 * b1) / d;
	yc := -(a1 * c2 - a2 * c1) / d;
	result := true;
end;

var
	count, i, w, j: int;
	rr: extended;
	ansx, ansy, ansr: array [1..7] of extended;
	duplicate: boolean;

begin
	reset(input, 'road.in');
	rewrite(output, 'road.out');

	for i := 1 to 4 do begin
		read(x[i], y[i]);
	end;

	count := 0;
	if (buildCircle(1, 2, 3)) then begin
		rr := hypot(x[4] - xc, y[4] - yc);
		if (abs(rr - rc) < eps) then begin
			writeln('Infinity');
			exit;
		end;
		inc(count);
		ansx[count] := xc;
		ansy[count] := yc;
		ansr[count] := (rr + rc) / 2.0;
	end;
	if (buildCircle(1, 2, 4)) then begin
		rr := hypot(x[3] - xc, y[3] - yc);
		inc(count);
		ansx[count] := xc;
		ansy[count] := yc;
		ansr[count] := (rr + rc) / 2.0;
	end;
	if (buildCircle(1, 3, 4)) then begin
		rr := hypot(x[2] - xc, y[2] - yc);
		inc(count);
		ansx[count] := xc;
		ansy[count] := yc;
		ansr[count] := (rr + rc) / 2.0;
	end;
	if (buildCircle(2, 3, 4)) then begin
		rr := hypot(x[1] - xc, y[1] - yc);
		inc(count);
		ansx[count] := xc;
		ansy[count] := yc;
		ansr[count] := (rr + rc) / 2.0;
	end;
	if (buildCircle2(1, 2, 3, 4)) then begin
		inc(count);
		ansx[count] := xc;
		ansy[count] := yc;
		ansr[count] := (hypot(x[1] - xc, y[1] - yc) + hypot(x[3] - xc, y[3] - yc)) / 2.0;
	end;
	if (buildCircle2(1, 3, 2, 4)) then begin
		inc(count);
		ansx[count] := xc;
		ansy[count] := yc;
		ansr[count] := (hypot(x[1] - xc, y[1] - yc) + hypot(x[2] - xc, y[2] - yc)) / 2.0;
	end;
	if (buildCircle2(1, 4, 2, 3)) then begin
		inc(count);
		ansx[count] := xc;
		ansy[count] := yc;
		ansr[count] := (hypot(x[1] - xc, y[1] - yc) + hypot(x[2] - xc, y[2] - yc)) / 2.0;
	end;

	w := 0;
	for i := 1 to count do begin
		duplicate := false;
		for j := 1 to w do begin
			if ((abs(ansx[i] - ansx[j]) < eps) and (abs(ansy[i] - ansy[j]) < eps) and (abs(ansr[i] - ansr[j]) < eps)) then begin
				duplicate := true;
				break;
			end;
		end;
		if (not duplicate) then begin
			inc(w);
			ansx[w] := ansx[i];
			ansy[w] := ansy[i];
			ansr[w] := ansr[i];
		end;
	end;

	writeln(w);

	for i := 1 to w do
		writeln(ansx[i]: 0: 6, ' ', ansy[i]: 0: 6, ' ', ansr[i]: 0: 6);
end.
