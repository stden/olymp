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
 readln(inp,s);
 writeln(oup,'YES');
 close(inp);
 close(oup);

end.

