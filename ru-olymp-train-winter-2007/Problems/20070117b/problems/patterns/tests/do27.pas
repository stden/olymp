uses dorand;
const L=9998;
var s:array [1..L] of char;
    i:integer;
begin
  regint (27);
  for i:=1 to L do s[i]:=chr (random (26)+97);
  write ('*'); for i:=1 to L-1 do write (s[i]); write ('*'); write (s[L]); writeln;
  for i:=1 to L do write (s[i]); writeln;
end.
