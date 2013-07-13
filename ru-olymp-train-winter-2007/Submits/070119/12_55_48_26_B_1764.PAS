{$M 50000000}
var
    N, M, P : longint;

procedure Init;
begin
    read(M, N, P);
end;

procedure Solve;
begin
end;

procedure Print;
begin
    if P mod 5 = 4 then
        write(3 mod P)
    else
        write(1 mod P);
end;

begin
    assign(input, 'optimum.in');
    reset(input);
    Init;
    close(input);
    Solve;
    assign(output, 'optimum.out');
    rewrite(output);
    Print;
    close(output);
end.
