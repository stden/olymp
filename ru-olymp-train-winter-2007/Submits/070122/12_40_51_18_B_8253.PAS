{$r+,s+,q+}
var
 tab2,tab:array[0..200,0..10010]of longint;
 c,a,w,r,ch,q:array[0..210]of longint;
 n,b,e,p,x,i,j:longint;
 inq:array[0..200]of boolean;
begin
 assign(input,'system.in');
 assign(output,'system.out');
 reset(input);
 rewrite(output);
 read(n);
 for i:=1 to n do
  begin
  read(r[i],c[i],a[i],w[i]);
  ch[r[i]]:=ch[r[i]]+1;
  for j:=a[i]+1 to c[i]+1 do
   tab[i,j]:=w[i];
  tab[i,a[i]]:=0;
  for j:=0 to c[i] do
   tab2[i,j]:=0;
  tab2[i,c[i]+1]:=a[i];
  inq[i]:=false;
  end;
 b:=0;
 e:=0;
 for i:=1 to n do
  if ch[i]=0 then
   begin
   e:=e+1;
   q[e]:=i;
   inq[i]:=true;
   end;
 while b<>e do
  begin
  b:=b+1;
  x:=q[b];
  p:=r[x];
  if p=0 then
   break;
  for i:=c[p]+1 downto a[x] do
   if tab[p,i]>tab[p,i-a[x]]+tab[x,c[x]] then
    begin
    tab[p,i]:=tab[p,i-a[x]]+tab[x,c[x]];
    tab2[p,i]:=tab2[p,i-a[x]]+a[x];
    end;
  if not(inq[p]) then
   begin
   e:=e+1;
   q[e]:=p;
   inq[p]:=true;
   end;
  end;
 writeln(tab[1,c[1]+1]);
 close(input);
 close(output);
end.
