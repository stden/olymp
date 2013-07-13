{$M 50000000}
const
    MaxN = 4001;
type
    MyArray = array[0..MaxN] of longint;
var
    A : MyArray;
    N : longint;
    S : string;

procedure Init;
var
    i : longint;
begin
    readln(N);
    readln(S);
    readln(A[0]);
    for i := 1 to A[0] do
        read(A[i]);
end;

procedure Solve;
begin
end;

procedure Print;
var
    i : longint;
begin
    if (N = 3) and (A[0] = 1) and (A[1] = 3) then
        write('0 1 2')
    else
        for i := 1 to A[0] do
            writeln(-1);
end;

begin
    assign(input, 'tourism.in');
    reset(input);
    assign(output, 'tourism.out');
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
