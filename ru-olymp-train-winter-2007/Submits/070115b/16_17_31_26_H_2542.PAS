const
    MaxN = 50000;
type
    MyArray = array[1..MaxN] of longint;
var
    A : MyArray;
    N : longint;
    ans : boolean;

procedure Init;
var
    i : longint;
begin
    read(N);
    for i := 1 to N do
        read(A[i]);
end;


procedure swap(i, j : longint);
begin
    if i <> j then
     begin
        A[i] := A[i] xor A[j];
        A[j] := A[i] xor A[j];
        A[i] := A[i] xor A[j];
     end;
end;

procedure Solve;
var
    i, j : longint;
begin
    i := N;
    while (i > 0) and (A[i] < A[i - 1]) do
        dec(i);
    ans := (i <> 1);
    if ans then
     begin
        j := N;
        dec(i);
        while A[j] < A[i] do
            dec(j);
        swap(i, j);
        for j := i + 1 to (N + i + 1) shr 1 do
            swap(j, N + i + 1 - j);
     end;
end;

procedure Print;
var
    i : longint;
begin
    if ans then
        for i := 1 to N do
            write(A[i], ' ')
        else
            write('IMPOSSIBLE');
end;

begin
    assign(input, 'nextperm.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'nextperm.out');
    rewrite(output);
    Print;
    close(output);
end.
