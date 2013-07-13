uses dorand;
type integer=longint;
const N=50;

var f:array [1..N] of boolean;
    a:array [1..N] of integer;
    i, p, s, t, max:integer;

begin
  regint (23);
  p:=lr (1, N);
  for i:=n downto p do begin
    repeat
      s:=lr (1, N);
    until not f[s];
    f[s]:=true;
  end;
  max:=maxint;
  for i:=1 to n do if f[i] then max:=i;
  p:=n; for i:=1 to n do if f[i] then begin a[p]:=i; dec (p) end;
  if p>1 then begin
    repeat
      s:=lr (1, max-1);
    until not f[s];
    a[p]:=s; f[s]:=true;
  end;
  p:=0; for i:=1 to n do if not f[i] then begin inc (p); a[p]:=i; end;
  for i:=1 to p do begin t:=random (i)+1; s:=a[t]; a[t]:=a[i]; a[i]:=s end;
  writeln (n);
  for i:=1 to n do begin
    write (a[i]); if i<n then write (' ') else writeln;
  end;
end.