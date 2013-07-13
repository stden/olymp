{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
const N=13;
var i, j, c, k:integer;
    a:array [1..N, 1..N+1] of integer;
    r:array [1..N+1] of integer;
begin
  randseed:=218;
  for i:=1 to N do begin
    for j:=1 to N do
      begin
        a[i, j]:=round (100/(i+j-1))
      end;
    a[i, N+1]:=integer (random (201))-100
  end;
  writeln (N);
  for i:=1 to N do begin j:=random (i)+1; r[i]:=r[j]; r[j]:=i end;
  for i:=1 to N do begin
    for j:=1 to N+1 do begin
      if j<>1 then write (' ');
      write (a[r[i], j]);
    end;
    writeln;
  end;
end.