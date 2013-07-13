program solve;

var
 inp,oup:text;
 a,b,sum:int64;
 s,x:array[0..100000]of int64;
 n,nn,k,i,z:longint;

begin
 assign(inp,'modsum2.in');
 assign(oup,'modsum2.out');
 reset(inp);
 rewrite(oup);
 read(inp,n);
 for i:=0 to n-1 do
  read(inp,s[i]);
 sum:=0;
 for i:=0 to (1 shl n)-1 do
 for z:=0 to n-1 do
      begin
       if i and (1 shl z) <>0 then
       inc(x[i],s[z]);
      end;
 for i:=1 to (1 shl (n)-1) do
  begin
   nn:=-i-1;

   k:=((1 shl n)-1)and nn;
   while k>0 do
    begin
     sum:=sum+(x[i] mod x[k]);
     dec(k);
     k:=k and nn;
    end;

  end;
 writeln(oup,sum);
 close(inp);
 close(oup);
end.

