{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
const MaxN=20;
var i, j, t:integer;
    c:array [1..MaxN] of integer;
begin
  randseed:=45873;
  writeln (MaxN);
  for i:=1 to MaxN do begin t:=random (i)+1; c[i]:=c[t]; c[t]:=i end;
  for i:=1 to MaxN do begin
    for j:=1 to MaxN+1 do begin
      if j<>1 then write (' ');
      if j=c[i] then write (1)
      else
      if j=MaxN+1 then write (i)
      else write (0);
    end;
    writeln;
  end;
end.