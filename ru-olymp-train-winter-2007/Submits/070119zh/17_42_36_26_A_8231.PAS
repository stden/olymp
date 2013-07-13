{$M 50000000}
const
    MaxN = 20;
    Sk : array[1..4] of char = ('(', ')', '[', ']');
type
    MyArray = array[-1..2 * MaxN, -1..2 * MaxN] of int64;
var
    A : MyArray;
    S, ans : string;
    N, M : longint;

procedure Init;
begin
    fillchar(A, sizeof(A), 0);
    read(N, M);
end;

function Mozg(ch1, ch2 : char) : boolean;
begin
    Mozg := ((ch1 = '(') and (ch2 = ')')) or ((ch1 = '[') and (ch2 = ']'));
end;

procedure Solve;
var
    i, j : longint;
    sum : int64;
begin
    A[0, 0] := 1;
    for i := 1 to 2 * N do
        for j := 0 to N do
            A[i, j] := 2 * A[i - 1, j + 1] + A[i - 1, j - 1];
    S := '';
    ans := '';
    for i := 1 to 2 * N do
     begin
        sum := 0;
        j := 0;
        while (j <= 4) and (sum < M) do
         begin
            inc(j);
            if odd(j) then
                inc(sum, A[2 * N - length(ans) - 1, length(S) + 1])
            else
                if ((length(S) <> 0) and Mozg(S[length(S)], Sk[j])) then
                    inc(sum, A[2 * N - length(ans) - 1, length(S) - 1]);
         end;
        if odd(j) then
            dec(M, sum - A[2 * N - length(ans) - 1, length(S) + 1])
        else
            dec(M, sum - A[2 * N - length(ans) - 1, length(S) - 1]);
        ans := ans + Sk[j];
        if odd(j) then
            S := S + Sk[j]
        else
            if Mozg(S[length(S)], Sk[j]) then
                S := copy(S, 1, length(S) - 1);
     end;
end;

procedure Print;
begin
    write(ans);
end;

begin
    assign(input, 'parenth.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'parenth.out');
    rewrite(output);
    Print;
    close(output);
end.
