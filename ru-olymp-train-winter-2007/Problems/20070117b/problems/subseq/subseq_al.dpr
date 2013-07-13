{$O-,Q+,R+}
const MaxN=239017;

var a:array [0..MaxN+1] of double;
    f:array [0..MaxN] of integer;
    p:array [1..MaxN] of integer;
    i, j, l, x, r, n:integer;

begin
  read (n); assert ((n>=1) and (n<=MaxN));
  for i:=1 to n do begin
    read (a[i]);
    assert (abs (a[i])<=maxlongint-1);
  end;
  a[0]:=-1e10; a[n+1]:=1e10;
  f[0]:=0; for i:=1 to n do f[i]:=n+1;
  for i:=n downto 1 do begin
    l:=0; r:=n+1;
    while r-l>1 do begin
      x:=(l+r) shr 1;
      if a[i]<a[f[x]] then r:=x else l:=x;
    end;
    f[r]:=i;
    p[i]:=f[r-1];
  end;
  for j:=n downto 1 do
    if f[j]<=n then begin
      writeln (j);
      l:=f[j];
      while l>0 do begin
        write (l, ' '); l:=p[l];
      end;
      halt;
    end;
  runerror (239);
end.