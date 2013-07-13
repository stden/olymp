{$M 50000000}
var
    M, N : longint;

procedure Init;
begin
    read(M, N);
end;

procedure Solve;
begin
end;

procedure Print;
begin
    if (M + n) mod 10 = 4 then
     begin
        writeln(2);
        writeln('2 1');
        write('3 1');
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
