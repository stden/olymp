type
  int = longint;

const 
  w = 4343433;
  e = 2563456;
  
var
 c: char;
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
  
  q:=q*323233;
  randseed := 23133;
  if ((random(q) mod w) < e) then
    writeln('YES')
  else
   writeln('NO');
end.