const
    MaxN = 200;
    MaxM = 5;
    MaxEdge = 250000;
    ans : array[false..true] of string[3] = ('NO', 'YES');
type
    edge = record
        num1, num2, next : longint;
    end;
    MyArray = array[0..MaxN - 1] of longint;
    MyArray2 = array[1..MaxM] of MyArray;
    MyArray3 = array[0..MaxN - 1, 0..MaxN - 1] of boolean;
    MyArray4 = array[0..MaxN - 1] of boolean;
    MyArray5 = array[0..MaxN - 1, 0..MaxN - 1] of longint;
    MyArray6 = array[1..MaxEdge] of edge;
var
    A, usedP : MyArray3;
    AP : MyArray6;
    B{, C} : MyArray5;
    used : MyArray4;
    next : longint;
    F : MyArray2;
    i, N, K, T : longint;
    res : boolean;

procedure Init;
var
    i, j : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(AP, sizeof(AP), 0);
    fillchar(B, sizeof(B), 0);
{    fillchar(C, sizeof(C), 0);}
    fillchar(used, sizeof(used), false);
    fillchar(usedP, sizeof(usedP), false);
    next:= 1;
    res := true;
    read(N, K);
    for i := 1 to K do
        for j := 0 to N - 1 do
         begin
            read(F[i, j]);
            A[j, F[i, j]] := true;
         end;
end;

procedure dfs(v : longint);
var
    u : longint;
begin
    used[v] := true;
    for u := 0 to N - 1 do
        if not used[u] and A[u, v] then
            dfs(u);
end;

procedure Add(u1, u2, v1, v2 : longint);
begin
    AP[next].num1 := v1;
    AP[next].num2 := v2;
    AP[next].next := B[u1, u2];
    B[u1, u2] := next;
    inc(next);
end;

procedure dfsP(v1, v2 : longint);
var
    u : longint;
begin
    usedP[v1, v2] := true;
    u := B[v1, v2];
    while u <> 0 do
     begin
        if not usedP[AP[u].num1, AP[u].num2] then
            dfsP(AP[u].num1, AP[u].num2);
        u := AP[u].next;
     end;
end;

procedure Solve;
var
    i, j, t : longint;
begin
    dfs(0);
    for i := 0 to N - 1 do
        res := res and used[i];
    if res then
     begin
        for i := 0 to N - 1 do
            for j := 0 to N - 1 do
                for t := 1 to K do
                    Add(F[t, i], F[t, j], i, j);
        for i := 0 to N - 1 do
            dfsP(i, i);
        for i := 0 to N - 1 do
            for j := 0 to N - 1 do
                res := res and usedP[i, j];
     end;
end;

procedure Print;
begin
    write(ans[res]);
    if i <> T then
        writeln;
end;

begin
    assign(input, 'bit2.in');
    reset(input);
    read(T);
    assign(output, 'bit2.out');
    rewrite(output);
    for i := 1 to T do
     begin
        Init;
        Solve;
        Print;
     end;
    close(input);
    close(output);
end.
