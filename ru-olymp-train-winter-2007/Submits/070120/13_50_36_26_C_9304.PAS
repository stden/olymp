{$M 50000000}
const
    MaxN = 10000000;
    MaxM = 100000;
type
    MyArray = array[1..MaxN] of char;
    MyArray2 = array[1..MaxM] of longint;
    MyArray3 = array[0..MaxN] of longint;
var
    A : MyArray;
    L : MyArray3;
    P : MyArray2;
    len : longint = 0;
    N, M, max : longint;

procedure Init;
var
    ch : char;
    kolvo, i : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(P, sizeof(P), 0);
    fillchar(L, sizeof(L), 0);
    kolvo := 0;
    while not seekeoln(input) do
     begin
        read(ch);
        if ch in ['0'..'9'] then
            kolvo := kolvo * 10 + ord(ch) - ord('0')
        else
         begin
            if kolvo = 0 then
                kolvo := 1;
            for i := 1 to kolvo do
                A[len + i] := ch;
            inc(len, kolvo);
            kolvo := 0;
         end;
     end;
    read(M);
    max := 0;
    for i := 1 to M do
     begin
        read(P[i]);
        if P[i] > max then
            max := P[i];
     end;
end;

procedure Solve;
var
    i : longint;
    cur : longint;
begin
    L[1] := 0;
    for i := 2 to max do
     begin
        cur := L[i - 1];
        while (cur <> 0) and (A[cur + 1] <> A[i]) do
            cur := L[cur];
        if A[cur + 1] = A[i] then
            L[i] := cur + 1
        else
            L[i] := 0;
     end;
end;

procedure Print;
var
    i : longint;
begin
    for i := 1 to M do
        writeln(L[P[i]]);
end;

begin
    assign(input, 'rle.in');
    reset(input);
    assign(output, 'rle.out');
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
