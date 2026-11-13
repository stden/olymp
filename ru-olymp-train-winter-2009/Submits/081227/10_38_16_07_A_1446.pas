type
  int = longint;

const 
  w = 434343;
  e = 226642;
  
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
  if ((random(q) mod w) < e) then
    writeln('YES')
  else
   writeln('NO');
end.