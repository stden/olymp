program solve;

var
 inp,oup:text;
 i,k,c:longint;
 otv,a:array[0..10000]of longint;

begin
 assign(inp,'cube.in');
 assign(oup,'cube.out');
 reset(inp);
 rewrite(oup);
 read(inp,k);
 for i:=0 to (1 shl k)-1 do
  begin
   read(inp,a[i]);
  end;
 fillchar(otv,sizeof(otv),0);
 otv[0]:=a[0];
 for i:=0 to (1 shl k)-1 do
   for c:=0 to k-1 do
    begin
     if (((1 shl c)and i)=0) and(otv[i]+a[(1 shl c)or i]>otv[(1 shl c)or i]) then
      otv[(1 shl c)or i]:=otv[i]+a[(1 shl c)or i];
    end;
 writeln(oup,otv[(1 shl k)-1]);
 close(inp);
 close(oup);

end.

