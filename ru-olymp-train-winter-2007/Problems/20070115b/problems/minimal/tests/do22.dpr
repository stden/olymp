{$I trans.inc}
uses dorand;
type integer=longint;
const N=4000;
      Mx=0;
var i, j, cnt, t:integer;
    a:array [1..N] of integer;
    g:array [1..N, 1..N] of boolean;
begin
  regint (95);
  for i:=1 to N do begin t:=random (i)+1; a[i]:=a[t]; a[t]:=i end;
  for i:=1 to N do g[i, a[i]]:=true;
  for i:=1 to Mx do g[lr (1, N), lr (1, N)]:=true;
  writeln (N, ' ', N);
  for i:=1 to N do begin
    cnt:=0; for j:=1 to N do if g[i, j] then inc (cnt);
    write (cnt); for j:=1 to N do if g[i, j] then write (' ', j);
    writeln;
  end;
  for i:=1 to N-1 do write (a[i], ' '); writeln (a[N]);
end.