{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
uses Math,SysUtils;
const maxn = 200;
      infinite = maxlongint div 200;
var r,c,a,w,f,fr: array[0..maxn] of longint;
    i,j,q,n,ans: longint;

procedure swap(var a,b: longint);
var t: longint;
begin
	t := a; a := b; b := t;
end;

function parent(i: longint): longint;
begin
	i := r[i];
	while (i > 0) and (a[i]>=infinite) do i := r[i];
	result := i;
end;

begin
	assign(input,'system.in'); reset(input);
	read(n);
	for i:=1 to n do
		read(r[i],c[i],a[i],w[i]);
	close(input);
	for i:=1 to n do f[i] := i;

	for i:=1 to n do
		for j:=1 to n-1 do
			if (w[j]>w[j+1]) then
			begin
				swap(w[j],w[j+1]);
				swap(c[j],c[j+1]);
				swap(a[j],a[j+1]);
            swap(r[j],r[j+1]);
				swap(f[j],f[j+1]);
			end;
   for i:=1 to n do
      fr[f[i]] := i;
   for i:=1 to n do
      r[i] := fr[r[i]];
	i := 1; ans := 0;
	while (a[fr[1]]<=c[fr[1]]) do
		if (a[i] <> infinite) then
		begin
			inc(ans,w[i]);
			j := parent(i);
			inc(a[j],a[i]);
			a[i] := infinite;
			while (a[j]>c[j]) and (j > 0) do
			begin
				q := parent(j);
				inc(a[q],a[j]);
				a[j] := infinite;
				j := q;
			end;
			inc(i);
		end;
	assign(output,'system.out'); rewrite(output);
	writeln(ans);
	close(output);
end.
