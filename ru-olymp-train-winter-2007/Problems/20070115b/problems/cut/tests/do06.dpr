var
    i, n, m: longint;
begin
    randseed := 1234;

    n := 100;
    m := 99;

    writeln(n, ' ', m);

    for i := 1 to m do begin
        writeln(i, ' ', i + 1, ' ', random(10000000) + 1);
    end;
end.