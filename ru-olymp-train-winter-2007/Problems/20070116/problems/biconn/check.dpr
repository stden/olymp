{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $10100000}
uses TestLib;
{$APPTYPE CONSOLE}
const MAXN = 50000;
var first : array[1..MAXN] of integer;	
	next : array[1..4 * MAXN] of integer;
	n, nedg : integer;
	edg : array[1..4 * MAXN, 1..2] of integer;

procedure AddEdge(v1, v2 : integer);
begin
	inc(nedg);
	edg[nedg, 1] := v1;
	edg[nedg, 2] := v2;
	next[nedg] := first[v1];
	first[v1] := nedg;
end;

procedure Load;
var i, p, q, k, k1 : integer;
begin
	fillchar(first, sizeof(first), 0);
	n := inf.ReadLongint;
	for i := 1 to n - 1 do begin
		p := inf.ReadLongint;
		q := inf.ReadLongint;
		AddEdge(p, q);
		AddEdge(q, p);
	end;
	k := ouf.ReadLongint;
	k1 := ans.ReadLongint;
	if (k > k1) then begin
		quit(_WA, 'Неверное количество ребер.');
	end;
	for i := 1 to k do begin
		p := ouf.ReadLongint;
		q := ouf.ReadLongint;
		if (p < 1) or (p > n) then begin
			quit(_WA, 'Неверные числа в ответе');
		end;
		if (q < 1) or (q > n) then begin
			quit(_WA, 'Неверные числа в ответе');
		end;
		AddEdge(p, q);
		AddEdge(q, p);
	end;
end;

var ind, was : array[1..MAXN] of integer;
	badedge : array[1..4 * MAXN] of integer;
	ctop : integer;

function Inv(a : integer) : integer;
begin
	if a mod 2 = 0 then Inv := a - 1
	else Inv := a + 1;
end;

procedure Dfs(ver : integer);
var i : integer;
begin
	was[ver] := 1;
	i := first[ver];
	while i <> 0 do begin
		if (was[edg[i, 2]] = 0) then begin
			Dfs(edg[i, 2]);
			badedge[i] := 1;
		end;
		i := next[i];
	end;
	inc(ctop);
	ind[ctop] := ver;
end;

var nc : array[1..MAXN + 1] of integer;
	ccom : integer;

procedure DfsCom(ver : integer);
var i : integer;
begin
	nc[ver] := ccom;
	i := first[ver];
	while i <> 0 do begin
		if (badedge[i] = 0) and (nc[edg[i, 2]] = 0) then begin
			DfsCom(edg[i, 2]);
		end;
		i := next[i];
	end;
end;

procedure Solve;
var i : integer;
begin
	fillchar(was, sizeof(was), 0);
	fillchar(ind, sizeof(ind), 0);
	ctop := 0;
	for i := 1 to n do begin
		if (was[i] = 0) then begin
			Dfs(i);
		end;
	end;
	ccom := 0;
	for i := n downto 1 do begin
		if (nc[ind[i]] <> 0) then continue;
        inc(ccom);
		DfsCom(ind[i]);
	end;
	if (ccom > 1) then quit(_WA, 'Граф не двусвязен');
end;

begin
	Load;
	Solve;
	quit(_ok, 'OK');
end.