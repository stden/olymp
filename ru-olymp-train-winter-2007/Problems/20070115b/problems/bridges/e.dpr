{$R+}
const
	maxn = 20000;
	maxm = 200000;

type
	pedge = ^tedge;
	tedge = record	
		n: pedge;
		u: boolean;
		v: integer;
	end;

var
	i, k, n, m: longint;
	p: pedge;
	ed: array [1..maxm] of record
		a, b: longint;
	end;
	e: array [1..maxn] of pedge;
	u: array [1..maxn] of longint;
	passed: longint;
	v: array [1..maxn] of longint;

procedure dfs1(x: longint);
var
	p: pedge;
begin
	inc(passed);
	v[passed] := x;
	p := e[x];
	u[x] := 1;
	while assigned(p) do
	begin
		if u[p^.v] = 0 then
		begin
			dfs1(p^.v);
			p^.u := true;
		end;
		p := p^.n;
	end;
end;

procedure dfs2(x, c: longint);
var
	p: pedge;
begin
	p := e[x];
	u[x] := c;
	while assigned(p) do
	begin
		if not p^.u and (u[p^.v] = 0) then
		begin
			dfs2(p^.v, c);
		end;
		p := p^.n;
	end;
end;

begin
  	assign(input, 'e.in');
  	reset(input);
  	assign(output, 'e.out');
  	rewrite(output);

  	read(n, m);
  	for i := 1 to m do
  	begin
  	  	read(ed[i].a, ed[i].b);
  	  	new(p);
  	  	p^.n := e[ed[i].a];
  	  	p^.v := ed[i].b;
  	  	e[ed[i].a] := p;
  	  	p^.u := false;
  	  	new(p);
  	  	p^.n := e[ed[i].b];
  	  	p^.v := ed[i].a;
  	  	e[ed[i].b] := p;
  	  	p^.u := false;
  	end;

  	dfs1(1);

  	fillchar(u, sizeof(u), 0);
  	k := 0;
  	for i := 1 to n do
  		if u[v[i]] = 0 then
  		begin
  			inc(k);
  			dfs2(v[i], k);
  		end;

  	writeln(k - 1);
  	for i := 1 to m do
  		if u[ed[i].a] <> u[ed[i].b] then
  			write(i, ' ');
  	
  	close(input);
  	close(output);
end.