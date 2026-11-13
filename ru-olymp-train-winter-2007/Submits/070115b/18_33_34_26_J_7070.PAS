const
    MaxN = 32768;
    MaxSt = 65535;
    MaxM = 900000;
    eps = 1e-6;
    inf = 500000000;
type
    edge = record
        num, next : longint;
        w : longint;
    end;
    MyArray = array[1..MaxN] of longint;
    MyArray2 = array[1..MaxM] of edge;
    MyArray3 = array[1..MaxN] of longint;
    MyArray4 = array[1..MaxN] of boolean;
    MyArray5 = array[1..MaxSt, 1..2] of longint;
var
    A : MyArray2;
    B : MyArray;
{    D : MyArray3;}
    tree : MyArray5;
    used : MyArray4;
    N, M : longint;
    next : longint = 1;
    st : longint;

procedure Add(u, v: longint; w : longint);
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
    w : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
{    fillchar(D, sizeof(D), 0);}
    fillchar(tree, sizeof(tree), 0);
    for i := 1 to MaxSt do
     begin
        tree[i, 2] := i{ + 1 - st};
        tree[i, 1] := inf + 5;
     end;
    fillchar(used, sizeof(used), false);
    read(N, M);
    st := 1;
    while st < N do
        inc(st, st);
    for i := 1 to M do
     begin
        read(u, v, w);
        Add(u, v, w);
        Add(v, u, w);
     end;
end;

function less(i, j : longint) : boolean;
begin
    less := ((tree[i, 1] + (inf + 1) * ord(used[tree[i, 2] + 1 - st])) < (tree[j, 1] + (inf + 1) * ord(used[tree[j, 2] + 1 - st])));
end;

procedure Update(num, x : longint);
var
    nnew : longint;
begin
    inc(num, st - 1);
    tree[num, 1] := x;
    while num <> 1 do
     begin
        if Less(num, num xor 1) then
            nnew := num
        else
            nnew := num xor 1;
        tree[num shr 1, 1] := tree[nnew, 1];
        tree[num shr 1, 2] := tree[nnew, 2];
        num := num shr 1;
     end;
end;

procedure Solve;
var
    i, j, u, max : longint;
begin
    max := 1;
    for i := 2 to N do
        Update(i, inf);
    Update(1, 0);
    for i := 2 to N do
     begin
        used[max] := true;
        Update(max, tree[max + st - 1, 1]);
        u := B[max];
        while u <> 0 do
         begin
            if tree[st + max - 1, 1] + A[u].w < tree[st + A[u].num - 1, 1] then
                Update(A[u].num, tree[max + st - 1, 1] + A[u].w);
            u := A[u].next;
         end;
        max := tree[1, 2] + 1 - st;
     end;
    used[max] := true;
end;

procedure Print;
var
    i : longint;
begin
    for i := 1 to N do
        write(tree[i + st - 1, 1], ' ');
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
