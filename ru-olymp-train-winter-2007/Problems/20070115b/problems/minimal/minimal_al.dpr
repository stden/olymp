{$Q+,R+}
const MaxMN=4000;
      MaxK=500000;

var a, b:array [0..MaxMN] of integer;
    g:array [1..MaxMN, 1..MaxMN] of boolean;
    f:array [0..MaxMN] of boolean;
    m, n:integer;

procedure poisk (v:integer);
var u, i:integer;
begin
  u:=b[v]; assert (u>0);
  f[v]:=true;
  for i:=1 to n do
    if g[u, i] and not f[i] then 
      poisk (i);
end;

var i, j, k, t, size, s1, p, sumk:integer;


begin
  assert (not seekeoln); read (m); assert ((m>=1) and (m<=MaxMN));
  assert (not seekeoln); read (n); assert ((n>=1) and (n<=MaxMN));
  assert (seekeoln); readln;
  sumk:=0; size:=0; s1:=0;
  for i:=1 to m do begin
    p:=0;
    assert (not seekeoln);
    read (k); assert ((k>=0) and (k<=n)); inc (sumk, k); assert (sumk<=MaxK);
    for j:=1 to k do begin
      assert (not seekeoln);
      read (t); assert ((t>0) and (t<=n)); p:=t;
      g[i, t]:=true;
    end;
    assert (seekeoln); readln;
  end;
  for i:=1 to m do begin
    assert (not seekeoln); read (a[i]); assert ((a[i]>=0) and (a[i]<=n));
    if a[i]>0 then begin
      assert (b[a[i]]=0); b[a[i]]:=i; inc (size); assert (g[i, a[i]]);
    end;
  end;
  assert (seekeof);
  for i:=1 to m do
    if a[i]=0 then begin
      b[0]:=i;
      poisk (0)
    end;
  for i:=1 to n do
    if (b[i]>0) and not f[i] then inc (s1);
  writeln (size);
  write (s1);
  for i:=1 to m do
    if (a[i]>0) and not f[a[i]] then write (' ', i);
  writeln;
  write (size-s1);
  for i:=1 to n do
    if f[i] then write (' ', i);
end.