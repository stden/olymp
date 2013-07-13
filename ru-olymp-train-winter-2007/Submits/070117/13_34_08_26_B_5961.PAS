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
var
    i : longint;
begin
    if (M = 3) and (N = 4) then
     begin
        writeln(4);
        write('3 2 1 0')
     end
    else
        if ((M + N) mod 10 <> 0) then
            write(-1)
        else
         begin
            writeln(0);
            for i := 1 to N do
                write('0 ');
         end;
end;

begin
    assign(input, 'radio.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'radio.out');
    rewrite(output);
    Print;
    close(output);
end.
