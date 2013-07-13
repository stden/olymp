{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}
{$inline on}
{$M 33554432}
uses Math,SysUtils;
const maxn = 50000;
var group,dnum,order: array[1..maxn] of longint;
    inp: array[1..maxn] of record a,b: longint; end;
    g: array[1..maxn] of array of longint;
    n,i,l,k,cg,time,ans: longint;
    leaf: array of longint;

procedure dfs1(v: longint);
var i,u: longint;
begin
	inc(time);
	order[time] := v;
	dnum[v] := time;
	for i:=0 to High(g[v]) do
	begin
		u := g[v][i];
		if (u <> 0) and (dnum[u]=0) then
		begin
			dfs1(u);
			g[v][i] := 0;
		end;
	end;
end;

procedure dfs2(v: longint);
var i,u: longint;
begin
	group[v] := cg;
	for i:=0 to High(g[v]) do
	begin
		u := g[v][i];
		if (u <> 0) and (group[u]=0) then dfs2(u);
	end;
end;

procedure addEdge(a,b: longint);
var l: longint;
begin
	l := length(g[a]);
	setlength(g[a],l+1);
	g[a][l] := b;
end;

procedure update;
var i,a,b: longint;
begin
   for i:=1 to n do
      setlength(g[i],0);
	for i:=1 to n-1 do
	begin
		a := inp[i].a;
		b := inp[i].b;
		addEdge(a,b);
		addEdge(b,a);
	end;
end;

function findBridge: boolean;
var i: longint;
begin
	time := 0;
	fillchar(dnum,sizeof(dnum),0);
	for i:=1 to n do
		if (dnum[i]=0) then dfs1(i);
	fillchar(group,sizeof(group),0);
	cg := 0;
	for i:=1 to n do
		if (group[order[i]]=0) then
		begin
			inc(cg);
			dfs2(order[i]);
		end;
	result := (cg<>1);
end;

procedure swap(var a,b: longint);
var t: longint;
begin
	t := a; a := b; b := t;
end;

procedure shuffle;
var i,a,b: longint;
begin
	for i:=0 to High(leaf) do
	begin
		a := random(length(leaf));
		b := random(length(leaf));
		swap(leaf[a],leaf[b]);
	end;
end;

begin
	RandSeed := 239;
	assign(input,'biconn.in'); reset(input);
	read(n);
	for i:=1 to n-1 do
		with inp[i] do read(a,b);
	close(input);
	update;
	for i:=1 to n do
		if (length(g[i])=1) then
		begin
			l := length(leaf);
			setlength(leaf,l+1);
			leaf[l] := i;
		end;
	k := length(leaf);
	ans := k div 2;
	if (k mod 2=1) then inc(ans);

	assign(output,'biconn.out'); rewrite(output);
	writeln(ans);
	repeat
		update;
		shuffle;
		if (k mod 2=1) then
		begin
			addEdge(leaf[0],leaf[k-1]);
			dec(k);
		end;
		i := 0;
		while (i < k) do
		begin
			addEdge(leaf[i],leaf[i+1]);
			addEdge(leaf[i+1],leaf[i]);
         inc(i,2);
		end;
	until not findBridge;
	if (k mod 2=1) then
	begin
		writeln(leaf[0],' ',leaf[k-1]);
		dec(k);
	end;
	i := 0;
	while (i < High(leaf)) do
	begin
		writeln(leaf[i],' ',leaf[i+1]);
		inc(i,2);
	end;
	close(output);
end.
