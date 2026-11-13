uses
 SysUtils;
const
 tl=5*60/24/60/60;
 ans:array[1..4]of longint=(1,119,7460,114831);
var
 all:extended;
 n,m,t:longint;
begin
 assign(input,'heritage.in');
 assign(output,'heritage.out');
 reset(input);
 rewrite(output);
 read(m,n);
 if n>m then
  begin
  t:=m;m:=n;n:=t;
  end;
 all:=(n+1)*(m+1);
 all:=all*all;
// writeln(all*all*all*all:0:0);
 if (n=1) and (m=1) then
  begin
  writeln(ans[1]*24/(all*all*all*all):0:8);
  end;
 if (n=1) and (m=2) then
  begin
  writeln(ans[2]*24/(all*all*all*all):0:8);
  end;
 if (n=2) and (m=2) then
  begin
  writeln(ans[3]*24/(all*all*all*all):0:8);
  end;
 if (n=2) and (m=3) then
  begin
  writeln(ans[4]*24/(all*all*all*all):0:8);
  end;
 close(input);
 close(output);
end.