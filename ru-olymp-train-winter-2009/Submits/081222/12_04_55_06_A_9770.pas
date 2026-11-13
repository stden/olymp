program zagl;

var
 inp,oup:text;
 mas:array[1..1000000]of longint;
 i,n,m,j,sum,k,a,b,c:longint;

begin
 assign(inp,'sum.in');
 assign(oup,'sum.out');
 reset(inp);
 rewrite(oup);
 read(inp,n,k,m);
 for i:=1 to m do
  begin
   read(inp,c,a,b);
   sum:=0;
   for j:=a to b do
    begin
     if c=1 then inc(mas[j]) else sum:=sum +(mas[j] mod k);
    end;
   if c=2 then writeln(oup,sum);
  end;
 close(inp);
 close(oup);
end.

