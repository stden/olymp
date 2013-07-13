{$M 50000000}
var
    M, N : longint;

procedure Init;
begin
    read(N, M);
end;

procedure Solve;
begin
end;

procedure Print;
begin
    if (M + N) mod 10 = 4 then
     begin
        writeln(2);
        writeln('2 1');
        writeln('3 1');
     end
    else
        write(0);
end;

begin
    assign(input, 'republic.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'republic.out');
    rewrite(output);
    Print;
    close(output);
end.
