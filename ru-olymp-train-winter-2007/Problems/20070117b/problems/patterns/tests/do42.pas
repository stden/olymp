uses dorand;
const L=4999;
var s:array [1..L] of char;
    i, t:integer;
begin
  regint (42);
  for i:=1 to L do s[i]:=chr (random (26)+97);
  write ('*'); for i:=1 to L do write (s[i], '*'); writeln;
  for i:=1 to L do write (s[i]); writeln;
end.
