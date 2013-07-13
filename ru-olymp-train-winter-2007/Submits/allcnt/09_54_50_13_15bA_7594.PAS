{$Q-;R-;S-;I-;O+;H+}
{$mode delphi}           
{$inline on}
uses Math,SysUtils;
const maxn = 20000;
var group,dnum,order: array[1..maxn] of word;
    g: array[1..maxn] of array of word;
    ans: array of word;
    n,m,i,a,b,l,cg,time: longint;

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

begin
	fillchar(g,sizeof(g),0);
	assign(input,'bridges.in'); reset(input);
	read(n,m);
	for i:=1 to m do
	begin
		read(a,b);
		l := length(g[a]);
		setlength(g[a],l+1);
		g[a][l] := b;

		l := length(g[b]);
		setlength(g[b],l+1);
		g[b][l] := a;
	end;
	close(input);
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
	setlength(ans,0);
	assign(input,'bridges.in'); reset(input);
	read(n,m);
	for i:=1 to m do
	begin
		read(a,b);
		if (group[a]<>group[b]) then
		begin
			l := length(ans);
			setlength(ans,l+1);
			ans[l] := i;
		end;
	end;
	close(input);
	assign(output,'bridges.out'); rewrite(output);
	writeln(length(ans));
	for i:=0 to High(ans) do writeln(ans[i]);
	close(output);
end.