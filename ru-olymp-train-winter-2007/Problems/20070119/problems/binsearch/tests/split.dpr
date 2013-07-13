uses SysUtils;
var cnt, a, b:integer;
begin
  reset (input, 'tests.lst');
  cnt:=0;
  repeat
    inc (cnt);
    rewrite (output, format ('%.2d', [cnt]));
    readln (a);
    writeln (a);
    close (output);
  until eof;
end.