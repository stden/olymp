uses
 math;
var
 i,n,a,b,c:longint;
 tab:array[0..10010]of longint;
begin
 assign(input,'linguae.in');
 assign(output,'linguae.out');
 reset(input);
 rewrite(output);
 read(n);
 tab[0]:=0;
 tab[0]:=0;
 tab[0]:=0;
 for i:=1 to 10010 do
  tab[i]:=2000000000;
 for i:=1 to n do
  begin
  read(a,b,c);
  tab[i]:=min(tab[i],tab[i-1]+a);
  tab[i+1]:=min(tab[i+1],tab[i-1]+b);
  tab[i+2]:=min(tab[i+2],tab[i-1]+c);
  end;
{ for i:=0 to n do
  writeln(tab[i]);}
 writeln(min(min(tab[n],tab[n+1]),tab[n+2]));
 close(input);
 close(output);
end.