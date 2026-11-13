{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
var c:array [1..200] of integer;
    i, n, s:integer;
begin
  for i:=1 to 200 do
    begin
      if s+i>200 then begin n:=i-1; break end;
      c[i]:=i;
      inc (s, i);
    end;
  writeln (n);
  write (c[1]); for i:=2 to n do write (' ', c[i]);
  writeln;
end.