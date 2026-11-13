{$R-,S-,Q-,B-,H+}

const taskid='beauty';

var minl,g,r,dl,n,i,j,k,k1:longint;
    s:array [1..10003] of ansistring;
    y,z,le,ind,l,num:array [1..10003] of longint;
    a,co:array [1..10003] of int64;
    c:char;
    d:array [0..103,1..10003] of int64;
    h1,h2,ll:array [0..103,1..10003] of longint;
    t:array [1..10003] of boolean;
    u,len:array of array of longint;
    cost:array of array of int64;
    p:array [1..10003,0..103] of longint;
    val:array [1..10003,1..103] of int64;
    w,ans:ansistring;
    x,max:int64;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(k);
for i:=1 to k do
 begin
 s[i]:='';
 read(c);
 while not(c in ['a'..'z']) do read(c);
 while c in ['a'..'z'] do
  begin
  s[i]:=s[i]+c;
  read(c);
  end;
 readln(a[i]);
 end;
readln(n);
fillchar(t,sizeof(t),0);
for i:=1 to k do
 if length(s[i])>n then t[i]:=true;
k1:=0;
for i:=1 to k do
 if not t[i] then
  begin
  inc(k1);
  s[k1]:=s[i];
  a[k1]:=a[i];
  end;
k:=k1;
for i:=1 to k do y[i]:=i;
for i:=1 to k-1 do
 for j:=i+1 to k do
  if s[y[i]]>s[y[j]] then
   begin
   r:=y[i];
   y[i]:=y[j];
   y[j]:=r;
   end;
for i:=1 to k do z[y[i]]:=i;
for i:=1 to k do l[i]:=length(s[i]);
fillchar(val,sizeof(val),0);
for i:=1 to k do
 begin
 for j:=1 to k do
  if i<>j then
   begin
   w:=s[i];
   dl:=0;
   r:=1;
   while r>0 do
    begin
    r:=pos(s[j],w);
    if r=0 then break;
    inc(val[i,dl+r+l[j]-1],a[j]);
    delete(w,1,r);
    inc(dl,r);
    end;
   end;
  inc(val[i,l[i]],a[i]);
  for j:=2 to l[i] do inc(val[i,j],val[i,j-1]);
  end;
for i:=1 to k do
 begin
 p[i,0]:=-1;
 p[i,1]:=0;
 x:=0;
 for j:=2 to l[i] do
  begin
  while (x>=0) and (s[i][x+1]<>s[i][j]) do x:=p[i,x];
  inc(x); p[i,j]:=x;
  end;
 end;
fillchar(num,sizeof(num),0);
setlength(u,k+2);
setlength(len,k+2);
setlength(cost,k+2);
for i:=1 to k do
 begin
 for j:=1 to k do
  begin
  x:=0;
  for g:=1 to l[j] do
   begin
   while (x>=0) and (s[j][g]<>s[i][x+1]) do x:=p[i,x];
   inc(x);
   if x=l[i] then x:=p[i,x];
   end;
  if x>0 then
   begin
   inc(num[i]);
   ind[num[i]]:=j;
   le[num[i]]:=l[j]-x;
   co[num[i]]:=val[j,l[j]]-val[i,x];
   end;
  end;
 setlength(u[i],num[i]+2);
 setlength(len[i],num[i]+2);
 setlength(cost[i],num[i]+2);
 u[i,0]:=0;
 for j:=1 to num[i] do
  begin
  u[i,j]:=ind[j];
  len[i,j]:=le[j];
  cost[i,j]:=co[j];
  end;
 end;
fillchar(d,sizeof(d),0);
fillchar(ll,sizeof(ll),63);
for i:=0 to n-1 do
 for r:=1 to k do
 if (i=0) or (d[i,r]>0) then
 begin
 for j:=1 to num[r] do
  begin
  for g:=u[r,j-1]+1 to u[r,j]-1 do
   begin
   x:=d[i,r]+val[g,l[g]];
   dl:=i+l[g];
   if dl>n then continue;
   if (d[dl,g]<x) or ((d[dl,g]=x) and (ll[dl,g]>z[g])) then
    begin
    d[dl,g]:=x;
    ll[dl,g]:=z[g];
    h1[dl,g]:=r;
    h2[dl,g]:=i;
    end;
   end;
  if i>0 then
   begin
   x:=d[i,r]+cost[r,j];
   dl:=i+len[r,j];
   if dl>n then continue;
   if (d[dl,u[r,j]]<x) or ((d[dl,u[r,j]]=x) and (ll[dl,u[r,j]]>z[u[r,j]])) then
    begin
    d[dl,u[r,j]]:=x;
    ll[dl,u[r,j]]:=z[u[r,j]];
    h1[dl,u[r,j]]:=r;
    h2[dl,u[r,j]]:=i;
    end;
   end;
  end;
 for g:=u[r,num[r]]+1 to k do
  begin
  x:=d[i,r]+val[g,l[g]];
  dl:=i+l[g];
  if dl>n then continue;
  if (d[dl,g]<x) or ((d[dl,g]=x) and (ll[dl,g]>z[g])) then
   begin
   d[dl,g]:=x;
   ll[dl,g]:=z[g];
   h1[dl,g]:=r;
   h2[dl,g]:=i;
   end;
  end;
 end;
max:=0;
minl:=maxlongint div 2;
for i:=0 to n do
 for j:=1 to k do
  if (d[i,j]>max) or ((d[i,j]=max) and (ll[i,j]<minl)) then
   begin
   max:=d[i,j];
   minl:=ll[i,j];
   dl:=i;
   r:=j;
   end;
ans:='';
while dl>0 do
 begin
 for i:=1 to num[h1[dl,r]] do
  if u[h1[dl,r],i]=r then break;
 if u[h1[dl,r],i]=r then ans:=ans+copy(s[r],l[r]-len[h1[dl,r],i]+1,len[h1[dl,r],i])
 else ans:=ans+s[r];
 j:=r;
 r:=h1[dl,r];
 dl:=h2[dl,j];
 end;
while length(ans)<n do ans:='a'+ans;
writeln(max);
writeln(ans);
close(output);
end.
