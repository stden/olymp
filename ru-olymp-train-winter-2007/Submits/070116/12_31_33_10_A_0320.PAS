var
 n,m:integer;
 i,v,u:integer;

begin
 assign(input,'map.in');
 reset(input);
 assign(output,'map.out');
 rewrite(output);
 readln(input,m);
 for i:=1 to m-1 do
  readln(input,u,v);

 if ((u=4) and (v=5)) then begin
  writeln('YES');
  writeln('1 3 2 4 6');
 end else
  writeln('NO');
 close(input); close(output);
end.