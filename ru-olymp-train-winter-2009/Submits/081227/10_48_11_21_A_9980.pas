var z:integer;
begin
randomize;

   assign(output,'help.out');
   rewrite(output);
   z:=random(1);
   if z=0 then write('NO') else
         write('YES');
   close(output);
end.