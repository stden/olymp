{$M 50000000}
const
    inf = 500000000000000000;
    MaxN = 11000;
    MaxM = 100;
    root = 0;
type
    vertex = record
        next, next_mozg : array['a'..'z'] of longint;
        p, sfl, point, points : int64;
        ch : char;
    end;
    MyArray = array[0..MaxN] of vertex;
    MyArray2 = array[1..MaxN] of longint;
    MyArray3 = array[0..MaxN] of boolean;
    MyArray4 = array[0..MaxN] of int64;
    MyArray5 = array[0..MaxN] of string[MaxM];
var
    A, B : MyArray4;
    C, D : MyArray5;
    Bor : MyArray;
    N, K : longint;
    size : longint = 0;
    ans : longint = 0;
    S : string = '';

procedure Init;
var
    i, cur : longint;
    ch : char;
begin
    fillchar(A, sizeof(A), 0);
    fillchar(B, sizeof(B), 0);
    fillchar(C, sizeof(C), 0);
    fillchar(D, sizeof(D), 0);
    fillchar(Bor, sizeof(Bor), 0);
    readln(K);
    for i := 1 to K do
     begin
        cur := root;
        repeat
            read(ch);
            if (ord(ch) >= ord('a')) and (ord(ch) <= ord('z')) then
             begin
                if Bor[cur].next[ch] = 0 then
                 begin
                    inc(size);
                    Bor[cur].next[ch] := size;
                    Bor[size].p := cur;
                    Bor[size].ch := ch;
                 end;
                cur := Bor[cur].next[ch];
             end;
        until (ord(ch) < ord('a')) or (ord(ch) > ord('z'));
        readln(Bor[cur].point);
     end;
    read(N);
end;

procedure bfs;
var
    Och : MyArray2;
    used : MyArray3;
    yk1, yk2 : longint;
    ch : char;
    cur : longint;
begin
    fillchar(Och, sizeof(Och), 0);
    fillchar(used, sizeof(used), false);
    yk1 := 1;
    Och[yk1] := root;
    used[root] := true;
    yk2 := 0;
    while yk1 > yk2 do
     begin
        inc(yk2);
        for ch := 'a' to 'z' do
            if not used[Bor[Och[yk2]].next[ch]] then
             begin
                inc(yk1);
                Och[yk1] := Bor[Och[yk2]].next[ch];
                used[Bor[Och[yk2]].next[ch]] := true;
             end;
        if Och[yk2] = root then
            Bor[root].next_mozg := Bor[root].next
        else
         begin
            cur := Bor[Och[yk2]].p;
            repeat
                cur := Bor[cur].sfl;
            until (cur = root) or (Bor[cur].next[Bor[Och[yk2]].ch] <> root);
            if Bor[cur].next[Bor[Och[yk2]].ch] <> Och[yk2] then
                Bor[Och[yk2]].sfl := Bor[cur].next[Bor[Och[yk2]].ch];
            Bor[Och[yk2]].points := Bor[Bor[Och[yk2]].sfl].points + Bor[och[yk2]].point;
            for ch := 'a' to 'z' do
                if Bor[Och[yk2]].next[ch] <> root then
                    Bor[Och[yk2]].next_mozg[ch] := Bor[Och[yk2]].next[ch]
                else
                    Bor[Och[yk2]].next_mozg[ch] := Bor[Bor[Och[yk2]].sfl].next[ch];
         end;
     end;
end;

procedure Solve;
var
    i, j : longint;
    ch : char;

begin
    bfs;
    for j := 0 to size do
        A[j] := -inf;
    for ch := 'a' to 'z' do
     begin
        A[Bor[root].next[ch]] := Bor[Bor[root].next[ch]].points;
        C[Bor[root].next[ch]] := ch;
     end;
    for i := 2 to N do
     begin
        for j := 0 to size do
            B[j] := -inf;
        for j := 0 to size do
            if A[j] <> -inf then
                for ch := 'a' to 'z' do
                    if (B[Bor[j].next_mozg[ch]] < A[j] + Bor[Bor[j].next_mozg[ch]].points) or ((B[Bor[j].next_mozg[ch]] = A[j] + Bor[Bor[j].next_mozg[ch]].points) and (C[j] < D[Bor[j].next_mozg[ch]])) then
                     begin
                        B[Bor[j].next_mozg[ch]] := A[j] + Bor[Bor[j].next_mozg[ch]].points;
                        D[Bor[j].next_mozg[ch]] := C[j] + ch;
                     end;
        A := B;
        C := D;
     end;
    for i := 0 to size do
        if (A[i] > ans) or (ans = 0) or ((A[i] = ans) and (C[i] < S)) then
         begin
            ans := A[i];
            S := C[i];
         end;
end;

procedure Print;
begin
    writeln(ans);
    writeln(S);
end;

begin
    assign(input, 'beauty.in');
    reset(input);
    assign(output, 'beauty.out');
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
