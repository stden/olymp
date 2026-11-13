{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
const DoS=200;
var c:array [1..DoS] of integer;
    i, n, s, cc:integer;
begin
  randseed:=45878;
  s:=DoS;
  repeat
    cc:=random (random (random (random (random (s)))))+1;
    inc (n);
    c[n]:=cc;
    dec (s, cc);
  until s=0;
  writeln (n);
  write (c[1]); for i:=2 to n do write (' ', c[i]);
  writeln;
end.