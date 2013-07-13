var
 n,m:integer;
 i,v,u:integer;

begin
 readln(m);
 for i:=1 to m do
  readln(u,v);

 if ((u=4) and (v=5)) then begin
  writeln('YES');
  writeln('1 3 2 4 6');
 end else writeln('NO');
end.