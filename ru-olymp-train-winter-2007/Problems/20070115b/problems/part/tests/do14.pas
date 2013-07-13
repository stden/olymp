uses dorand;
const MaxN=100;
      MaxK=1000;
var a:array [0..MaxN, 0..MaxN] of longint;
    ni, ki:array [1..MaxK] of longint;
    o:array [1..MaxK] of integer;
    i, j, k, n, l, s, t:integer;
begin
  regint (14);
  for i:=1 to MaxN do a[0, i]:=1;
  for i:=1 to MaxN do begin
    for j:=1 to i do
      for k:=1 to j do
        inc (a[i, j], a[i-k, k]);
    for j:=i+1 to MaxN do a[i, j]:=a[i, i];
  end;
  for n:=22 to 100 do begin
    inc (s); ni[s]:=n; ki[s]:=0;
    inc (s); ni[s]:=n; ki[s]:=1;
    inc (s); ni[s]:=n; ki[s]:=a[n, n]-1;
    inc (s); ni[s]:=n; ki[s]:=a[n, n]-2;
    inc (s); ni[s]:=n; ki[s]:=lr (0, a[n, n]-1);
    inc (s); ni[s]:=n; ki[s]:=a[n-1, n-1]-2;
    inc (s); ni[s]:=n; ki[s]:=a[n-3, n-3]-3;
    inc (s); ni[s]:=n; ki[s]:=239;
    inc (s); ni[s]:=n; ki[s]:=17;
    inc (s); ni[s]:=n; ki[s]:=666;
    if a[n, n]>4063 then begin inc (s); ni[s]:=n; ki[s]:=4063 end;
    if a[n, n]>6666 then begin inc (s); ni[s]:=n; ki[s]:=6666 end;
  end;
  for i:=1 to s do begin t:=random (i)+1; o[i]:=o[t]; o[t]:=i end;
  for i:=1 to s do writeln (ni[o[i]], ' ', ki[o[i]]);
  writeln ('0 0');
end.