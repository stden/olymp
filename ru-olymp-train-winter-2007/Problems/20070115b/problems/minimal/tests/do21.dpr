{$I trans.inc}
type integer=longint;
const MaxN=4000;
      MaxK=500000;
var i, j, t, N:integer;
    a, b:array [1..MaxN] of integer;
begin
  N:=trunc (sqrt (MaxK));
  for i:=1 to N do begin t:=random (i)+1; a[i]:=a[t]; a[t]:=i end;
  writeln (N, ' ', N);
  for i:=1 to N do begin
    for j:=1 to N do begin t:=random (j)+1; b[j]:=b[t]; b[t]:=j end;
    write (N); for j:=1 to N do write (' ', b[j]);
    writeln;
  end;
  for i:=1 to N-1 do write (a[i], ' '); writeln (a[N]);
end.