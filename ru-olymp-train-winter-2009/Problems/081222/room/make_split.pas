type
    int = longint;
const
    NMAX = 52;
var
    i: int;
    s, num: string;

begin
    assign(input, 'tests.txt');
    reset(input);

    for i := 1 to NMAX do begin
        str(i, s);
        if length(s) = 1 then s := '0' + s;
        assign(output, s);
        rewrite(output);
        readln(num);
        writeln(num);
        close(output);
    end;
    close(input);
end.