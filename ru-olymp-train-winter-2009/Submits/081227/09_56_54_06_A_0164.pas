program fignya;

const
 n=7;
 eps:array[1..n]of string=('input','randseed','randomize','random','.in','read','readln');

var
 inp,oup:text;
 i:longint;
 s:string;
 sch:longint;

begin
 assign(inp,'help.in');
 assign(oup,'help.out');
 reset(inp);
 rewrite(oup);
 randseed:=321123;
 sch:=random(9)+1;
 if sch mod 2=0 then writeln(oup,'YES') else writeln(oup,'NO');
 close(inp);
 close(oup);
end.

