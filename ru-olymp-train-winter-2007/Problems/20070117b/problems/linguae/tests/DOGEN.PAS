{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
unit dogen;
interface
uses dorand;
procedure gen (n, maxc, p:integer);
procedure genc (n, c, maxd, p:integer);
procedure genc2 (n, c, maxd, p:integer);
implementation
procedure gen (n, maxc, p:integer);
var i:integer;
begin
  regint (n); regint (maxc); regint (p);
  writeln (n);
  for i:=1 to n do
    writeln (lr (1, maxc), ' ', lr (1, maxc), ' ', lr (1, maxc));
end;

procedure genc (n, c, maxd, p:integer);
var i:integer;
begin
  regint (n); regint (c); regint (maxd); regint (p);
  writeln (n);
  for i:=1 to n do
    writeln (c+randr (-maxd, maxd), ' ', 2*c+randr (-2*maxd, 2*maxd), ' ',
             3*c+randr (-3*maxd, 3*maxd));

end;


procedure genc2 (n, c, maxd, p:integer);
var i:integer;
begin
  regint (n); regint (c); regint (maxd); regint (p);
  writeln (n);
  for i:=1 to n do
    writeln (c+randr (-maxd, maxd), ' ', 2*c+randr (-maxd, maxd), ' ',
             3*c+randr (-maxd, maxd));

end;

end.