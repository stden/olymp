{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
var i, j:integer;
    a:array [1..20, 1..21] of integer;
    r:array [1..20] of integer;
begin
  randseed:=455789533;
  for i:=1 to 19 do begin
    for j:=1 to 21 do begin
      a[i, j]:=integer (random (21))-10;
      if (j<>21) or (i>5) then a[20, j]:=a[20, j]+a[i, j];
    end;
  end;
  for i:=1 to 20 do begin j:=random (i)+1; r[i]:=r[j]; r[j]:=i end;
  writeln (20);
  for i:=1 to 20 do begin
    for j:=1 to 21 do begin
      if j<>1 then write (' ');
      write (a[r[i], j]);
    end;
    writeln;
  end;
end.