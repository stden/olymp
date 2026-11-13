{$MODE DELPHI}
uses Math;

const
 f=12834567;
 p=37; //19


var
 c:char;
 k:integer;

begin
 assign(input, 'help.in'); reset(input);
 assign(output, 'help.out'); rewrite(output);
 while not eof(input) do begin
  read(c);
  k:=(((k+p) * 3) + ord(c)) mod f;
 end;

 randseed:=k;
 if random(2)=0 then writeln('YES') else writeln('NO');
end.
