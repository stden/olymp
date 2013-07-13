{$M 50000000}
const
    MaxN = 200;
type
    MyArray = array[0..MaxN, 0..MaxN] of longint;
    MyArray2 = array[1..MaxN] of boolean;
var
    A, B : MyArray;
    used : MyArray2;
    N : longint;

procedure Init;
var
    i, j : longint;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    readln(N, A[0, 0]);
    for i := 1 to A[0, 0] do
     begin
        while not seekeoln(input) do
         begin
            inc(A[i, 0]);
            read(A[i, A[i, 0]]);
         end;
        readln;
     end;
end;

procedure Solve;
var
    min, max, i, j, k : longint;
    T : array[0..MaxN] of longint;

function Can(i : longint; var min, max : longint) : boolean;
begin
    if i = A[0, 0] then
     begin
        Can := true;
        if A[i, 0] <= 2 then
         begin
            Can := false;
            min := A[i, 1];
            max := A[i, A[i, 0]];
         end;
     end
    else
     begin
        Can := (A[i, 0] <> 2) or ((A[i, 0] = 2) and ((A[i, 1] >= min) or (A[i, 2] <= max)));
        min := A[i, 1];
        max := A[i, 2];
     end;
end;

begin
    i := A[0, 0];
    while (i <> 0) and not Can(i, min, max) do
        dec(i);
    if i = 0 then
     begin
        B[0, 0] := N;
        for i := 1 to N do
         begin
            B[i, 0] := 1;
            B[i, 1] := i;
         end;
     end
    else
     begin
        for j := i to A[0, 0] do
            for k := 1 to A[j, 0] do
                used[A[j, k]] := true;
        fillchar(T, sizeof(T), 0);
        k := 1;
        for j := 1 to N do
            if used[j] then
             begin
                inc(T[0]);
                if A[i, k] = j then
                 begin
                    T[k] := T[0];
                    inc(k);
                 end;
             end;
        if T[A[i, 0]] <> T[0] then
         begin
            j := A[i, A[i, 0]] + 1;
            while not used[j] do
                inc(j);
            inc(A[i, 0]);
            A[i, A[i, 0]] := j;
         end
        else
            if T[T[0] - 1] = T[0] - 1 then
             begin
                dec(A[i, 0]);
                if T[0] = 2 then
                    A[i, A[i, 0]] := A[i, A[i, 0]]
                else
                    A[i, A[i, 0]] := A[i, A[i, 0] + 1];
             end
            else
             begin
                dec(A[i, 0]);
                j := A[i, A[i, 0]] + 1;
                while not used[j] do
                    inc(j);
                A[i, A[i, 0]] := j;
             end;
        B := A;
        for j := 1 to B[i, 0] do
            used[B[i, j]] := false;
        B[0, 0] := i;
        for j := 1 to N do
            if used[j] then
             begin
                inc(B[0, 0]);
                B[B[0, 0], 0] := 1;
                B[B[0, 0], 1] := j;
             end;
     end;
end;

procedure Print;
var
    i, j : longint;
begin
    writeln(N, ' ' , B[0, 0]);
    for i := 1 to B[0, 0] do
     begin
        for j := 1 to B[i, 0] do
            write(B[i, j], ' ');
        writeln;
     end;
    writeln;
end;

begin
    assign(input, 'partitions.in');
    reset(input);
    assign(output, 'partitions.out');
    rewrite(output);
    while not seekeof(input) do
     begin
        Init;
        if N <> 0 then
         begin
            Solve;
            Print;
         end;
     end;
    close(input);
    close(output);
end.
