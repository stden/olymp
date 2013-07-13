var
    used: array[1..20000] of boolean;
    i, j, n, m, l, r: integer;
    all: boolean;
begin
    assign(input, 'checkpaint.in');
    assign(output, 'checkpaint.out');
    reset(input);
    rewrite(output);
    read(m, n);
    for i := 1 to m do
        used[i] := false;
    for i := 1 to n do begin
        read(l, r);
        for j := l to r do
            used[j] := true;
    end;
    all := true;
    for i := 1 to m do
        if not used[i] then
            all := false;
    if all then
        writeln('YES')
    else
        writeln('NO');
end.
