{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
var i, j:integer;
begin
  writeln (20);
  for i:=1 to 20 do begin
    for j:=1 to 21 do begin
      if j<>1 then write (' ');
      if j=i then write (100)
      else
      if j>i then write (1)
      else write (0);
    end;
    writeln;
  end;
end.