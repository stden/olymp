uses
  SysUtils;

var
  i: integer;
  s: string;

begin
  assign(input, 'tests.lst');
  reset(input);
  i := 1;
  while not SeekEOF do
  begin
    assign(output, inttostr(i div 10) + inttostr(i mod 10));
    rewrite(output);
    readln(s);
    while length(s) = 0 do begin
      readln(s);
    end;
    writeln(s);
    readln(s);
    while length(s) = 0 do begin
      readln(s);
    end;
    writeln(s);
    close(output);
    inc(i);
  end;
  close(input);
end.
