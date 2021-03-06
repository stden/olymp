{$Q-;R-;S-;I-;O+;H+}
const maxn = 10001;
var can: array[0..maxn,0..maxn] of boolean;
    p,s: string;
    yes: boolean;
    i,j: longint;
begin
	assign(input,'patterns.in'); reset(input);
	readln(p);
	readln(s);
	close(input);
	can[0,0] := true;
	j := 1;
	while (p[j] in ['*']) do
	begin
		for i:=0 to length(s) do
			can[i,j] := true;
		inc(j);
	end;
	for i:=1 to length(s) do
		for j:=1 to length(p) do
		begin
			if (p[j]='?') then
				can[i,j] := can[i-1,j-1] else
			if (p[j]='*') then
				can[i,j] := can[i-1,j] or can[i-1,j-1] else
				can[i,j] := (s[i]=p[j]) and can[i-1,j-1];
		end;
	assign(output,'patterns.out'); rewrite(output);
	yes := can[length(s),length(p)];
	if yes then writeln('YES') else writeln('NO');
	close(output);
end.