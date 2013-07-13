uses
    sysutils;
const
	maxd = 300000;
var
	n, i, v1, v2: longint;
	x1, x2, y1, y2: array [1..maxd] of int64;
	maxc, minc: int64;
	dx, dy, sx, sy: int64;
	ok: boolean;
	spready: longint;
begin
	randseed := 1890733128;
	
	n := 50;

	maxc := 100;
	minc := -100;
	spready := 100;

	sx := random(maxc - minc + 1) + minc;
	sy := random(maxc - minc + 1) + minc;

	x1[1] := sx;
	y1[1] := sy;
	x2[1] := sx;
	y2[1] := sy;
	v1 := 1;
	v2 := 1;
	while (v1 + v2 <= n) do begin
		if (x1[v1] < x2[v2]) then begin
			repeat
			    dx := random((maxc - minc) div n) + 1;
				dy := random(spready) - spready div 2;

				if x2[v2] <= x1[v1] + dx then begin
					ok := (y2[v2] - y1[v1]) * dx > (x2[v2] - x1[v1]) * dy
				end;
				if x2[v2] >= x1[v1] + dx then begin
					ok := (y1[v1] + dy - y2[v2 - 1]) * (x2[v2] - x2[v2 - 1]) < (x1[v1] + dx - x2[v2 - 1]) * (y2[v2] - y2[v2 - 1]);
				end;
			until ok;
			inc(v1);
			x1[v1] := x1[v1 - 1] + dx;
			y1[v1] := y1[v1 - 1] + dy;
		end else if (x1[v1] > x2[v2]) then begin
			repeat
			    dx := random((maxc - minc) div n) + 1;
				dy := random(spready) - spready div 2;

				if x1[v1] <= x2[v2] + dx then begin
					ok := (y1[v1] - y2[v2]) * dx < (x1[v1] - x2[v2]) * dy;
				end;
				if x1[v1] >= x2[v2] + dx then begin
					ok := (y2[v2] + dy - y1[v1 - 1]) * (x1[v1] - x1[v1 - 1]) > (x2[v2] + dx - x1[v1 - 1]) * (y1[v1] - y1[v1 - 1]);
				end;               
			until ok;
			inc(v2);
			x2[v2] := x2[v2 - 1] + dx;
			y2[v2] := y2[v2 - 1] + dy;
		end else begin
			dx := random((maxc - minc) div n) + 1;
			dy := random(spready) - spready div 2;

			if random(2) = 0 then begin
    			inc(v1);
    			x1[v1] := x1[v1 - 1] + dx;
    			y1[v1] := y1[v1 - 1] + dy;
			end else begin
    			inc(v2);
    			x2[v2] := x2[v2 - 1] + dx;
    			y2[v2] := y2[v2 - 1] + dy;
			end;
		end;
		//writeln(v1, ' ', v2);
	end;


	if (x2[v2] > x1[v1]) then begin
		inc(v1);
		x1[v1] := x2[v2];
		y1[v1] := y2[v2];
	end else begin
		inc(v2);
		x2[v2] := x1[v1];
		y2[v2] := y1[v1];
	end;

	writeln(n);
	for i := 1 to v1 do begin
		writeln(x1[i], ' ', y1[i]);
	end;
	for i := v2 - 1 downto 2 do begin
		writeln(x2[i], ' ', y2[i]);
	end;
end.