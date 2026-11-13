{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
var i, j:integer;
begin
  randseed:=455789345;
  writeln (20);
  for i:=1 to 20 do begin
    for j:=1 to 21 do begin
      if j<>1 then write (' ');
      write (integer (random (201))-100);
    end;
    writeln;
  end;
end.