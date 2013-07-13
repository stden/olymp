program aa;
const
tn = 'beauty';
maxn=100;
var
a:array[1..10000] of record
                      pr,sl,c:longint;
                      b:char;
                      ch:array[1..26] of longint;
                      d:array[1..maxn] of record
                                           maxc,prv:longint;
                                          end;
                     end;
n,k,i,j,ans,uk,cnt:longint;
ansv:longint;
ch:char;
s:string;
anz:array[1..maxn] of char;

procedure Add(s:string;x:longint);
var
i,v,j:longint;
begin
v:=1;
i:=1;
while a[v].ch[ord(s[i])-ord('a')+1]<>0 do
 begin
  v:=a[v].ch[ord(s[i])-ord('a')+1];
  inc(i);
 end;
while i<=length(s) do
 begin
  inc(cnt);
  a[cnt].pr:=v;
  a[cnt].b:=s[i];
  for j:=1 to 26 do
   begin
    a[cnt].ch[j]:=0;
   end;
  for j:=1 to maxn do
   begin
    a[cnt].d[j].maxc:=-maxlongint;
   end;
  if i=length(s) then a[cnt].c:=x;
  a[v].ch[ord(s[i])-ord('a')+1]:=cnt;
  inc(i);
  v:=cnt;
 end;
end;

procedure SLink(v:longint);
var
x,i:longint;
begin
if a[v].pr<>1 then
begin
x:=a[v].pr;
x:=a[x].pr;
while (a[x].ch[ord(a[v].b)-ord('a')+1]=0)and(x<>1) do
 begin
  x:=a[x].pr;
 end;
a[v].sl:=a[x].ch[ord(a[v].b)-ord('a')+1];
end else a[v].sl:=1;
for i:=1 to 26 do
 begin
  if a[v].ch[i]<>0 then SLink(a[v].ch[i]);
 end;
end;

procedure DFS(v,k:longint);
var
i:longint;
begin
//writeln('ENT ',v,' ',k);
if v<=0 then exit;
if k>=n then exit;
for i:=1 to 26 do
 begin
  if a[v].ch[i]<>0 then
   begin
    if a[a[v].ch[i]].d[k+1].maxc<a[v].d[k].maxc+a[a[v].ch[i]].c then
     begin
      a[a[v].ch[i]].d[k+1].maxc:=a[v].d[k].maxc+a[a[v].ch[i]].c;
      a[a[v].ch[i]].d[k+1].prv:=v;
      DFS(a[v].ch[i],k+1);
     end;
   end;
 end;

if a[a[v].sl].d[k].maxc<a[v].d[k].maxc+a[a[v].sl].c then
 begin
  a[a[v].sl].d[k].maxc:=a[v].d[k].maxc+a[a[v].sl].c;
  a[a[v].sl].d[k].prv:=v;
  DFS(a[v].sl,k);
 end;
end;

procedure GetAns(v:longint);
var
i:longint;
begin
if (a[v].d[n].maxc>ans) then
 begin
  ans:=a[v].d[n].maxc;
  ansv:=v;
 end;
for i:=1 to 26 do
 begin
  if a[v].ch[i]<>0 then GetAns(a[v].ch[i]);
 end;
end;

procedure GetPath(v,k:longint);
begin
if (v<=1) then exit;
inc(uk);
anz[uk]:=a[v].b;
GetPath(a[v].d[k].prv,k-1);
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
readln(k);
a[1].pr:=0;
a[1].sl:=0;
a[1].c:=0;
for i:=1 to n do a[1].d[i].maxc:=-maxlongint;
for i:=1 to n do a[1].ch[i]:=0;
cnt:=1;
for i:=1 to k do
 begin
  while not (ch in ['a'..'z']) do read(ch);
  s:='';
  while ch in ['a'..'z'] do
   begin
    s:=s+ch;
    read(ch);
   end;
  read(j);
  Add(s,j);
 end;
read(n);
//close(input);close(output);
//halt(0);
for i:=1 to 26 do
 begin
  if a[1].ch[i]<>0 then SLink(a[1].ch[i]);
 end;
ans:=-maxlongint;
a[1].d[0].maxc:=0;
DFS(1,0);
GetAns(1);
writeln(ans);
uk:=0;
i:=n;
GetPath(ansv,n);
{for i:=1 to cnt do
 begin
  for j:=1 to n do
   begin
    write(a[i].d[j].maxc,' ');
   end;
  writeln;
 end;}
for i:=n downto 1 do write(anz[i]);
Close(input);Close(output);
end.
