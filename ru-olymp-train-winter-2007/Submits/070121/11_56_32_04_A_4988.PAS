program aa;
const
tn = 'geology';
maxn=131072;
var
n,k,i,j,cnt,ukR,root,x,y:longint;
ch:char;
s:string;
a:array[1..2*maxn-1] of record
                     lc,rc,l,r,pr:longint;
                     s:extended;
                     leaf:boolean;
                     val:longint;
                    end;

function lca(i,j:longint):longint;
begin
while (i<>j)and(i<>root)and(j<>root) do
 begin
  i:=a[i].pr;
  j:=a[j].pr;
 end;
if i=j then lca:=i else lca:=root;
end;

function Query(i,j:longint):extended;
var
v:longint;
begin
if i>=j then
 begin
  Query:=0;
  exit;
 end;
v:=lca(i,j);
//writeln('LOG ',i,' ',j,' ',v,' ',a[v].s);
Query:=a[v].s-Query(a[v].l,i)-Query(j,a[v].r);
end;

{procedure Update(v:longint);
begin
if a[v].leaf then exit;
if (a[v].lc>0)and(a[v].rc>0) then
 begin
if a[a[v].lc].leaf then
 begin

 end else
 begin
if a[v].lc>0 then Update(a[v].lc);
of a[v].rc>0 then Update(a[v].rc);
a[v].s:=0;
if a[v].lc>0 then a[v].s:=a[v].s+a[a[v].lc].s;
if a[v].rc>0 then a[v].s:=a[v].s+a[a[v].rc].s;
 end;
 end;
end;}

function max(x,y:longint):longint;
begin
 if x>y then max:=x else max:=y;
end;

procedure Add(v,x,p:longint);
begin
if a[v].leaf then
 begin
  a[v].val:=a[v].val+max(p-abs(x-v),0);
  exit;
 end;
Add(a[v].lc,x,p);
Add(a[v].rc,x,p);
a[v].s:=a[a[v].lc].s+a[a[v].rc].s+(a[a[a[v].lc].r].val+a[a[a[v].rc].l].val)/2;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
readln(n);
cnt:=maxn;
for i:=1 to maxn do
 begin
  a[i].l:=i;
  a[i].r:=i;
 end;
i:=1;
while (i<=maxn) do
 begin
  a[i].val:=0;
  inc(cnt);
  a[cnt].lc:=i;
  a[cnt].leaf:=false;
  a[cnt].rc:=i+1;
  a[cnt].l:=a[a[cnt].lc].l;
  a[cnt].r:=a[a[cnt].rc].r;
  a[i].pr:=cnt;
  a[i].leaf:=true;
  a[i+1].leaf:=true;
  a[i+1].pr:=cnt;
  a[cnt].s:=0;
  i:=i+2;
 end;
ukR:=maxn+1;
while (ukR<cnt) do
 begin
  inc(cnt);
  a[cnt].lc:=ukR;
  a[cnt].rc:=ukR+1;
  a[cnt].leaf:=false;
  a[cnt].l:=a[ukR].l;
  a[cnt].r:=a[ukR+1].r;
  a[ukR].pr:=cnt;
  a[ukR+1].pr:=cnt;
  a[cnt].s:=0;
  ukR:=ukR+2;
 end;
root:=cnt;

for i:=1 to n do
 begin
  read(ch);
  s:='';
  while ch<>' ' do
   begin
    s:=s+ch;
    read(ch);
   end;
  readln(x,y);
  if s[1]='A' then Add(lca(x-y,x+y),x,y) else writeln(Query(x,y):0:3);
 end;
Close(input);Close(output);
end.
