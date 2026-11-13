const maxn = 50001;
var deg,leaf: array[1..maxn] of word;
    i,a,b,n,k,ans: longint;
begin
	assign(input,'biconn.in'); reset(input);
	read(n);
	for i:=1 to n-1 do
	begin
		read(a,b);
		inc(deg[a]); inc(deg[b]);
	end;
	close(input);
	k := 0;
	for i:=1 to n do
		if (deg[i]=1) then
		begin
			inc(k);
			leaf[k] := i;
		end;
	assign(output,'biconn.out'); rewrite(output);
	ans := k div 2;
	if (k mod 2=1) then inc(ans);
	writeln(ans);
	if (k mod 2=1) then
	begin
		writeln(leaf[1],' ',leaf[k]);
		dec(k);
	end;
	i := 1;
	while (i < k) do
	begin
		writeln(leaf[i],' ',leaf[i+1]);
		inc(i,2);
	end;
	close(output);
end.