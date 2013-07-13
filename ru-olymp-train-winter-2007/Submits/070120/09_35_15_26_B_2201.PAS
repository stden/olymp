{$M 50000000}
const
    MaxN = 20;
type
    TMatrix = array[1..MaxN, 1..MaxN] of int64;
    MyArray = array[1..MaxN] of int64;
var
    A, B : TMatrix;
    C, D : MyArray;
    M, N : longint;
    K : int64;
    ans : int64 = 0;

procedure Init;
var
    i, u, v : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    fillchar(C, sizeof(C), 0);
    fillchar(D, sizeof(D), 0);
    read(N, M, K);
    for i := 1 to N do
        read(C[i]);
    for i := 1 to M do
     begin
        read(u, v);
        A[u, v] := C[v];
     end;
end;

function Mul(const A, B : TMatrix) : TMatrix;
var
    i, j, k : longint;
begin
    fillchar(Mul, sizeof(Mul), 0);
    for i := 1 to N do
        for j := 1 to N do
            for k := 1 to N do
                if (A[i, k] <> 0) and (B[k, j] <> 0) and (A[i, k] + B[k, j] > Mul[i, j]) then
                    Mul[i, j] := A[i, k] + B[k, j];
end;

function Power(const A : TMatrix; x : int64) : TMatrix;
var
    B : TMatrix;
begin
    if x = 1 then
        Power := A;
    if x > 1 then
     begin
        B := Power(A, x div 2);
        if odd(x) then
            Power := Mul(Mul(B, B), A)
        else
            Power := Mul(B, B);
     end;
end;

function Mul2(const A : MyArray; const B : TMatrix) : MyArray;
var
    i, j : longint;
begin
    fillchar(Mul2, sizeof(Mul2), 0);
    for i := 1 to N do
        for j := 1 to N do
            if (A[j] <> 0) and (B[j, i] > 0) and (A[j] + B[j, i] > Mul2[i]) then
                Mul2[i] := A[j] + B[j, i];
end;

procedure Solve;
var
    i : longint;
begin
    for i := 1 to N do
     begin
        D[i] := A[1, i];
        if D[i] > 0 then
            inc(D[i], C[1]);
     end;
    if K > 1 then
     begin
        A := Power(A, K - 1);
        D := Mul2(D, A);
     end;
    for i := 1 to N do
        if D[i] > ans then
            ans := D[i];
end;

procedure Print;
begin
    writeln(ans);
end;

begin
    assign(input, 'maxsum.in');
    reset(input);
    assign(output, 'maxsum.out');
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
