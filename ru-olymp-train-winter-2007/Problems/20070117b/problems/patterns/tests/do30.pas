uses dorand;
var i, j:integer;
    s:string;
begin
  regint (30);
  write ('*'); for j:=1 to 9998 do write ('?'); writeln ('*');
  for i:=1 to 10000 do write (chr (random (26)+97)); writeln;
end.