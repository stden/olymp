uses dorand;
type integer=longint;
var f1, f2:array [1..4000] of boolean;
    a, b:array [1..4000] of integer;
    g:array [1..4000, 1..4000] of boolean;
    m, n, s1, s2, i, j, u, v, k, cnt:integer;

begin
  regint (13);
  m:=lr (1, 4000);
  n:=lr (1, 4000);
  writeln (m, ' ', n);
  s1:=lr (1, min (n, m));
  s2:=lr (1, min (min (n, n-s1), m-s1));
  for i:=1 to s1 do begin
    repeat
      u:=lr (1, m); v:=lr (1, n);
    until not f1[u] and not f2[v] and (a[u]=0) and (b[v]=0);
    f1[u]:=true;
    a[u]:=v;
    b[v]:=u;
    g[u, v]:=true;
  end;
  for i:=1 to s2 do begin
    repeat
      u:=lr (1, m); v:=lr (1, n);
    until not f1[u] and not f2[v] and (a[u]=0) and (b[v]=0);
    f2[v]:=true;
    a[u]:=v;
    b[v]:=u;
    g[u, v]:=true;
  end;
  k:=lr (1, 500000);
  for i:=1 to k do begin
    repeat
      u:=lr (1, m);
      v:=lr (1, n);
    until f1[u] or f2[v];
    g[u, v]:=true;
  end;
  for u:=1 to m do begin
    cnt:=0;
    for v:=1 to n do if g[u, v] then inc (cnt);
    write (cnt);
    for v:=1 to n do if g[u, v] then write (' ', v);
    writeln;
  end;
  for u:=1 to m-1 do write (a[u], ' '); writeln (a[m]);
end.