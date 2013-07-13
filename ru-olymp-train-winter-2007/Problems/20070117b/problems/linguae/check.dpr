{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
program macro;
uses testlib;
var jury, cont:longint;
begin
  jury:=ans.getlong;
  cont:=ouf.getlong;
  if jury<>cont then quit (_wa, 'Требовалось '+i2s (jury)+', а получено '+i2s (cont));
  quit (_ok, '');
end.