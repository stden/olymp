{$I trans.inc}
uses testlib;
type integer=longint;

const MaxMN=4000;
      MaxK=500000;

var a, b:array [0..MaxMN] of integer;
    g:array [1..MaxMN, 1..MaxMN] of boolean;
    f1, f2:array [1..MaxMN] of boolean;
    m, n, size:integer;

procedure answer (var f:instream);
var i, j, p, t, s1, s2:integer;
begin
  if f.getint<>size then f.quit (_wa, 'Must be equal');
  s1:=f.getint;
  if (s1<0) or (s1>size) then f.quit (_wa, 'Invalid s1');
  p:=0;
  for i:=1 to s1 do begin
    t:=f.getint;
    if (t<=p) or (t>m) then f.quit (_wa, 'not ascending or invalid spy');
    f1[t]:=true; p:=t;
  end;
  s2:=f.getint;
  if (s2<>size-s1) then f.quit (_wa, 'Invalid s2');
  p:=0;
  for i:=1 to s2 do begin
    t:=f.getint;
    if (t<=p) or (t>n) then f.quit (_wa, 'not ascending or invalid operator');
    f2[t]:=true; p:=t;
  end;
  for i:=1 to m do
    for j:=1 to n do
      if g[i, j] and not f1[i] and not f2[j] then
        f.quit (_wa, 'Not controlling');
end;

var i, j, k, t, s1, p:integer;


begin
  m:=inf.getint; n:=inf.getint; size:=0;
  for i:=1 to m do begin
    k:=inf.getint;
    for j:=1 to k do begin
      t:=inf.getint;
      g[i, t]:=true;
    end;
  end;
  for i:=1 to m do begin
    a[i]:=inf.getint;
    if a[i]>0 then begin
      b[a[i]]:=i; inc (size);
    end;
  end;
  answer (ans);
  answer (ouf);
  quit (_ok, '');
end.