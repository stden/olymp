{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
var c:array [1..200] of integer;
    i, n, s, t, f, f1, f2, f3:integer;
begin
  f:=1;
  for i:=1 to 200 do
    begin
      t:=f;
      c[i]:=t;
      inc (s, t);
      if s>200 then begin n:=i-1; break end;
      f:=f*3;
    end;
  writeln (n);
  write (c[1]); for i:=2 to n do write (' ', c[i]);
  writeln;
end.