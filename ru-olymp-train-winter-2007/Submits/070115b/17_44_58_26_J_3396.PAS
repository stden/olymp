const
    MaxN = 32768;
    MaxM = 900000;
    eps = 1e-6;
type
    extended = longint;
    edge = record
        num, next : longint;
        w : extended;
    end;
    MyArray = array[1..MaxN] of longint;
    MyArray2 = array[1..MaxM] of edge;
    MyArray3 = array[1..MaxN] of extended;
    MyArray4 = array[1..MaxN] of boolean;
var
    A : MyArray2;
    B : MyArray;
    D : MyArray3;
    used : MyArray4;
    N, M : longint;
    next : longint = 1;

procedure Add(u, v: longint; w : extended);
begin
    A[next].num := v;
    A[next].next := B[u];
    A[next].w := w;
    B[u] := next;
    inc(next);
end;

procedure Init;
var
    i : longint;
    u, v : longint;
    w : extended;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    fillchar(D, sizeof(D), 0);
    fillchar(used, sizeof(used), false);
    read(N, M);
    for i := 1 to M do
     begin
        read(u, v, w);
        Add(u, v, w);
        Add(v, u, w);
     end;
end;

function Less(a, b : extended) : boolean;
begin
    Less := ((b - a) > eps);
end;

function Eq(a, b : extended) : boolean;
begin
    Eq := (abs(b - a) <= eps);
end;

procedure Solve;
var
    i, j, u, max : longint;
begin
    max := 1;
    for i := 2 to N do
        D[i] := 1000000000;
    for i := 2 to N do
     begin
        used[max] := true;
        u := B[max];
        while u <> 0 do
         begin
            if Less(D[max] + A[u].w, D[A[u].num]) then
                D[A[u].num] := D[max] + A[u].w;
            u := A[u].next;
         end;
        max := 0;
        for j := 1 to N do
            if (not used[j]) and ((max = 0) or Less(D[j], D[max])) then
                max := j;
     end;
    used[max] := true;
end;

procedure Print;
var
    i : longint;
begin
    for i := 1 to N do
        write(D[i], ' ');
end;

begin
    assign(input, 'path.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'path.out');
    rewrite(output);
    Print;
    close(output);
end.
