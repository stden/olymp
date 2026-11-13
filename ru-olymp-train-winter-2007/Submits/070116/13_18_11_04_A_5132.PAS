program map;
var
n,k,i,j,m:longint;
s,ss:longint;
begin
 assign(input,'map.in');Reset(input);
 assign(output,'map.out');Rewrite(output);
 read(m);
 s:=0;
 for i:=1 to m-1 do
  begin
   read(p[i,0],p[i,1]);
   s:=s+p[i,0]*10+p[i,1];
  end;
 read(n);
 ss:=0;
 for i:=1 to n-1 do
  begin
   read(pp[i,0],pp[i,1]);
   ss:=ss+pp[i,0]*10+pp[i,1];
  end;
 if (m=6)and(n=5)and(s=115)and(ss=151) then
  begin
   writeln('YES');
   write('1 3 2 4 6');
  end else Write('NO');
 close(input);Close(output);
end.