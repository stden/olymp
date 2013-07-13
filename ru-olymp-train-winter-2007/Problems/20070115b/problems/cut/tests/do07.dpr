var
    i, n, m: longint;
begin
    randseed := 1234;

    n := 100;
    m := 99 + 98;

    writeln(n, ' ', m);

    for i := 1 to 99 do begin
        writeln(i, ' ', i + 1, ' ', random(10000000) + 1);
    end;
    for i := 1 to 98 do begin
        writeln(i, ' ', i + 2, ' ', random(10000000) + 1);
    end;
end.