{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
const DoS=200;
      Ps=1000;
var c:array [1..DoS] of integer;
    i, n, s, cc:integer;

function RYBA (e:extended;maxval:integer):integer;
var r:integer;
begin
  repeat
    r:=0;
    for i:=1 to Ps do
      if random<e/Ps then inc (r);
  until (r<=maxval) and (r>=1);
  RYBA:=r;
end;

var e:extended;

begin
  randseed:=34534759;
  e:=exp (1);
  s:=DoS;
  repeat
    cc:=RYba (e, s);
    inc (n);
    c[n]:=cc;
    dec (s, cc);
  until s=0;
  writeln (n);
  write (c[1]); for i:=2 to n do write (' ', c[i]);
  writeln;
end.