program solve;

var
 inp,oup:text;
 a,b,sum:int64;
 s:array[0..20]of longint;
 n,nn,k,i,z:longint;

begin
 assign(inp,'modsum.in');
 assign(oup,'modsum.out');
 reset(inp);
 rewrite(oup);
 read(inp,n);
 for i:=0 to n-1 do
  read(inp,s[i]);
 sum:=0;
 for i:=1 to (1 shl (n)-1) do
  begin
   nn:=not i;
   k:=((1 shl n)-1)and nn;
   while k>0 do
    begin
     a:=0;
     b:=0;
     for z:=0 to n-1 do
      begin
       if i and (1 shl z) <>0 then
       inc(a,s[z]);
       if k and (1 shl z) <>0 then
       inc(b,s[z]);
      end;
     sum:=sum+(a mod b);
     dec(k);
   k:=k and nn;
    end;

  end;
 writeln(oup,sum);
 close(inp);
 close(oup);
end.

