const N=20;
label en;
var e:array [1..N+1, 1..N] of integer;
    i, j:integer;
begin
  for i:=1 to N do e[i, i]:=1;
  repeat
    for j:=1 to N do e[N+1, j]:=e[1, j]+e[2, j];
    for j:=1 to N do if e[N+1, j]>100 then goto en;
    for j:=1 to N do e[j]:=e[j+1];
  until false;
  en:
  writeln (N);
  for i:=1 to N do begin
    for j:=1 to N do write (e[i, j], ' ');
    writeln (ord (i=1));
  end;
end.