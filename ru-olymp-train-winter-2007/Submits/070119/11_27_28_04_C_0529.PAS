program aa;
const
tn = 'republic';
maxn=100000;
maxm=100000;
var
ruk,n,k,i,j,m,lc,uk,ans:longint;
p,pp:array[1..maxm,0..1] of longint;
bob:array[1..maxn,0..1] of longint;
u,ad:array[1..maxn] of boolean;
ppc:array[1..maxn] of byte;
och,c,roch:array[1..maxn] of longint;
anz:array[1..maxm,0..1] of longint;
pr:array[1..maxn] of longint;

procedure swap(i,j:longint);
var
c:longint;
begin
c:=p[i,0];
p[i,0]:=p[j,0];
p[j,0]:=c;
c:=p[i,1];
p[i,1]:=p[j,1];
p[j,1]:=c;
end;

procedure sort(l,r:longint);
var
i,j,x:longint;
begin
 i:=l;j:=r;x:=p[(l+r) div 2,0];
 repeat
  while p[i,0]<x do inc(i);
  while p[j,0]>x do dec(j);
  if i<=j then
   begin
    swap(i,j);
    inc(i);dec(j);
   end;
 until i>j;
 if i<r then sort(i,r);
 if l<j then sort(l,j);
end;

procedure swap2(i,j:longint);
var
c:longint;
begin
c:=pp[i,0];
pp[i,0]:=pp[j,0];
pp[j,0]:=c;
c:=pp[i,1];
pp[i,1]:=pp[j,1];
pp[j,1]:=c;
end;

procedure sort2(l,r:longint);
var
i,j,x,y:longint;
begin
 i:=l;j:=r;x:=pp[(l+r) div 2,0];y:=pp[(l+r) div 2,1];
 repeat
  while (pp[i,0]<x)or((pp[i,0]=x)and(pp[i,1]<y)) do inc(i);
  while (pp[j,0]>x)or((pp[j,0]=x)and(pp[j,1]>y)) do dec(j);
  if i<=j then
   begin
    swap2(i,j);
    inc(i);dec(j);
   end;
 until i>j;
 if i<r then sort2(i,r);
 if l<j then sort2(l,j);
end;
procedure DFS(v:longint);
var
i:longint;
begin
if u[v] then exit;
u[v]:=true;
if bob[v,0]>0 then
 begin
  for i:=bob[v,0] to bob[v,1] do
   begin
    if not u[p[i,1]] then DFS(p[i,1]);
   end;
 end;
inc(uk);
och[uk]:=v;
end;

procedure DFS2(v:longint);
var
i:longint;
begin
if u[v] then exit;
u[v]:=true;
c[v]:=lc;
if bob[v,0]>0 then
 begin
  for i:=bob[v,0] to bob[v,1] do
   begin
    if not u[p[i,1]] then DFS2(p[i,1]);
   end;
 end;
end;

procedure Solve(v:longint);
var
i:longint;
begin
if u[v] then exit;
u[v]:=true;
if bob[v,0]>0 then
 begin
  for i:=bob[v,0] to bob[v,1] do
   begin
    if not u[pp[i,1]] then Solve(pp[i,1]);
   end;
 end else
 begin
  if not ad[v] then
   begin
    ad[v]:=true;
    inc(uk);
    och[uk]:=v;
   end;
 end;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n,m);
for i:=1 to m do
  read(p[i,0],p[i,1]);
sort(1,m);
fillchar(bob,sizeof(bob),0);
j:=p[1,0];
bob[j,0]:=1;
for i:=2 to m do
 begin
  if p[i,0]<>j then
   begin
    bob[j,1]:=i-1;
    j:=p[i,0];
    bob[j,0]:=i;
   end;
 end;
bob[j,1]:=m;

fillchar(u,sizeof(u),false);
uk:=0;
for i:=1 to n do
 begin
  if not u[i] then
   begin
    DFS(i);
   end;
 end;
//for i:=1 to n do write(och[i],' ');
//writeln;
lc:=0;
fillchar(u,sizeof(u),false);
for i:=1 to n do
 begin
  if not u[och[i]] then
   begin
    inc(lc);
    pr[lc]:=och[i];
    DFS2(och[i]);
   end;
 end;
if lc=1 then
 begin
  write('0');
  close(input);close(output);
  halt(0);
 end;
k:=0;
fillchar(ppc,sizeof(ppc),0);
for i:=1 to m do
 begin
  if c[p[i,0]]<>c[p[i,1]] then
   begin
    inc(k);
    ppc[c[p[i,1]]]:=2;
    pp[k,0]:=c[p[i,0]];
    pp[k,1]:=c[p[i,1]];
   end;
 end;
sort2(1,k);
fillchar(bob,sizeof(bob),0);
j:=pp[1,0];
bob[j,0]:=1;
for i:=2 to k do
 begin
  if pp[i,0]<>j then
   begin
    bob[j,1]:=i-1;
    j:=pp[i,0];
    bob[j,0]:=i;
   end;
 end;
bob[j,1]:=m;

uk:=0;
ruk:=0;
fillchar(u,sizeof(u),false);
fillchar(ad,sizeof(ad),false);
for i:=1 to lc do
 begin
  if not u[i] then
   begin
    if ppc[i]<>2 then
     begin
    ad[i]:=true;
    inc(ruk);
    roch[ruk]:=i;
    Solve(i);
     end;
   end;
 end;
{for i:=1 to n do write(c[i],' ');
writeln;
write('UK ');
for i:=1 to uk do write(och[i],' ');
for i:=1 to ruk do write(roch[i],' ');
writeln;writeln;}
if uk=0 then
 begin
  writeln(ruk);
  for i:=1 to ruk-1 do writeln(pr[roch[i]],' ',pr[roch[i+1]]);
  writeln(pr[roch[ruk]],' ',pr[roch[1]]);
 end else
 begin
 writeln(uk+ruk-1);
for i:=1 to uk-1 do
 begin
  writeln(pr[och[i]],' ',pr[och[i+1]]);
 end;
if ruk>0 then
 begin
  writeln(pr[och[uk]],' ',pr[roch[1]]);
  for i:=1 to ruk-1 do writeln(pr[roch[i]],' ',pr[roch[i+1]]);
 end else
 if uk>0 then writeln(pr[och[uk]],' ',pr[och[1]]);
end;
Close(input);Close(output);
end.
