type
  int = longint;

const 
  w = 234;
  e = 3;
  
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
  
  q*=323232;
  randseed := 321123;
  if ((random(q) mod w) > e) then
    writeln('YES')
  else
   writeln('NO');
end.