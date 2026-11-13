uses dorand;
const N=50000;
type integer=longint;
var a:array [1..N] of integer;
    i, t:integer;
begin
  regint (461);
  writeln (n);
  for i:=1 to n do begin t:=random (i)+1; a[i]:=a[t]; a[t]:=i end;
  for i:=1 to n do writeln (a[i]);
end.