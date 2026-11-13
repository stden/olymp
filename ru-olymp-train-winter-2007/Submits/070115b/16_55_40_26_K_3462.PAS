const
    MaxN = 128000;
    eps = 1e-6;
type
    MyArray = array[1..MaxN, 1..2] of extended;
var
    A : MyArray;
    N : longint;
    ans : longint = 0;
    mozg : longint;

procedure swap(var a, b: extended);
var
    c : extended;
begin
    c := a;
    a := b;
    b := c;
end;

procedure MegaSwap(i, j : longint);
begin
    swap(A[i, 1], A[j, 1]);
    swap(A[i, 2], A[j, 2]);
end;

function Less(a, b : extended) : boolean;
begin
    Less := ((b - a) > eps);
end;

procedure Init;
var
    i : longint;
begin
    read(N);
    for i := 1 to N do
     begin
        read(A[2 * i - 1, 1], A[2 * i, 1]);
        if Less(A[2 * i, 1], A[2 * i - 1, 1]) then
            MegaSwap(2 * i - 1, 2 * i);
        A[2 * i - 1, 2] := 1;
        A[2 * i, 2] := 2;
     end;
end;

function Eq(a, b : extended) : boolean;
begin
    Eq := (abs(a - b) <= eps);
end;

procedure move(l, r : longint; m1, m2 : extended; var x, y : longint);
var
    i : longint;
begin
    x := l;
    y := l;
    for i := l to r do
        if Less(A[i, 1], m1) or (Eq(A[i, 1], m1) and Less(m1, A[i, 2])) then
         begin
            MegaSwap(i, x);
            if x <> y then
                MegaSwap(i, y);
            inc(x);
            inc(y);
         end
        else
            if Eq(A[i, 1], m1) and Eq(A[i, 2], m2) then
             begin
                MegaSwap(i, y);
                inc(y);
             end;
end;

procedure qsort(l, r : longint);
var
    x, y : longint;
begin
    if l < r then
     begin
        move(l, r, A[(l + r) div 2, 1], A[(l + r) div 2, 2], x, y);
        qsort(l, x - 1);
        qsort(y, r);
     end;
end;

procedure Solve;
var
    i, cur : longint;
begin
    qsort(1, 2 * N);
    cur := 0;
    for i := 1 to 2 * N do
     begin
        if Eq(A[i, 2], 1) then
         begin
            inc(cur);
            if cur > ans then
             begin
                ans := cur;
                mozg := i;
             end;
         end
        else
            dec(cur);
     end;
end;

procedure Print;
begin
    write(ans, ' ', (A[mozg, 1]  + 1 : 0 : 0{+ A[mozg + 1, 1]) / 2 : 0 : 1});
end;

begin
    assign(input, 'segments.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'segments.out');
    rewrite(output);
    Print;
    close(output);
end.
