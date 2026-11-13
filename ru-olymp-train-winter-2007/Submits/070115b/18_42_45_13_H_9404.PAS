{$Q-;R-;S-;I-;O+}
{$mode delphi}
var a: array[0..50001] of longint;
    b: array[0..50001] of longint;
    n,t,d,i,j: longint;

procedure swap(var a,b: longint);
var t: longint;
begin
	t := a; a := b; b := t;
end;

procedure sort(l,r: longint);
var i,j,x: longint;
begin
	if (l>=r) then exit;
	x := a[(l+r) shr 1];
	i := l; j := r;
	while (i<j) do
	begin
		while (a[i]<x) do inc(i);
		while (a[j]>x) do dec(j);
		if (i<=j) then
		begin
			swap(a[i],a[j]);
			inc(i); dec(j);
		end;
	end;
	sort(i,r);
	sort(l,j);
end;

begin
	assign(input,'nextperm.in'); reset(input);
	read(n);
	for i:=1 to n do
	begin
		read(a[i]);
		b[a[i]] := i;
	end;
	close(input);
	d := maxlongint;
	for i:=n downto 1 do
	begin
		for j:=a[i]+1 to n do
		begin
			t := b[j];
			if (a[i]<>n) and (t > i) then
			begin
				d := t; t := i; break;
			end;
		end;
		if (d <> maxlongint) then break;
	end;
	assign(output,'nextperm.out'); rewrite(output);
	if (d=maxlongint) then writeln('IMPOSSIBLE') else
	begin
		swap(a[d],a[t]);
		sort(d,n);
		for i:=1 to n do write(a[i],' ');
	end;
	close(output);
end.
