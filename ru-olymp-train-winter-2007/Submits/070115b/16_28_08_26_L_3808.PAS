const
    MaxN = 250000;
type
    MyArray = array[1..MaxN] of char;
    MyArray2 = array[1..MaxN] of longint;
var
    A : MyArray;
    l : MyArray2;
    N, M : longint;

procedure Init;
var
    ch : char;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(l, sizeof(l), 0);
    while not eof(input) do
     begin
        read(ch);
        if (ord(ch) >= 33) and (ord(ch) <= 126) then
         begin
            inc(N);
            A[N] := ch;
         end;
        if ch = '*' then
            M := N;
     end;
end;

procedure Solve;
var
    i, t : longint;
begin
    for i := 2 to N do
     begin
        t := l[i - 1];
        while (t <> 0) and (A[t + 1] <> A[i]) do
            t := l[t];
        if A[t + 1] = A[i] then
            l[i] := t + 1
        else
            l[i] := 0;
        if l[i] = M - 1 then
            writeln(i + 2 - 2 * M);
     end;
end;

begin
    assign(input, 'substr.in');
    reset(input);
    Init;
    close(input);
    assign(output, 'substr.out');
    rewrite(output);
    Solve;
    close(output);
end.
