uses dorand;
const L=10000;
var s:array [1..L] of char;
    i:integer;
begin
  regint (31);
  for i:=1 to L do s[i]:=chr (random (26)+97);
  for i:=1 to L do write (s[i]); writeln;
  for i:=1 to L-1 do write (s[i]); writeln;
end.
