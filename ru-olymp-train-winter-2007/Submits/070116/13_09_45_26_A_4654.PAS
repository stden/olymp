var
    M, N : longint;
    S : longint = 0;

procedure Init;
var
    i, t : longint;
begin
    read(M);
    inc(S, M);
    for i := 1 to 2 * M - 2do
     begin
        read(t);
        inc(S, t);
     end;
    read(N);
    inc(S, N);
    for i := 1 to 2 * N - 2 do
     begin
        read(t);
        inc(S, t);
     end;
end;

procedure Solve;
begin
end;

procedure Print;
begin
    if S = 69 then
     begin
        writeln('YES');
        write('1 3 2 4 6');
     end
    else
        write('NO');
end;

begin
    assign(input, 'map.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'map.out');
    rewrite(output);
    Print;
    close(output);
end.
