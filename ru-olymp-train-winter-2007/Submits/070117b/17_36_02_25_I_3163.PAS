program sh;
const tn='subseq';
var a,nn,v,u:array[0..300000]of longint;
    t,n,maxl,i,l,r,c:longint;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 read(n);
 a[0]:=-maxlongint;
 maxl:=0;
 for i:=1 to n do
 begin
  read(c);   c:=-c;
  l:=0;
  r:=maxl;
  while (r-l>1) do
   if a[(r+l) div 2]>c then r:=(r+l) div 2 else l:=(l+r) div 2;
  if a[r]>c then r:=l;
  if (r+1>maxl) then
  begin
   maxl:=r+1;
   a[r+1]:=maxlongint;
  end;
  if a[r+1]>=c then
  begin
   a[r+1]:=c;
   nn[r+1]:=i;
   v[i]:=nn[r];
  end;
 end;
 t:=nn[maxl];
 while t>0 do
 begin
  u[t]:=1;
  t:=v[t];
 end;
 writeln(maxl);
 for i:=1 to n do
  if u[i]=1 then writeln(i);
 close(input);close(output);
end.
