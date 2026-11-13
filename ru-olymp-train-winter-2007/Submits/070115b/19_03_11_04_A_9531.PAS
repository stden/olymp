program aa;
const
tn = 'bridges';
maxn=20000;
maxm=200000;
var
n,m,k,i,j,ans,lastu,st:longint;
p:array[1..maxm,0..3] of longint;
bob:array[1..maxn,0..1] of longint;
u:array[1..maxn] of longint;
up:array[1..maxm] of boolean;
most:array[1..maxm] of longint;
pm:array[1..maxm] of boolean;


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
c:=p[i,2];
p[i,2]:=p[j,2];
p[j,2]:=c;
c:=p[i,3];
p[i,3]:=p[j,3];
p[j,3]:=c;
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

function min(x,y:longint):longint;
begin
 if x<y then min:=x else min:=y;
end;

function DFS(w:longint):longint;
var
i,j,mm,dd,v:longint;
begin
 v:=p[w,1];
 if u[v]>0 then exit;
 inc(lastu);
 u[v]:=lastu;
 mm:=u[v];
 dd:=maxlongint;
 for i:=bob[v,0] to bob[v,1] do
  begin
   if not up[p[i,2]] then
   begin
     up[p[i,2]]:=true;
     up[p[i,3]]:=true;
     if u[p[i,1]]>0 then mm:=min(mm,u[p[i,1]]) else dd:=min(dd,DFS(i));
   end;
  end;
 mm:=min(mm,dd);
 if (mm>=u[v])and(v<>st) then
  begin
   inc(ans);
   most[ans]:=p[w,2];
  end;
// writeln('LOG ',w,' ',v,' ',mm);
 DFS:=mm;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n,m);
for i:=1 to m do
 begin
  read(p[i,0],p[i,1]);
  p[m+i,0]:=p[i,1];
  p[m+i,1]:=p[i,0];
  p[i,2]:=i;
  p[m+i,2]:=i;
  p[i,3]:=m+i;
  p[m+i,3]:=i;
 end;
m:=m*2;
sort(1,m);

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

{for i:=1 to m do
 writeln(i,' ',p[i,0],' ',p[i,1],' ',p[i,2],' ',p[i,3]);
for i:=1 to n do
 begin
  writeln(bob[i,0],' ',bob[i,1]);
 end;}
ans:=0;
for st:=1 to n do
 begin
 p[m+1,0]:=0;
 p[m+1,1]:=st;

fillchar(u,sizeof(u),0);
fillchar(up,sizeof(up),false);
lastu:=1;
up[m+1]:=true;
DFS(m+1);
end;
fillchar(pm,sizeof(pm),false);
for i:=1 to ans do pm[most[i]]:=true;
ans:=0;
for i:=1 to m do
 begin
  if pm[i] then
   begin
    inc(ans);
    most[ans]:=i;
   end;
 end;
writeln(ans);
for i:=1 to ans do write(most[i],' ');
Close(input);Close(output);
end.
