{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
var i:longint;
begin
  randseed:=43983743;
  for i:=1 to 10000 do
    begin
      write (chr (i mod 3+ord ('x')));
      write ('':random (4));
      if random (175)=3 then writeln;
    end;
  write ('':random (3));
  if random (175)=3 then writeln;
  write ('*');
  write ('':random (2));
  if random (175)=3 then writeln;
  for i:=1 to 200000 do
    begin
      write (chr (i mod 3+ord ('x')));
      write ('':random (3));
      if random (175)=3 then writeln;
    end;
end.