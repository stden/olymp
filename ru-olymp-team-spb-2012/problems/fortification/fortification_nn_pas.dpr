
(*
	Correct pascal solution. Straightforward idea of building chains and then building cycles.

	User: niyaz.nigmatullin
*)

uses
	SysUtils, Math;

const
	MODULE = 1000000007;
		
var
	a, b : array [1 .. 1 shl 17] of integer;
	was : array [1 .. 1 shl 17] of boolean;
	ans, count, n, m, cur, next, last, i, v, u : integer;

begin
	reset(input, 'fortification.in');
	rewrite(output, 'fortification.out');
	read(n, m);
	fillchar(a, sizeof(a), -1);
	fillchar(b, sizeof(b), -1);
	for i := 1 to m do begin
		read(v, u);
		if a[v] < 0 then
			a[v] := u
		else
			b[v] := u;
		if a[u] < 0 then
			a[u] := v
		else
			b[u] := v;
	end;
	fillchar(was, sizeof(was), false);
	for i := 1 to n do begin
		if was[i] then
			continue;
		if b[i] >= 0 then
			continue;
		was[i] := true;
		cur := a[i];
		last := i;
		while cur >= 0 do begin
			was[cur] := true;
			next := a[cur] xor b[cur] xor last;
			last := cur;
			cur := next;
		end;
	end;
	ans := 1;
	for i := 1 to n do begin
	    if was[i] then
	     	continue;
	    cur := a[i];
		last := i;
		count := 1;
		was[i] := true;
		while cur <> i do begin
			was[cur] := true;
			next := a[cur] xor b[cur] xor last;
			last := cur;
			cur := next;
			inc(count);
		end;
		ans := integer(int64(ans) * count mod MODULE);
	end;
	writeln(ans);
end.