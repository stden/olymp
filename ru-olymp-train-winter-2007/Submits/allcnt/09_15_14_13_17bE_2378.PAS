{$Q-;R-;S-;I-}
{$align 1}
{$inline on}
{$mode delphi}
const maxn = 10010;
var can: array[0..maxn,0..maxn] of byte;
    i,j,n,m: longint;
    p,s: ansistring;
    yes: boolean;

function get(i,j: longint): boolean; inline;
begin
	result := (can[i][j div 8] and (1 shl (j mod 8)))<>0;
end;

procedure _set(i,j: longint; v: boolean); inline;
begin
	if v then
		can[i][j div 8] := can[i][j div 8] or (1 shl (j mod 8));
end;

begin
	assign(input,'patterns.in'); reset(input);
	readln(p);
	readln(s);
	close(input);
	n := length(p); m := length(s);
	_set(0,0,true);
	for i:=1 to n do
	begin
		if (p[i]<>'*') then break;
		_set(0,i,true);
	end;
	for i:=1 to m do
		for j:=1 to n do
		begin
			if (p[j]='?') then
				_set(i,j,get(i-1,j-1)) else
			if (p[j]='*') then
				_set(i,j,get(i-1,j) or get(i,j-1) or get(i-1,j-1)) else
				_set(i,j,(s[i]=p[j]) and get(i-1,j-1));
		end;
	assign(output,'patterns.out'); rewrite(output);
	yes := get(m,n);
	if yes then writeln('YES') else writeln('NO');
	close(output);
end.