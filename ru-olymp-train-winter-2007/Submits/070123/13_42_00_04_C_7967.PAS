program aa;
const
tn = 'tourism';
maxn=3;
maxm=maxn*maxn div 2;
maxk=maxn;
var
cv,m,n,k,i,j,uk,ukq,lte,c,v:longint;
s:string;
p:array[1..maxm,0..1] of word;
q:array[1..maxk] of word;
bob:array[0..maxn,0..1] of longint;
u:array[0..maxn] of byte;
pr:array[1..maxn] of word;
path:array[1..maxn] of byte;
ans:array[1..maxn,0..1] of word;
och:array[1..maxn] of word;
te:array[1..maxn] of longint;


procedure swap(i,j:longint);
var
c:longint;
begin
c:=q[i];
q[i]:=q[j];
q[j]:=c;
end;

procedure sort(l,r:longint);
var
i,j,x:longint;
begin
i:=l;j:=r;x:=q[(l+r) div 2];
repeat
 while q[i]<x do inc(i);
 while q[j]>x do dec(j);
 if i<=j then
  begin
   swap(i,j);
   inc(i);dec(j);
  end;
until i>j;
if i<r then sort(i,r);
if l<j then sort(l,j);
end;

procedure ReCalc(i:longint);
begin
  if s[i] in ['0'..'9'] then c:=ord(s[i])-ord('0') else
  if s[i] in ['A'..'Z'] then c:=ord(s[i])-ord('A')+10 else
  if s[i] in ['a'..'z'] then c:=ord(s[i])-ord('a')+36 else
  if s[i]='!' then c:=62 else c:=63;
end;

function BinSearch(l,r,x:longint):boolean;
var
m:longint;
begin
if (l<=0)or(r<=0) then
 begin
  BinSearch:=false;
  exit;
 end;
 if l=r then
  begin
   BinSearch := (p[l,1]=x);
   exit;
  end;
 m:=(l+r) div 2;
 if p[m,1]=x then BinSearch:=true else
 if p[m,1]<x then BinSearch:=BinSearch(m+1,r,x) else
 BinSearch:=BinSearch(l,m-1,x);
end;

procedure DFS(v,w,f:longint);
var
i:longint;
begin
 if u[v]>0 then
  begin
   if u[v]=1 then
    begin
     if path[w]=1 then
      begin
       path[w]:=2;
       ans[w,0]:=v;
       ans[w,1]:=f;
      end;
     exit;
    end;
    //Do something
   exit;
  end;
  inc(lte);
 te[v]:=lte;
 u[v]:=1;
 for i:=0 to n-1 do
  begin
   if i<>v then
    if BinSearch(bob[v,0],bob[v,1],i) or (not BinSearch(bob[i,0],bob[i,1],v)) then
     begin
      if u[i]=0 then pr[i]:=v;
      DFS(p[i,1],w+1,v);
     end;
  end;
 u[v]:=2;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
readln(n);
readln(s);
k:=length(s);
i:=1;
uk:=0;
v:=0;
m:=0;
cv:=0;
bob[0,0]:=1;
for i:=1 to n do bob[i,0]:=-1;
  ReCalc(1);
  j:=0;
  while (j<n-v-1) do
   begin
    if c and (1 shl uk)<>0 then
     begin
      inc(m);
      if v<>cv then
       begin
        bob[cv,1]:=m-1;
        cv:=v;
        bob[cv,0]:=m;
       end;
      p[m,0]:=v;
      p[m,1]:=v+1+j;
     end;
    if j=n-v-2 then
     begin
      inc(v);
      j:=0;
     end else inc(j);
    inc(uk);
    if uk>5 then
     begin
      uk:=0;
      inc(i);
      ReCalc(i);
     end;
   end;
bob[cv,1]:=m;
fillchar(u,sizeof(u),0);
fillchar(path,sizeof(path),0);
fillchar(ans,sizeof(ans),0);
read(k);
for i:=1 to k do
 begin
  read(q[i]);
  path[q[i]]:=1;
 end;
fillchar(te,sizeof(te),0);
lte:=0;
DFS(0,0,0);
for i:=1 to k do
 begin
  if q[i]=1 then writeln('0') else
  begin
   if path[q[i]]=1 then writeln('-1') else
    begin
     uk:=0;
     v:=ans[q[i],1];
     while v<>ans[q[i],0] do
      begin
       inc(uk);
       och[uk]:=v;
       v:=pr[v];
      end;
      write(ans[q[i],0],' ');
     for j:=uk downto 1 do write(och[j],' ');
     writeln;
    end;
  end;
 end;
Close(input);Close(output);
end.
