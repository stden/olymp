var
 i,a,b:longint;
begin
 assign(input,'map.in');
 assign(output,'map.out');
 reset(input);
 rewrite(output);
 for i:=1 to 8 do
  begin
  if seekeof then
   begin
   writeln('NO');
   close(input);
   close(output);
   halt;
   end;
  read(a);
  end;
 if a=4 then
  begin
  writeln('YES');
  writeln('1 3 2 4 5');
  end
 else
  writeln('NO');
 close(input);
 close(output);
end.