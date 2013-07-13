uses dorand;
const MaxN=100;
      MaxK=1000;
var a:array [0..MaxN, 0..MaxN] of longint;
    ni, ki:array [1..MaxK] of integer;
    o:array [1..MaxK] of integer;
    i, j, k, n, l, s, t:integer;
    m:longint;
begin
  regint (10);
  for i:=1 to MaxN do a[0, i]:=1;
  for i:=1 to MaxN do begin
    for j:=1 to i do
      for k:=1 to j do
        inc (a[i, j], a[i-k, k]);
    for j:=i+1 to MaxN do a[i, j]:=a[i, i];
  end;
  repeat
    n:=lr (22, 100);
    m:=lr (0, a[n, n]-1);
    writeln (n, ' ', m);
    inc (l);
  until l=MaxK;
  writeln ('0 0');
end.