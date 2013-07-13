{$O+,S-,R-,Q-}
type
    int = longint;
    list = ^node;
    node = record
        inf, price: int;
        next: list;
    end;
const
    NMAX = 100;
    KMAX = 8;
    MMAX = 1 shl KMAX;
    infinity = 1000000000;
var
    g: array [1..NMAX] of list;
    c, p: array [1..NMAX, 1..KMAX] of int;
    precalc, dist: array [1..NMAX, 0..MMAX] of int;
    used: array [1..NMAX, 0..MMAX] of boolean;
    pp: array [0..MMAX] of int;
    n, m, k, v: int;

function min(a, b: int): int;
begin
    if a < b then min := a
        else min := b;
end;

procedure add(var g: list; y, z: int);
var
    t: list;
begin
    new(t);
    t^.inf := y;
    t^.price := z;
    t^.next := g;
    g := t;
end;

procedure calc(v, mask: int);
var
    i: int;
begin
    precalc[v, mask] := infinity;
    for i := 0 to k - 1 do
        if mask and (1 shl i) <> 0 then begin
            if c[v, i + 1] = 0 then exit;
            precalc[v, mask] := min(precalc[v, mask],
                                    precalc[v, mask xor (1 shl i)] + ((100 - pp[mask xor (1 shl i)]) * c[v, i + 1]) div 100)
        end;
    if mask = 0 then precalc[v, mask] := 0;
end;

var
    best, i, j, x, y, z, f: int;
    t: list;

begin
    assign(input, 'armor.in');
    reset(input);
    assign(output, 'armor.out');
    rewrite(output);

    read(n, m, k, v);
    for i := 1 to n do
        for j := 1 to k do
            read(c[i, j], p[i, j]);
    for i := 1 to m do begin
        read(x, y, z);
        add(g[x], y, z);
        add(g[y], x, z);
    end;

    for i := 1 to n do begin
        pp[0] := 0;
        for j := 1 to (1 shl k) - 1 do
            for f := 1 to k do
                if j and (1 shl (f - 1)) <>  0 then pp[j] := pp[j xor (1 shl (f - 1))] + p[i, f];
        for j := 0 to (1 shl k) - 1 do
            calc(i, j);
    end;

    for i := 1 to n do
        for j := 0 to (1 shl k) - 1 do
            dist[i, j] := infinity;
    dist[v, 0] := 0;
    fillchar(used, sizeof(used), 0);

    while true do begin
        x := 0;
        y := 0;
        best := infinity;
        for i := 1 to n do
            for j := 0 to (1 shl k) - 1 do
                if (not used[i, j]) and (dist[i, j] < best) then begin
                    best := dist[i, j];
                    x := i;
                    y := j;
                end;
        if x = 0 then break;
        used[x, y] := true;

        for j := 0 to (1 shl k) - 1 do
            dist[x, y or j] := min(dist[x, y or j], dist[x, y] + precalc[x, j]);
        t := g[x];
        while t <> nil do begin
            dist[t^.inf, y] := min(dist[t^.inf, y], dist[x, y] + t^.price);
            t := t^.next;
        end;
    end;

    if dist[v, (1 shl k) - 1] = infinity then
        writeln(-1)
    else
        writeln(dist[v, (1 shl k) - 1]);
    close (output);
end.