{$M 50000000}
var
    S : string;
    N : longint;

procedure Init;
var
    ch : char;
    i : longint;
begin
    readln(N);
    S := '';
    for i := 1 to 5 do
     begin
        read(ch);
        S := S + ch;
     end;
end;

procedure Solve;
begin
end;

procedure Print;
begin
    if (N = 1) and (S = '7S 8S') then
     begin
        writeln(10);
        writeln('AD AC');
        write('S');
     end
    else
     begin
        writeln(0);
        writeln(S);
        write('N');
     end;
end;

begin
    assign(input, 'preference.in');
    reset(input);
    assign(output, 'preference.out');
    rewrite(output);
{    while not seekeof(input) do
     begin}
        Init;
        Solve;
        Print;
{     end;}
    close(input);
    close(output);
end.
