{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
var i:longint;
begin
  randseed:=347832;
  write ('kittenish kitten');
  write ('':random (4));
  if random (175)=3 then writeln;
  write ('':random (3));
  if random (175)=3 then writeln;
  write ('*');
  write ('':random (2));
  if random (175)=3 then writeln;
  for i:=1 to 100000 do
    begin
      write (chr (random (3)+ord ('a')));
      write ('':random (3));
      if random (175)=3 then writeln;
      if random (239)=17 then write ('kittenish kitten');
    end;
end.