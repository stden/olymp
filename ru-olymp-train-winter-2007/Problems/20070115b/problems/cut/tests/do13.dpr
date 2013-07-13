{$R+,Q+}
const
    maxn = 800;
    maxm = 10000;
var
    i, j, k, l, m, n, s, t: longint;
    a: array [1..maxn, 1..maxn] of longint;
    ln: longint;
    pv: array [1..maxn] of longint;
    pe: array [1..maxm] of longint;
    e: array [1..maxm] of record a, b, c: longint; end;
    p: longint;
begin
    randseed := 239047;
    
    n := 100;

    k := 10;

    p := 40;

    ln := (n - 2) div k;
    n := ln * k + 2;
    for i := 1 to k do
    begin
        a[1][i + 1] := 1;
        a[n - i][n] := 1;
    end;

    for i := 1 to ln - 1 do
    begin
        for j := 1 to k do
            for l := 1 to k do
            begin
                s := (i - 1) * k + j + 1;
                t := i * k + l + 1;
                if random(100) < p then
                    a[s][t] := 1;
            end;
    end;

    

    for i := 1 to n do
        for j := 1 to n do begin
            if a[i][j] <> 0 then
                a[i][j] := random(1000) + 1;
        end;



    m := 0;
    for i := 1 to n do
        for j := i + 1 to n do
        begin
            if a[i][j] <> 0 then
            begin
                inc(m);
                e[m].a := i;
                e[m].b := j;
                e[m].c := a[i][j];
            end;
        end;

{    for i := 1 to n do
        pv[i] := i;
    for i := 1 to m do
        pe[i] := i;}

    for i := 2 to n - 1 do
    begin
        repeat
            j := random(n - 2) + 2;
        until pv[j] = 0;
        pv[j] := i;
    end;
    pv[1] := 1;
    pv[n] := n;

    for i := 1 to m do
    begin
        repeat
            j := random(m) + 1;
        until pe[j] = 0;
        pe[j] := i;
    end;

    writeln(n, ' ', m);
    for i := 1 to m do
    begin
        if random(2) = 0 then
            writeln(pv[e[pe[i]].a], ' ', pv[e[pe[i]].b], ' ', e[pe[i]].c)
        else
            writeln(pv[e[pe[i]].b], ' ', pv[e[pe[i]].a], ' ', e[pe[i]].c);
    end;
end.