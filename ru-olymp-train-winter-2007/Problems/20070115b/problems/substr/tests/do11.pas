{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
var i:longint;
begin
  randseed:=324798732;
  for i:=1 to 500 do
    begin
      write ('x');
      write ('':random (4));
      if random (175)=3 then writeln;
    end;
  write ('y');
  write ('':random (3));
  if random (175)=3 then writeln;
  write ('*');
  write ('':random (2));
  if random (175)=3 then writeln;
  for i:=1 to 200000 do
    begin
      if random (1234)=432 then write ('y') else write ('x');
      write ('':random (3));
      if random (175)=3 then writeln;
    end;
end.