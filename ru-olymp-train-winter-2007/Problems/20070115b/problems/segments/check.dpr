{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
program macro;
uses testlib;
var an, ou, ox, cnt, i, n:longint;
    a:array [1..50000] of record x, y:longint end;
    oxx:extended;
begin
  n:=inf.readlongint;
  for i:=1 to n do begin
    a[i].x:=inf.readlongint;
    a[i].y:=inf.readlongint;
  end;
  an:=ans.readlongint;
  ou:=ouf.readlongint;
  oxx:=ouf.readreal;
  try
    ox:=round (oxx);
  except
    quit (_WA, 'bad number');
    ox:=1111111111;
  end;
  cnt:=0;
  for i:=1 to n do
    if ((a[i].x<=ox) and (ox<=a[i].y)) or
       ((a[i].y<=ox) and (ox<=a[i].x)) then inc (cnt);
  if cnt<>ou then quit (_WA, '');
  if ou>an then quit (_Fail, '');
  if ou<an then quit (_WA, '');
  quit (_OK, '');
end.