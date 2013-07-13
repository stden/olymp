{$M 50000000}
const
    MaxN = 44;
type
    MyArray = array[0..MaxN, 0..1] of int64;
var
    A : MyArray;
    N : longint;

procedure Init;
begin
    fillchar(A, sizeof(A), 0);
    read(N);
end;

procedure Solve;
var
    i, j : longint;
begin
    A[0, 0] := 1;
    for i := 1 to N do
     begin
        A[i, 0] := 2 * A[i - 1, 0] + A[i - 1, 1];
        A[i, 1] := A[i - 1, 0] + A[i - 1,1];
     end;
end;

procedure Print;
begin
    writeln(A[N, 0] + A[N, 1]);
end;

begin
    assign(input, 'badsubstr.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'badsubstr.out');
    rewrite(output);
    Print;
    close(output);
end.
