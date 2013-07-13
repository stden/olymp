program solve;

var
 inp,oup:text;
 o,aa,bb,a,b:array[0..10000]of longint;
 c:char;
 i,uk,l:longint;
 fl:boolean;

begin
 assign(inp,'aplusminusb.in');
 assign(oup,'aplusminusb.out');
 reset(inp);
 rewrite(oup);
 while not eoln(inp) do
  begin
   read(inp,c);
   inc(a[0]);
   a[a[0]]:=ord(c)-ord('0');
  end;
 readln(inp);
 while not eoln(inp) do
  begin
   read(inp,c);
   inc(b[0]);
   b[b[0]]:=ord(c)-ord('0');
  end;
 for i:=1 to a[0] do
  aa[i]:=a[a[0]-i+1];
 aa[0]:=a[0];
 a:=aa;
 for i:=1 to b[0] do
  bb[i]:=b[b[0]-i+1];
 bb[0]:=b[0];
 b:=bb;
 fl:=false;
 fl:=b[0]>a[0];
 if b[0]=a[0] then
  begin
   uk:=a[0];
   while (a[uk]=b[uk])and(uk>0) do
    dec(uk);
   if b[uk]>a[uk] then fl:=true;
  end;
 if fl then
  begin
   aa:=a;
   a:=b;
   b:=aa;
  end;
 o[0]:=a[0];
 l:=a[0];
 for i:=1 to l do
  begin
   if a[i]>=b[i] then
    begin
     o[i]:=a[i]-b[i];
     continue;
    end;
   uk:=i+1;
   while a[uk]=0 do
    begin
     a[uk]:=9;
     inc(uk);
    end;
   dec(a[uk]);
   a[i]:=a[i]+10;
   o[i]:=a[i]-b[i];
  end;
 uk:=o[0];
 while o[uk]=0 do dec(uk);
 if fl then write(oup,'-');
 for i:=uk downto 1 do
  write(oup,o[i]);

 close(inp);
 close(oup);

end.

