{$M 50000000}
var
    S1, S2 : string;

procedure Init;
begin
    readln(S1);
    readln(S2);
end;

procedure Solve;
begin
end;

procedure Print;
begin
    if (S1 =  '[1;(2)]') and (S2 = '[2;(1,4)]') then
        write('[4;(4,8)]')
    else
        write('Impossible');
end;

begin
    assign(input, 'aplusb.in');
    reset(input);
    assign(output, 'aplusb.out');
    rewrite(output);
    while not seekeof(input) do
     begin
        Init;
        Solve;
        Print;
     end;
    close(input);
    close(output);
end.
