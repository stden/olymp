program test2;

var
 inp,oup:text;
 matr:array[0..500,0..500]of longint;
 c2,c3,c,a,otv:array[0..500]of longint;
 p,max,i,j,z,uk2,uk,tek,ost:longint;
 s:string;

begin
 {for n:=1 to 20 do
  begin
   c:=n div 3;
   cc:=c*4+3*c*(c-1); cc:=c(3*c+1);
   cp:=2*c+1;
   inc(cc,cp*(n mod 3));    writeln('n = ',n,', max = ',cc);
  end;  }
 assign(inp,'room.in');
 assign(oup,'room.out');
 reset(inp);
 rewrite(oup);
 readln(inp,s);
 for i:=1 to length(s) do
  a[i]:=ord(s[length(s)-i+1])-ord('0');
 a[0]:=length(s);
 uk2:=a[0];
 tek:=a[a[0]];
 while uk2>=1 do
  begin
   if tek<3 then
    begin
     c[uk2]:=0;
     dec(uk2);
     if uk2>0 then tek:=tek*10+a[uk2];
     continue;
    end;
   c[uk2]:=tek div 3;
   tek:=tek mod 3;
   dec(uk2);
   if uk2>0 then tek:=tek*10+a[uk2];
  end;
 c[0]:=a[0];
 ost:=tek;
 p:=0;
 for i:=1 to c[0]+1 do
  begin
   c2[i]:=(c[i]*2+p)mod 10;
   p:=(c[i]*2+p) div 10;
  end;
 if c2[i]<>0 then c2[0]:=c[0]+1 else c2[0]:=c[0];

 p:=0;
 for i:=1 to c[0]+1 do
  begin
   c3[i]:=(c[i]*3+p)mod 10;
   p:=(c[i]*3+p) div 10;
  end;
 if c3[c[0]+1]<>0 then c3[0]:=c[0]+1 else c3[0]:=c[0];

 uk:=1;
 inc(c2[1]);
 while c2[uk]>=10 do
  begin
   dec(c2[uk],10);
   inc(c2[uk+1]);
   inc(uk);
  end;
 if uk>c2[0] then c2[0]:=uk;

 uk:=1;
 inc(c3[1]);
 while c3[uk]>=10 do
  begin
   dec(c3[uk],10);
   inc(c3[uk+1]);
   inc(uk);
  end;
 if uk>c3[0] then c3[0]:=uk;


 fillchar(matr,sizeof(matr),0);
 for i:=1 to c3[0] do
  begin
   p:=0;
   for j:=1 to c[0]+1 do
    begin
     matr[i,i+j-1]:=(c[i]*c3[j]+p)mod 10;
     p:=(c[i]*c3[j]+p) div 10;
    end;
  end;
 p:=0;
 for i:=1 to c3[0]+c[0]+1 do
  begin
   otv[i]:=0;
   for j:=1 to c3[0] do
    inc(otv[i],matr[j,i]);
   inc(otv[i],p);
   p:=otv[i] div 10;
   otv[i]:=otv[i] mod 10;
  end;
 otv[0]:=c[0]+c3[0]+10;
 while otv[otv[0]]=0 do dec(otv[0]);
 p:=0;
 for z:=1 to ost do
  begin
   max:=otv[0];
   if c2[0]>max then max:=c2[0];
   for i:=1 to max+2 do
    begin
     otv[i]:=otv[i]+c2[i]+p;
     p:=otv[i] div 10;
     otv[i]:=otv[i] mod 10;
     if otv[i]>0 then otv[0]:=i;
    end;
  end;
 for i:=otv[0] downto 1 do
  write(oup,otv[i]);
 close(inp);
 close(oup);
end.

