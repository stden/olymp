{$M 50000000}
const
    MaxN = 25000;
    MaxM = 500000;    
type
    edge = record
        v, next : longint;
    end;
    MyArray = array[1..MaxM] of longint;
    MyArray2 = array[1..MaxM] of edge;
    MyArray3 = array[1..MaxM, 1..2] of longint;
    MyArray4 = array[1..MaxN] of boolean;
    MyArray5 = array[0..MaxM] of longint;
var
    A : MyArray2;
    B, f, timein, P : MyArray;
    C, Mozg : MyArray3;
    used : MyArray4;
    ans : MyArray5;
    N, M, Mozgs : longint;
    size : longint = 0;
    t : longint = 0;

procedure Add(u, v : longint);
begin
	inc(size);
	A[size].v := v;
	A[size].next := B[u];
	B[u] := size;
end;

function min(a, b : longint) : longint;
begin
	if a < b then
		min := a
	else
		min := b;	
end;

procedure Init;
var
    i, u, v : longint;
begin
	size := 0;
	t := 0;
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    fillchar(C, sizeof(C), 0);
    fillchar(f, sizeof(f), 0);
    fillchar(used, sizeof(used), false);
    fillchar(Mozg, sizeof(Mozg), 0);
    fillchar(ans, sizeof(ans), 0);
    fillchar(P, sizeof(P), 0);
    read(N, M);
    Mozgs := 0;
    for i := 1 to M do
     begin
        read(u, v);
        Add(u, v);
        Add(v, u);
        C[2 * i - 1, 1] := u;
        C[2 * i - 1, 2] := v;
        C[2 * i, 1] := v;
        C[2 * i, 2] := u;
     end;
end;

procedure dfs(v : longint);
var
	k, u, ver : longint;
begin
	k := 0;
	timein[v] := t;
	inc(t);
	used[v] := true;
	f[v] := timein[v];
	u := B[v];
	while u <> 0 do
	 begin
	 	if A[u].v <> P[v] then
	    	if used[A[u].v] then
	    	 begin
	    		f[v] := min(f[v], timein[A[u].v]);
	    		inc(k);
	    	 end	
	    	else
	     	 begin
	     		inc(k);
	     		ver := A[u].v;
	     		P[A[u].v] := v;
	    		dfs(A[u].v);
	    		f[v] := min(f[v], f[A[u].v]);
	    		if (f[A[u].v] > timein[v]) then
	    	 	 begin
	    	 		inc(Mozgs);
	    	 		Mozg[Mozgs, 1] := v;
	    	 		Mozg[Mozgs, 2] := A[u].v;
{	    	 		writeln(v, ' ', A[u].v);}
	    	 	 end;
	     	 end;	
	 	u := A[u].next;
	 end;
	if (timein[v] = 0) and (k = 1) then
	 begin
	 	inc(Mozgs);
	 	Mozg[Mozgs, 1] := v;
	 	Mozg[Mozgs, 2] := ver;
{	 	writeln(v, ' ', ver);}
	 end;
end;

procedure qsort(l, r : longint);
var
	i, j, x1, x2 : longint;

procedure swap(var x, y : longint);
begin
	if x <> y then
	 begin
	 	x := x xor y;
	 	y := x xor y;
	 	x := x xor y;
	 end;
end;

procedure MegaSwap(i, j : longint);
begin
	swap(Mozg[i, 1], Mozg[j, 1]);
	swap(Mozg[i, 2], Mozg[j, 2]);
end;
	
begin
	i := l;
	j := r;
	x1 := Mozg[(l + r) div 2, 1];	
	x2 := Mozg[(l + r) div 2, 2];	
	repeat
		while (Mozg[i, 1] < x1) or ((Mozg[i, 1] = x1) and (Mozg[i, 2] < x2)) do
			inc(i);
		while (Mozg[j, 1] > x1) or ((Mozg[j, 1] = x1) and (Mozg[j, 2] > x2)) do
			dec(j);
		if i <= j then
		 begin
		 	MegaSwap(i, j);
		 	inc(i);
		 	dec(j);
		 end;
	until i >= j;
	if i < r then
		qsort(i, r);
	if j > l then
		qsort(l, j);
end;
  
function binsearch(x1, x2 : longint) : longint;
var
	l, m, r : longint;
begin	
	l := 1;
	r := Mozgs + 1;
	while l < r - 1 do	
	 begin
	 	m := (l + r) shr 1;
	 	if (Mozg[m, 1] > x1) or ((Mozg[m, 1] = x1) and (Mozg[m, 2] > x2)) then
	 		r := m
	 	else
	 		l := m;	
	 end;
	if (Mozg[l, 1] = x1) and (Mozg[l, 2] = x2) then
		binsearch := l
	else
		binsearch := 0;	
end;

procedure Solve;
var
	i : longint;
begin
    dfs(1);
    qsort(1, Mozgs);
    for i := 1 to 2 * M do
	 	if binsearch(C[i, 1], C[i, 2]) <> 0 then
	 	 begin
	 	 	inc(ans[0]);
	 	 	ans[ans[0]] := (i + 1) shr 1;
	 	 end;
end;

procedure Print;
var
	i : longint;
begin
	writeln(ans[0]);
	for i := 1 to ans[0] do
		write(ans[i], ' ');
{	writeln(Mozgs);
	for i := 1 to Mozgs do
		writeln(Mozg[i, 1], ' ', Mozg[i, 2]);}
end;

begin
    assign(input, 'bridges.in');
    reset(input);
    assign(output, 'bridges.out');
    rewrite(output);
    while not seekeof(input) do
     begin
        Init;
        Solve;
        Print;
     end;
    close(input);
    close(output);
end.
