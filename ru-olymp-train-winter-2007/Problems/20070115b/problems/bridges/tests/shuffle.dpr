const
	maxn = 20000;
	maxm = 200000;
var
    a, b, p, q: array [1..maxm] of longint;
    u: array [1..maxm] of boolean;
    i, j, n, m: longint;
begin
    read(n, m);
    for i := 1 to m do
        read(a[i], b[i]);

    randseed := n + m * a[1] + b[1] * 1023;


    for i := 1 to n do
    begin
        repeat
            j := random(n) + 1;
        until not u[j];
        p[i] := j;
        u[j] := true;
    end;

    fillchar(u, sizeof(u), 0);
    for i := 1 to m do
    begin
        repeat
            j := random(m) + 1;
        until not u[j];
        q[i] := j;
        u[j] := true;
    end;

    writeln(n, ' ', m);
    for i := 1 to m do
    begin
        writeln(p[a[q[i]]], ' ', p[b[q[i]]]);
    end;
end.