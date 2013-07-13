//{$Q-,R-,S-,I-,O+}
program aa;
const
tn = 'game';
maxs = 32768;
maxn = 15;
maxk = 10*maxn;
type
real=extended;
var
n:byte;
t:word;
k,i,j,ukR,ukW,p:longint;
anz:real;
a:array[1..maxn,1..maxn] of word;
b:array[1..maxn,1..maxn] of real;
d:array[0..maxs-maxn-1,1..maxk,1..maxn] of real;
s:array[0..maxs-maxn-1,1..maxn] of longint;
u:array[0..maxs,1..maxk,1..maxn] of boolean;
ans:array[1..maxk] of real;
och:array[1..maxs*maxn*maxn] of
 record
  v:word;
  k,l:byte;
 end;

procedure BFS(uk:longint);
var
v,nv:word;
k,l,nl,cn,nk:byte;
pp,c:real;
begin
v:=och[uk].v;
k:=och[uk].k;
l:=och[uk].l;
if k=maxk then exit;
cn:=0;
i:=1;
while (cn<=1)and(i<=n) do
 begin
  if v and (1 shl (i-1))=0 then inc(cn);
  inc(i);
 end;
if cn<=1 then exit;
if d[v,k,l]=0 then exit;
pp:=0;
for i:=1 to n do
 begin
  if (v and (1 shl (i-1))=0)and(i<>l) then
   begin
    pp:=pp+(a[l,i]/s[v,l])*(1-b[l,i]);
    c:=(a[l,i]/s[v,l])*b[l,i];
    nv:=v xor (1 shl (i-1));
    nl:=l mod n +1;
    while nv and (1 shl (nl-1))<>0 do nl:=nl mod n +1;
//    writeln('LOG ',nv,' ',k+1,' ',nl,' ',d[v,k,l]:0:5);
    d[nv,k+1,nl]:=d[nv,k+1,nl]+d[v,k,l]*c;
    if not u[nv,k+1,nl] then
     begin
      u[nv,k+1,nl]:=true;
      inc(ukW);
      och[ukW].v:=nv;
      och[ukW].k:=k+1;
      och[ukW].l:=nl;
     end;
   end;
 end;
 nk:=k+1;
 nl:=l mod n+1;
d[v,nk,nl]:=d[v,nk,nl]+d[v,k,l]*pp;
if not u[v,nk,nl] then
 begin
  u[v,nk,nl]:=true;
  inc(ukW);
  och[ukW].v:=v;
  och[ukW].k:=nk;
  och[ukW].l:=nl;
 end;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n);
for i:=1 to n do
 for j:=1 to n do read(a[i,j]);
for i:=1 to n do
 for j:=1 to n do read(b[i,j]);

t:=1;
i:=0;
while (i<n) do
 begin
  inc(i);
  t:=t*2;
 end;
t:=t-1;
for i:=0 to t-n-1 do
 begin
  for p:=1 to n do
   begin
    if i and (1 shl (p-1))=0 then
    begin
     k:=0;
     for j:=1 to n do
      if (i and (1 shl (j-1))=0)and(p<>j) then k:=k+a[p,j];
     s[i,p]:=k;
    end;
   end;
 end;

//fillchar(d,sizeof(d),0);
//fillchar(u,sizeof(u),false);
d[0,0,1]:=1;
ukR:=1;
ukW:=0;
for i:=0 to maxk do
 begin
  inc(ukW);
  och[ukW].v:=0;
  och[ukW].k:=i;
  och[ukW].l:=i mod n +1;
  u[0,i,i mod n+1]:=true;
 end;
while (ukR<=ukW) do
 begin
  BFS(ukR);
  inc(ukR);
 end;

// fillchar(ans,sizeof(ans),0);
for i:=1 to n do
 begin
  k:=t xor (1 shl (i-1));
  for j:=0 to maxk do
   ans[j]:=ans[j]+d[k,j,i];
 end;
anz:=0;
{for i:=0 to maxk do
 begin
 write(d[0,i,1]:0:5,'/',d[0,i,2]:0:5,' ');
end;
 writeln;
for i:=1 to n do
 begin
  k:=t xor (1 shl (i-1));
  for j:=0 to maxk do write(d[k,j,i]:0:5,' ');
  writeln;
 end;
 writeln;}

//for i:=1 to maxk do write(ans[i]:0:5,' ');
//writeln;
anz:=0;
for i:=1 to maxk do
 begin
  if ans[i]>0 then
   begin
    anz:=anz+ans[i]*i;
   end;
 end;
write(anz:0:5);
Close(input);Close(output);
end.
