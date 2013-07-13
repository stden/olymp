const
    MaxN = 32;
    MaxM = 60;
type
    TMatrix = array[1..MaxN, 1..MaxN] of int64;
    MyArray = array[1..MaxN] of longint;
    MyArray2 = array[1..MaxN] of boolean;
    MyArray3 = array[1..MaxN, 0..MaxN] of longint;
    MyArray4 = array[1..MaxM, 1..2] of longint;
var
    A, cur, cur2, id : TMatrix;
    B : array[0..MaxN - 1] of TMatrix;
    C : MyArray3;
    D : MyArray;
    sign : MyArray4;
    used : MyArray2;
    M, N, p, s, t : longint;
    res : int64 = 0;
    ans : boolean = true;

procedure Init;
var
    i : longint;
    u, v : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(id, sizeof(id), 0);
    fillchar(B, sizeof(B), 0);
    fillchar(C, sizeof(C), 0);
    fillchar(D, sizeof(D), 0);
    fillchar(used, sizeof(used), false);
    fillchar(cur, sizeof(cur), 0);
    fillchar(cur2, sizeof(cur2), 0);
    read(N, M, p);
    for i := 1 to N - 1 do
        id[i, i] := 1;
    for i := 1 to M do
     begin
        read(u, v);
        A[u, v] := 1;
        A[v, u] := 1;
     end;
    read(s, t);
    for i := 1 to t do
        read(sign[i, 1], sign[i, 2]);
end;

procedure bfs;
var
    Och : MyArray;
    yk1, yk2, i : longint;

procedure Add(v, dist : longint);
begin
    inc(yk1);
    Och[yk1] := v;
    used[v] := true;
    d[v] := dist;
end;

begin
    yk1 := 0;
    yk2 := 0;
    Add(s, 0);
    while yk1 > yk2 do
     begin
        inc(yk2);
        for i := 1 to N do
            if not used[i] and (A[Och[yk2], i] = 1) then
                Add(i, d[Och[yk2]] + 1);
     end;
end;

function Mul(const A, B : TMatrix; M, N, K : longint) : TMatrix;
var
    i, j, t : longint;
begin
    fillchar(Mul, sizeof(Mul), 0);
    for i := 1 to M do
        for j := 1 to N do
            for t := 1 to K do
                Mul[i, k] := (Mul[i, k] + (A[i, j] * B[j, k]) mod p) mod p;
end;

function Power(const A : TMatrix; x, h : longint) : TMatrix;
var
    B : TMatrix;
begin
    if x = 0 then
        Power := id;
    if x = 1 then
        Power := A;
    if x > 1 then
     begin
        B := Power(A, x div 2, h);
        if odd(x) then
            Power := Mul(Mul(B, B, h, h, h), A, h, h, h)
        else
            Power := Mul(B, B, h, h, h);
     end;
end;

procedure Solve;
var
    i, j, k : longint;
    curh, curw : longint;
begin
    bfs;
    for i := 1 to N do
     begin
        inc(C[d[i], 0]);
        C[d[i], C[d[i], 0]] := i;
     end;
    for i := 1 to t do
     begin
        ans := ans and (C[sign[i, 1], 0] <> 0);
        if i <> t then
            ans := ans and (abs(sign[i, 1] - sign[i + 1, 1]) <= 1);
     end;
    if ans then
     begin
        cur := id;
        for i := 0 to N - 1 do
            for j := 1 to C[i, 1] do
                for k := 1 to C[j, 1] do
                    B[i][j, k] := A[C[i, j], C[i, k]];
        for i := 1 to t do
         begin
            cur2 := B[sign[i, 1]];
            cur2 := Power(cur2, sign[i, 2] - 1, C[sign[i, 1], 0]);
            if i > 1 then
             begin
                cur := Mul(cur, cur2, curh, curw, C[sign[i, 1], 0]);
                curw := C[sign[i, 1], 0];
             end
            else
             begin
                cur := cur2;
                curh := C[sign[i, 1], 0];
                curw := C[sign[i, 1], 0];
             end;
            if i <> t then
             begin
                fillchar(cur2, sizeof(cur2), 0);
                for j := 1 to C[sign[i, 1], 0] do
                    for k := 1 to C[sign[i + 1, 1], 0] do
                        cur2[j, k] := A[C[sign[i, 1], j], C[sign[i + 1, 1], k]];
                cur := Mul(cur, cur2, curh, curw, C[sign[i + 1, 1], 0]);
                curw := C[sign[i + 1, 1], 0];
             end;
         end;
        for i := 1 to curh do
            for j := 1 to curw do
                res := (res + cur[i, j]) mod p;
     end;
end;

procedure Print;
begin
    write(res);
end;

begin
    assign(input, 'restore.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'restore.out');
    rewrite(output);
    Print;
    close(output);
end.
