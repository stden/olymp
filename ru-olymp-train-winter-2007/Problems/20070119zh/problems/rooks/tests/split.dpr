{$apptype console}
uses
    SysUtils;

var
    i : integer;
    s : string;

begin
    assign(input, 'tests.lst');
    reset(input);
    i := 1;
    while not SeekEOF do begin
        readln(s);
        s := trim(s);
        assign(output, inttostr(i div 10) + inttostr(i mod 10));
        rewrite(output);
        writeln(s);
        close(output);
        inc(i);
    end;
    close(input);
end.
