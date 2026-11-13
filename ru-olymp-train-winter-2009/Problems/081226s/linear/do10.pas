{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
var i, j, c, k:integer;
    a:array [1..20, 1..21] of integer;
    r:array [1..20] of integer;
begin
  for i:=1 to 20 do begin
    for j:=1 to 20 do
      begin
        a[i, j]:=round (100/(i+j-1))
      end;
    a[i, 21]:=integer (random (201))-100
  end;
  writeln (20);
  for i:=1 to 20 do begin j:=random (i)+1; r[i]:=r[j]; r[j]:=i end;
  for i:=1 to 20 do begin
    for j:=1 to 21 do begin
      if j<>1 then write (' ');
      write (a[r[i], j]);
    end;
    writeln;
  end;
end.