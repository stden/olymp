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
	
	n := 250000;

	maxc := 1000000000;
	minc := -1000000000;
	spready := 10000000;
	diry := 1;
	pwalk := 50;

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
				dy := random(spready) * diry;
				if random(pwalk) = 0 then
					diry := -diry;

				if x2[v2] <= x1[v1] + dx then begin
					ok := (y2[v2] - y1[v1]) * dx > (x2[v2] - x1[v1]) * dy
				end;
				if x2[v2] >= x1[v1] + dx then begin
					ok := (y1[v1] + dy - y2[v2 - 1]) * (x2[v2] - x2[v2 - 1]) < (x1[v1] + dx - x2[v2 - 1]) * (y2[v2] - y2[v2 - 1]);
				end;
				ok := ok and (y1[v1] + dy >= minc) and (y1[v1] + dy <= maxc);
			until ok;
			inc(v1);
			x1[v1] := x1[v1 - 1] + dx;
			y1[v1] := y1[v1 - 1] + dy;
		end else if (x1[v1] > x2[v2]) then begin
			repeat
			    dx := random((maxc - minc) div n) + 1;
				dy := random(spready) * diry;
				if random(pwalk) = 0 then
					diry := -diry;

				if x1[v1] <= x2[v2] + dx then begin
					ok := (y1[v1] - y2[v2]) * dx < (x1[v1] - x2[v2]) * dy;
				end;
				if x1[v1] >= x2[v2] + dx then begin
					ok := (y2[v2] + dy - y1[v1 - 1]) * (x1[v1] - x1[v1 - 1]) > (x2[v2] + dx - x1[v1 - 1]) * (y1[v1] - y1[v1 - 1]);
				end;               
				ok := ok and (y2[v2] + dy >= minc) and (y2[v2] + dy <= maxc);
			until ok;
			inc(v2);
			x2[v2] := x2[v2 - 1] + dx;
			y2[v2] := y2[v2 - 1] + dy;
		end else begin
   			if random(2) = 0 then begin
   				repeat
           			dx := random((maxc - minc) div n) + 1;
           			dy := random(spready) - spready div 2;
           		until (x1[v1] + dx <= maxc) and (y1[v1] + dy <= maxc) and (y1[v1] + dy >= minc);
       			inc(v1);
       			x1[v1] := x1[v1 - 1] + dx;
       			y1[v1] := y1[v1 - 1] + dy;
   			end else begin
   				repeat
           			dx := random((maxc - minc) div n) + 1;
           			dy := random(spready) - spready div 2;
           		until (x2[v2] + dx <= maxc) and (y2[v2] + dy <= maxc) and (y2[v2] + dy >= minc);
       			inc(v2);
       			x2[v2] := x2[v2 - 1] + dx;
       			y2[v2] := y2[v2 - 1] + dy;
   			end;
		end;
		//writeln(erroutput, v1, ' ', v2);
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
	j := 0;
	for i := 1 to v1 do begin
		inc(j);
		xx[j] := x1[i];
		yy[j] := y1[i];
	end;
	for i := v2 - 1 downto 2 do begin
		inc(j);
		xx[j] := x2[i];
		yy[j] := y2[i];
	end;

	s := random(n) + 1;
	for i := s to n do 
		writeln(xx[i], ' ', yy[i]);
	for i := 1 to s - 1 do 
		writeln(xx[i], ' ', yy[i]);
end.