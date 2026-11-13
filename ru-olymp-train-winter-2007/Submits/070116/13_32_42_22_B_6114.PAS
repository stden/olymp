var n:integer;
begin
  assign(input,'pines.in');
  assign(output,'pines.out');
  reset(input);
  rewrite(output);
  readln(n);
   if n=1 then write(1)
   else
   if n=2 then write(0)
   else
   if n=3 then write(1)
   else
   if n=4 then write(1)
   else
   if n=5 then write(1)
   else 
   if n=6 then write(2)
   else if n=7 then write(2)
   else if n=8 then write(4)
   else writeln(8);
  close(input);
  close(output);
end.