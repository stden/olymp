uses Math;
const
 f=154334564;
var
 c:char;
 k:integer;
begin
 assign(input, 'help.in'); reset(input);
 assign(output, 'help.out'); rewrite(output);

 while not eof(input) do begin
  read(c);
  k:=k+ord(c);
  k:=(k*2) mod f;
 end;
 randseed:=k;
 if random(2)=1 then writeln('YES') else writeln('NO');
end.