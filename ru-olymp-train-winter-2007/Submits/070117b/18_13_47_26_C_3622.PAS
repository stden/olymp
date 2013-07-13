{$M 50000000}
const
    MaxN = 10500;
type
    MyArray = array[1..MaxN, 1..3] of longint;
    MyArray2 = array[1..MaxN] of longint;
var
    A : MyArray;
    B : MyArray2;
    N, ans : longint;

procedure Init;
var
    i, j : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    for i := 1 to MaxN do
        for j := 1 to 3 do
            A[i, j] := MaxLongInt div 2 - 5;
    read(N);
    for i := 1 to N do
        read(A[i, 1], A[i, 2], A[i, 3]);
end;

function min(a, b : longint) : longint;
begin
    if a < b then
        min := a
    else
        min := b;
end;

procedure Solve;
var
    i, j, k : longint;
begin
    for i := 2 to N + 3 do
        B[i] := MaxLongInt div 2 - 5;
    for i := 2 to N + 3 do
        for j := 1 to 3 do
            if (i > j) then
                for k := i - j to i - 1 do
                    if B[i] > B[k] + A[i - j, j] then
                        B[i] := B[k] + A[i - j, j];
    ans := min(min(B[N + 1], B[N + 2]), B[N + 3]);
end;

procedure Print;
begin
    write(ans);
end;

begin
    assign(input, 'linguae.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'linguae.out');
    rewrite(output);
    Print;
    close(output);
end.
