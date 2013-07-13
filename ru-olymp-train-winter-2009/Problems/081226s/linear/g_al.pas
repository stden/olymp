{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
uses testjury;
const MaxN=20;
      MaxNum=100;
      eps=1e-10;
var a, b:array [1..MaxN, 1..MaxN+1] of extended;
    i, j, k, l, n:integer;
    c, cr, r, rr:array [1..MaxN] of integer;
    f:array [1..MaxN] of boolean;
    x:array [1..MaxN] of extended;
    mj, mk:integer;
    mx, sum:extended;
begin
  ci ('gauss.in'); ao ('gauss.out');
  n:=getint;
  test ((n>=1) and (n<=MaxN)); reql (Reject);
  for i:=1 to n do begin
    for j:=1 to n+1 do begin
      noeoln; a[i, j]:=getint; test (abs (a[i, j])<=MaxNum) end;
    reql (Reject);
  end;
  reqeof;
  b:=a;
  for i:=1 to n do begin c[i]:=i; cr[i]:=i; r[i]:=i; rr[i]:=i; end;
  for i:=1 to n do begin
    mk:=-1;
    for k:=1 to n do if not f[k] then begin
      mx:=-1; mj:=-1;
      for j:=1 to n do if abs (a[k, j])>mx then begin mx:=abs (a[k, j]);
                                                    mj:=j end;
      if mx>eps then begin mk:=k; break end;
      if abs (a[k, n+1])>eps then begin
        writeln ('impossible'); exit end;
    end;
    if mk=-1 then
      begin writeln ('infinity'); halt end;
    r[rr[mk]]:=r[i]; rr[r[i]]:=mk;
    r[i]:=mk; rr[mk]:=i; f[mk]:=true;
    c[cr[mj]]:=c[i]; cr[c[i]]:=cr[mj];
    c[i]:=mj; cr[mj]:=i;
    for k:=1 to n do
      if rr[k]>i then begin
        for l:=1 to n do
          if cr[l]>i then a[k, l]:=a[k, l]-a[k, mj]*a[mk, l]/a[mk, mj];
        a[k, n+1]:=a[k, n+1]-a[k, mj]*a[mk, n+1]/a[mk, mj];
        a[k, mj]:=0;
      end;
  end;
  for i:=1 to n do test ((r[i]=i) and (rr[i]=i) and f[i] and (cr[c[i]]=i));
  for i:=n downto 1 do begin
    sum:=a[i, n+1];
    for j:=n downto i+1 do sum:=sum-a[i, c[j]]*x[c[j]];
    x[c[i]]:=sum/a[i, c[i]];
  end;
  writeln ('single');
  write (x[1]:0:6); for i:=2 to n do write (' ', x[i]:0:6);
  writeln;
  for i:=1 to n do begin
    sum:=0;
    for j:=1 to n do sum:=sum+a[i, j]*x[j];
    sum:=sum-a[i, n+1];
    if abs (sum)>eps then begin
      writeln ('Невязка: ', sum);
      quit (_Fail, '*** невязка ***');
    end;
  end;
end.