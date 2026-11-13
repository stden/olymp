uses
 math;
var
 i,n:longint;
 a,b,c,tab:array[-2..10010]of longint;
begin
 assign(input,'linguae.in');
 assign(output,'linguae.out');
 reset(input);
 rewrite(output);
 read(n);
 tab[n]:=0;
 for i:=-2 to 10010 do
  begin
  tab[i]:=2000000000;
  a[i]:=2000000000;
  b[i]:=2000000000;
  c[i]:=2000000000;
  end;
 tab[n]:=0;
 tab[n+1]:=0;
 tab[n+2]:=0;
 for i:=1 to n do
  begin
  read(a[i],b[i],c[i]);
  end;
 for i:=n+2 downto 1 do
  begin
  tab[i]:=min(tab[i],min(tab[i-1],tab[i-2]));
  tab[i-1]:=min(tab[i]+a[i],tab[i-1]);
  tab[i-2]:=min(tab[i-2],tab[i]+b[i-1]);
  tab[i-3]:=min(tab[i]+c[i-2],tab[i-3]);
  end;
{ for i:=0 to n do
  writeln(tab[i]);}
// writeln(tab[n]);
 writeln(tab[0]);
// writeln(min(min(tab[n],tab[n+1]),tab[n+2]));
 close(input);
 close(output);
end.
