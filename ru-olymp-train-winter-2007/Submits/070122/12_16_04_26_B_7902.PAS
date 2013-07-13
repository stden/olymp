{$M 50000000}
const
    MaxN = 256;
type
    vertex = record
        r, c, a, w, d : longint;
        fucked : boolean;
    end;
    MyArray = array[1..MaxN] of vertex;
    MyArray2 = array[1..MaxN] of longint;
var
    A : MyArray;
    B : MyArray2;
    N : longint;
    ans : longint = 0;

procedure Init;
var
    i : longint;
begin
    fillchar(A, sizeof(A), 0);
    read(N);
    for i := 1 to N do
     begin
        read(A[i].r, A[i].c, A[i].a, A[i].w);
        B[i] := i;
     end;
end;

procedure dfs(v: longint);
begin
    if v <> 1 then
     begin
        dfs(A[v].r);
        A[v].d := A[A[v].r].d + 1;
     end;
end;

procedure swap(x, y : longint);
begin
    if x <> y then
     begin
        B[x] :=  B[x] xor B[y];
        B[y] :=  B[x] xor B[y];
        B[x] :=  B[x] xor B[y];
     end;
end;

procedure move(l, r, m1, m2 : longint; var x, y : longint);
var
    i : longint;
begin
    x := l;
    y := l;
    for i := l to r do
        if (A[B[i]].w < m1) or ((A[B[i]].w = m1) and (A[B[i]].d < m2)) then
         begin
            swap(i, x);
            if x <> y then
                swap(i, y);
            inc(x);
            inc(y);
         end
        else
            if (A[B[i]].w = m1) and (A[B[i]].d = m2) then
             begin
                swap(i, y);
                inc(y);
             end;
end;

procedure qsort(l, r : longint);
var
    x, y : longint;
begin
    if l < r then
     begin
        move(l, r, A[B[(l + r) shr 1]].w, A[B[(l + r) shr 1]].d, x, y);
        qsort(l, x - 1);
        qsort(y, r);
     end;
end;

procedure Fuck(v : longint);
var
    cur : longint;
begin
    inc(ans, A[v].w);
    A[v].fucked := true;
    cur := v;
    repeat
        repeat
            cur := A[cur].r;
        until (cur = 0) or not A[cur].fucked;
        if cur <> 0 then
         begin
            inc(A[A[v].r].a, A[v].a);
            if A[A[v].r].a > A[A[v].r].c then
                A[A[v].r].fucked := true;
         end;
        v := cur;
    until (v <= 1) or (A[v].c >= A[v].a);
end;

procedure Solve;
var
    i : longint;
begin
    for i := 1 to N do
        if A[i].d = 0 then
            dfs(i);
    qsort(1, N);
    i := 0;
    while not A[1].fucked do
     begin
        inc(i);
        while A[B[i]].fucked do
            inc(i);
        Fuck(B[i]);
     end;
    if ans > A[1].w then
        ans := A[1].w;
end;

procedure Print;
begin
    write(ans);
end;

begin
    assign(input, 'system.in');
    reset(input);
    assign(output, 'system.out');
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
