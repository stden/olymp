uses dorand;
const L=10000;
var s:array [1..L] of char;
    i, t:integer;
begin
  regint (35);
  t:=longrand (2, L-1);
  for i:=1 to L do s[i]:=chr (random (26)+97);
  for i:=1 to L do if i<>t then write (s[i]); writeln;
  for i:=1 to L do write (s[i]); writeln;
end.
