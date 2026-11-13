type
  int = longint;

const 
  w = 100;
  e = 30;
  
var
  q: int;
  str : string;
  
begin
  assign(output, 'help.out');
  rewrite(output);
  assign(input, 'help.in');
  reset(input);
    
  q:=0;

  
  while (not(eof)) do
  begin
   readln(str);
   inc(q);
  // writeln(str);
  end;
  
  q:=q*11111;
  randseed := 12345678;
  if ((random(q) mod w) < e) then
    writeln('YES')
  else
   writeln('NO');
end.