{$Q-;R-;S-;I-;O+}
{$mode delphi}
const maxn = 100000;
type tedge = record
               a,b: longint;
             end;
var g,gg: array[1..maxn] of array of byte;
    group,gr,dnum,p: array[1..maxn] of longint;
    i,j,m,n,a,b,l,cur,time,low,lowv: longint;
    ans: array of tedge;

procedure newEdge(na,nb: longint);
var l: longint;
begin
	l := length(ans);
	setlength(ans,l+1);
	with ans[l] do
	begin
		a := na; b := nb;
	end;
end;

function edge(u,v: longint): boolean;
var i: longint;
begin
	result := false;
	for i:=0 to high(g[u]) do
		if (g[u][i]=v) then
		begin
			result := true;
			break;
		end;
end;

procedure dfs1(v: longint);
var i,u: longint;
begin
	group[v] := cur;
	inc(time); dnum[v] := time;
	for i:=0 to High(g[v]) do
	begin
		u := g[v][i];
		if (dnum[u]=0) then
		begin
			if not edge(u,v) then newEdge(u,v);
			p[u] := v; dfs1(u);
		end;
	end;
end;

begin
	fillchar(g,sizeof(g),0);
	assign(input,'republic.in'); reset(input);
	read(n,m);
	for i:=1 to m do
	begin
		read(a,b);
		l := length(g[a]);
		setlength(g[a],l+1);
		g[a][l] := b;
	end;
	close(input);
	fillchar(group,sizeof(group),0);
	fillchar(dnum,sizeof(dnum),0);
	fillchar(p,sizeof(p),0);
	time := 0; cur := 0;
	for i:=1 to n do
		if (dnum[i]=0) then
		begin
			inc(cur);
			gr[cur] := i;
			dfs1(i);
		end;
	for i:=1 to cur-1 do
	begin
		a := gr[i];
		b := gr[i+1];
		if not edge(a,b) then
			newEdge(a,b);
		if not edge(b,a) then
			newEdge(b,a);
	end;
	assign(output,'republic.out'); rewrite(output);
	writeln(length(ans));
	for i:=0 to high(ans) do
		writeln(ans[i].a,' ',ans[i].b);
	close(output);
end.