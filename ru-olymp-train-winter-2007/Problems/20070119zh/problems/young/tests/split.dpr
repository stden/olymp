var cnt:integer;
    s:string;
begin
  reset (input, 'tests.lst');
  cnt:=0;
  repeat
    inc (cnt); str (cnt, s); while length (s)<2 do s:='0'+s;
    rewrite (output, s); readln (s); writeln (s); close (output);
  until seekeof;
end.