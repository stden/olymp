uses dorand;
const MaxN=100;
      MaxK=1000;
var a:array [0..MaxN, 0..MaxN] of longint;
    ni, ki:array [1..MaxK] of integer;
    o:array [1..MaxK] of integer;
    i, j, k, n, l, s, t:integer;
begin
  regint (9);
  for i:=1 to MaxN do a[0, i]:=1;
  for i:=1 to MaxN do begin
    for j:=1 to i do
      for k:=1 to j do
        inc (a[i, j], a[i-k, k]);
    for j:=i+1 to MaxN do a[i, j]:=a[i, i];
  end;
  for n:=21 to 100 do begin
    inc (l, a[n, n]);
    if l>MaxK then break;
    for j:=0 to a[n, n]-1 do begin inc (s); ni[s]:=n; ki[s]:=j end;
  end;
  for i:=1 to s do begin t:=random (i)+1; o[i]:=o[t]; o[t]:=i end;
  for i:=1 to s do writeln (ni[o[i]], ' ', ki[o[i]]);
  writeln ('0 0');
end.