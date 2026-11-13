{$N+,O+,Q-,R-,S-}
{$MAXSTACKSIZE $10000000}
{$APPTYPE CONSOLE}
uses
    math;
type
    int = longint;
    list = ^node;
    node = record
        inf, price: int;
        next: list;
    end;
const
    NMAX = 51;
    KMAX = 7;
    VMAX = 120000;
    infinity = 1000000000;
var
    find: array [1..NMAX, 0..6500] of int;
    g: array [1..VMAX] of list;
    st: array [0..KMAX] of int;
    dist, ans: array [0..VMAX] of int;
    tree: array [1..4 * VMAX] of int;
    used: array [1..VMAX] of boolean;

    gg: array [1..NMAX, 1..NMAX] of int;
    a, p: array [1..NMAX, 1..KMAX] of int;
    n, m, k, v, v1, v2, now: int;

procedure add(v1, v2, price: int);
var
    t: list;
begin
    new(t);
    t^.inf := v2;
    t^.price := price;
    t^.next := g[v1];
    g[v1] := t;
end;

procedure make(v, mask: int);
var
    num: array [1..NMAX] of int;
    i, j, tmp, pp: int;
    exist: boolean;
begin
    tmp := mask;
    exist := false;
    for i := k downto 1 do begin
        num[i] := tmp mod 3;
        if num[i] = 1 then exist := true;
        tmp := tmp div 3;
    end;

    if exist then begin
        tmp := 0;
        for i := 1 to k do begin
            tmp := tmp * 3 + num[i];
            if num[i] = 1 then inc(tmp);
        end;
        add(find[v, mask], find[v, tmp], 0);
    end
    else
        for i := 1 to n do
            if gg[v, i] > 0 then
                add(find[v, mask], find[i, mask], gg[v, i]);

    pp := 0;
    for i := 1 to k do
        if num[i] = 1 then inc(pp, p[v, i]);
    for i := 1 to k do
        if num[i] = 0 then begin
            tmp := 0;
            for j := 1 to k do begin
                tmp := tmp * 3 + num[j];
                if i = j then inc(tmp);
            end;
            add(find[v, mask], find[v, tmp], (a[v, i] * (100 - pp)) div 100);
        end;
end;

procedure update_tree(v, l, r, p, zn: int);
begin
    if (l > p) or (r < p) then exit;
    if l = r then begin
        if zn < infinity then
            tree[v] := p
        else
            tree[v] := 0;
        exit;
    end;
    update_tree(2 * v, l, (l + r) shr 1, p, zn);
    update_tree(2 * v + 1, (l + r + 2) shr 1, r, p, zn);
    if dist[tree[2 * v]] < dist[tree[2 * v + 1]] then
        tree[v] := tree[2 * v]
    else
        tree[v] := tree[2 * v + 1];
    if dist[tree[v]] = infinity then tree[v] := 0;
end;

procedure update(v, zn: int);
begin
    dist[v] := zn;
    update_tree(1, 1, n, v, zn);
end;

procedure find_answer;
var
    i: int;
    t: list;
begin
    n := now;
    for i := 0 to n do
        dist[i] := infinity;
    fillchar(tree, sizeof(tree), 0);
    fillchar(used, sizeof(used), 0);
    ans[v2] := infinity;
    update(v1, 0);
    while true do begin
        v := tree[1];
        if v = 0 then break;
        used[v] := true;
        ans[v] := dist[v];
        update(v, infinity);
        t := g[v];
        while t <> nil do begin
            if (dist[t^.inf] > ans[v] + t^.price) and (not used[t^.inf]) then
                update(t^.inf, ans[v] + t^.price);
            t := t^.next;
        end;
    end;
    if ans[v2] = infinity then
        writeln(-1)
    else
        writeln(ans[v2]);
end;

var
    i, j, x, y, z: int;

begin
    assign(input, 'armor.in');
    reset(input);
    assign(output, 'armor.out');
    rewrite(output);

    read(n, m, k, v);
    for i := 1 to n do
        for j := 1 to k do
            read(a[i, j], p[i, j]);
    fillchar(gg, sizeof(gg), 0);
    for i := 1 to m do begin
        read(x, y, z);
        if gg[x, y] > 0 then gg[x, y] := min(gg[x, y], z)
            else gg[x, y] := z;
        if gg[y, x] > 0 then gg[y, x] := min(gg[y, x], z)
            else gg[y, x] := z;
    end;

    st[0] := 1;
    for i := 1 to k do
        st[i] := st[i - 1] * 3;
    now := 0;
    for i := 1 to n do
        for j := 0 to st[k] - 1 do begin
            inc(now);
            find[i, j] := now;
        end;

    v1 := find[v, 0];
    v2 := find[v, st[k] - 1];
    for i := 1 to n do
        for j := 0 to st[k] - 1 do
            make(i, j);

    find_answer;
end.