{$Q-;R-;S-;I-}
const maxn = 10010;
var can: array[0..maxn,0..maxn] of boolean;
    i,j,n,m: longint;
    p,s: ansistring;
    yes: boolean;
begin
	assign(input,'patterns.in'); reset(input);
	readln(p);
	readln(s);
	close(input);
	n := length(p); m := length(s);
	can[0,0] := true;
	can[1,0] := false;
	if (n <> 0) then
		can[0,1] := p[1]='*';
	for j:=1 to n do
		for i:=1 to m do
		begin
			if (p[j]='?') then
				can[i,j] := can[i-1,j-1] else
			if (p[j]='*') then
				can[i,j] := can[i-1,j] or can[i,j-1] or can[i-1,j-1] else
				can[i,j] := (s[i]=p[j]) and can[i-1,j-1];
		end;
	assign(output,'patterns.out'); rewrite(output);
	yes := can[m,n];
	if yes then writeln('YES') else writeln('NO');
	close(output);
end.