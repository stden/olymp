{$A+,B-,D+,E-,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
unit dogen;
interface
uses dorand;
type integer=longint;
procedure gen (N:integer; minx, maxx, mind, maxd:longint; par:integer);
implementation
procedure gen (N:integer; minx, maxx, mind, maxd:longint; par:integer);
var q, d, i:longint;
begin
  regint (N); regint (minx); regint (maxx); regint (mind);
  regint (maxd); regint (par);
  writeln (n);
  for i:=1 to n do begin
    q:=longrand (minx, maxx);
    d:=longrand (mind, maxd);
    writeln (q, ' ', q+d);
  end;
end;
end.