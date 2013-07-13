{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
uses dorand;
var i:integer;
    t1, t2:longint;
begin
  writeln (5000);
  for i:=1 to 5000 do begin
    t1:=longrand (-500000000, 500000000);
    t2:=longrand (-1000000, 1000000);
    writeln (t1, ' ', t1+t2);
  end;
end.