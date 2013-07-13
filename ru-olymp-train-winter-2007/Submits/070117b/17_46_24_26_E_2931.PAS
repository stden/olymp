{$M 50000000}
{$H+}
const
    MaxN = 10500;
    ans : array[false..true] of string[3] = ('NO', 'YES');
type
    MyArray = array[0..MaxN] of boolean;
    Stringi = array[1..MaxN] of char;
var
    A, B : MyArray;
    P, S : Stringi;
    N, len1, len2 : longint;

procedure Init;
begin
    fillchar(A, sizeof(A), false);
    A[0] := true;
    len1 := 0;
    while not seekeoln(input) do
     begin
        inc(len1);
        read(P[len1]);
     end;
    readln;
    len2 := 0;
    while not seekeoln(input) do
     begin
        inc(len2);
        read(S[len2]);
     end;
    readln(P);
    readln(S);
end;

procedure Solve;
var
    i, j : longint;
begin
    for i := 1 to len2 do
     begin
        for j := 1 to len1 do
            if P[j] = '*' then
                B[j] := B[j - 1] or A[j] or A[j - 1]
            else
                if P[j] = '?' then
                    B[j] := A[j - 1]
                else
                    B[j] := (S[i] = P[j]) and A[j - 1];
        A := B;
     end;
end;

procedure Print;
begin
    write(ans[A[len1]]);
end;

begin
    assign(input, 'patterns.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'patterns.out');
    rewrite(output);
    Print;
    close(output);
end.
