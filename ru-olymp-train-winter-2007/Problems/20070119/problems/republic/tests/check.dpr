uses TestLib;
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $10100000}

{$APPTYPE CONSOLE}
const MAXN = 100000;
const MAXM = 200000; {IT IS BECAUSE WE ADD CONTESTANT'S EDGES}
var rfirst, first : array[1..MAXN] of integer;
	rnext, next : array[1..MAXM] of integer;
	edg : array[1..MAXM, 1..2] of integer;
	ne, n, m : integer;
	resfile : text;

procedure AddEdge(v1, v2 : integer);
begin
	inc(ne);
	edg[ne, 1] := v1;
	edg[ne, 2] := v2;
	next[ne] := first[v1];
	first[v1] := ne;
	rnext[ne] := rfirst[v2];
	rfirst[v2] := ne;
end;

procedure Load;
var neededg, i, p, q : integer;
begin
	fillchar(first, sizeof(first), 0);
	fillchar(next, sizeof(next), 0);
	fillchar(rfirst, sizeof(rfirst), 0);
	fillchar(rnext, sizeof(rnext), 0);
	ne := 0;
	n := inf.ReadLongint;
	m := inf.ReadLongint;
	for i := 1 to m do begin
		p := inf.ReadLongint;
		q := inf.ReadLongint;
		AddEdge(p, q);
	end;
	neededg := ans.ReadLongint;
	m := ouf.ReadLongint;
	if (m <> neededg) then begin
		quit(_WA, 'Неверное количество ребер.');
	end;
	for i := 1 to m do begin
		p := ouf.ReadLongint;
		q := ouf.ReadLongint;
		if (p < 1) or (p > n) then quit(_WA, 'Плохое число');
		if (q < 1) or (q > n) then quit(_WA, 'Плохое число');
		AddEdge(p, q);
	end;
end;

var ind, was, nc : array[1..MAXN] of integer;
	ctop, ccom : integer;

procedure DfsTop(ver : integer);
var i : integer;
begin
	was[ver] := 1;
	i := first[ver];
	while i <> 0 do begin
		if (was[edg[i, 2]] = 0) then begin
			DfsTop(edg[i, 2]);
		end;
		i := next[i];
	end;
	inc(ctop);
	ind[ctop] := ver;
end;

procedure DfsCom(ver : integer);
var i : integer;
begin
	nc[ver] := ccom;
	i := rfirst[ver];
	while i <> 0 do begin
		if (nc[edg[i, 1]] = 0) then begin
			DfsCom(edg[i, 1]);
		end;
		i := rnext[i];
	end;
end;

procedure Solve;
var i : integer;
begin
	ctop := 0;
	fillchar(was, sizeof(was), 0);
	for i := 1 to  n do begin
		if (was[i] = 0) then begin
			DfsTop(i);
		end;
	end;
	ccom := 0;
	fillchar(nc, sizeof(nc), 0);
	for i := n downto 1 do begin
		if (nc[ind[i]] = 0) then begin
			inc(ccom);
			DfsCom(ind[i]);
		end;
	end;
	if ccom <> 1 then begin
		quit(_WA, 'Граф не является сильно связным.');
	end;
end;

begin
	Load;
	Solve;
	quit(_ok, 'OK');
end.