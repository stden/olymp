{$O-,Q+,R+}
const MaxN=50000;
var n, i, j, k, l, t:integer;
    a:array [1..MaxN] of integer;
    f:array [1..MaxN] of boolean;
begin
  assert (not seekeof); read (n); assert ((n>=1) and (n<=maxN));
  for i:=1 to n do begin 
    assert (not seekeof); read (a[i]); assert ((a[i]>=1) and (a[i]<=n));
    assert (not f[a[i]]); f[a[i]]:=true
  end;
  assert (seekeof);
  k:=0;
  for i:=n-1 downto 1 do if a[i]<a[i+1] then begin k:=i; break end;
  if k=0 then begin writeln ('IMPOSSIBLE'); halt end;
  l:=n; for j:=k+1 to n do if a[j]<a[k] then begin l:=j-1; break end;
  assert (l>k);
  t:=a[k]; a[k]:=a[l]; a[l]:=t;
  for i:=k+1 to (n+k) shr 1 do begin t:=a[i]; a[i]:=a[n+k+1-i]; a[n+k+1-i]:=t end;
  for i:=1 to n do write (a[i], ' ');
end.