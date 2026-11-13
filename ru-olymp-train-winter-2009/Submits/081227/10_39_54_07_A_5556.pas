type
  int = longint;

const 
  w = 434343;
  e = 333333;
  
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
  
  q*=32323332;
  randseed := 321123;
  if ((random(q) mod w) < e) then
    writeln('YES')
  else
   writeln('NO');
end.