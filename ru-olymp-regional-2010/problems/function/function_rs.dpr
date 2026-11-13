{$r+,q+,o-}
{$apptype console}
{$minstacksize 9000000 9000000}
uses
	SysUtils, Math;

type
	int = longint;

const
	MAXN = 100000;

var
	ans, prevU, prevV: array [1..MAXN, 0..1] of int;

procedure print(u: int; value: int);
begin
	if (u = 2) then begin
		write(prevU[u][value], prevV[u][value]);
		exit;
	end;
	print(u - 1, prevU[u][value]);
	write(prevV[u][value]);
end;

var
	n, i, u, v: int;
	f: array [0..1, 0..1] of int;
	s: string;

begin
	reset(input, 'function.in');
	rewrite(output, 'function.out');

	readln(n);
	readln(s);
	if (s[1] = '0') then f[0][0] := 0 else f[0][0] := 1;
	if (s[2] = '0') then f[0][1] := 0 else f[0][1] := 1;
	if (s[3] = '0') then f[1][0] := 0 else f[1][0] := 1;
	if (s[4] = '0') then f[1][1] := 0 else f[1][1] := 1;

	assert(n >= 2);

	ans[2][0] := -1;
	ans[2][1] := -1;
	for u := 0 to 1 do begin
		for v := 0 to 1 do begin
			if (u + v > ans[2][f[u][v]]) then begin
				ans[2][f[u][v]] := u + v;
				prevU[2][f[u][v]] := u;
				prevV[2][f[u][v]] := v;
			end;
		end;
	end;

	for i := 3 to n do begin
		ans[i][0] := -1;
		ans[i][1] := -1;
		for u := 0 to 1 do begin
			for v := 0 to 1 do begin
				if (ans[i - 1][u] + v > ans[i][f[u][v]]) then begin
					ans[i][f[u][v]] := ans[i - 1][u] + v;
					prevU[i][f[u][v]] := u;
					prevV[i][f[u][v]] := v;
				end;
			end;
		end;
	end;

	if (ans[n][1] < 0) then begin
		writeln('No solution')
	end else begin
		print(n, 1);
		writeln;
	end;
end.
