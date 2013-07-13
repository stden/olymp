{$R-,S-,Q-,B-}
{$M 16000000}

const taskid='omax';

var cc,t,n,i,j,k,x,cnt:longint;
    s,p,s1,p1,a,b,l:array [0..100003] of longint;
    f:array [0..100003] of boolean;
    g,g1:array [1..300003] of longint;
    q:array [0..100003] of longint;
    qh,qt:longint;
    r,c:array [1..200003,1..2] of longint;
    f1:array [1..100003,1..2] of boolean;

function dfs(u:longint):boolean;
 var j:longint;
 begin
 dfs:=true;
 if u=0 then exit;
 f[u]:=false;
 for j:=p[u] to p[u]+s[u]-1 do
  if f[b[g[j]]] and (l[b[g[j]]]=l[u]+1) and dfs(b[g[j]]) then
   begin
   b[g[j]]:=u;
   a[u]:=g[j];
   exit;
   end;
 dfs:=false;
 end;

procedure put(x,d:longint);
 begin
 f[x]:=true;
 l[x]:=d;
 q[qt]:=x;
 inc(qt);
 end;

function get:longint;
 begin
 get:=q[qh];
 inc(qh);
 end;

procedure dfs1(u,j:longint);
 var i:longint;
 begin
 f1[u,j]:=true;
 if j=1 then
  begin
  if not f1[a[u],2] then dfs1(a[u],2)
  end
 else
  begin
  for i:=p1[u] to p1[u]+s1[u]-1 do
   if (g1[i]<>b[u]) and not f1[g1[i],1] then dfs1(g1[i],1);
  end;
 inc(t);
 r[t,1]:=u;
 r[t,2]:=j;
 end;

procedure sfd1(u,j:longint);
 var i:longint;
 begin
 c[u,j]:=cc;
 if j=1 then
  begin
  for i:=p[u] to p[u]+s[u]-1 do
   if (g[i]<>a[u]) and (c[g[i],2]=0) then sfd1(g[i],2);
  end
 else
  begin
  if c[b[u],1]=0 then sfd1(b[u],1);
  end;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n);
p[0]:=1;
s[0]:=0;
for i:=1 to n do
 begin
 read(s[i]);
 p[i]:=p[i-1]+s[i-1];
 for j:=1 to s[i] do read(g[p[i]+j-1]);
 readln;
 end;
cnt:=0;
while true do
 begin
 qh:=0;
 qt:=0;
 fillchar(l,sizeof(l),63);
 fillchar(f,sizeof(f),0);
 for i:=1 to n do if a[i]=0 then put(i,0);
 while qh<qt do
  begin
  x:=get;
  if l[x]=l[0] then break;
  for j:=p[x] to p[x]+s[x]-1 do
   if not f[b[g[j]]] then put(b[g[j]],l[x]+1);
  end;
 if not f[0] then break;
 for i:=1 to n do
  if (a[i]=0) and dfs(i) then inc(cnt);
 end;
if cnt<n then
 begin
 writeln('NO');
 close(output);
 halt(0);
 end;
fillchar(s1,sizeof(s1),0);
for i:=1 to n do
 for j:=p[i] to p[i]+s[i]-1 do inc(s1[g[j]]);
p1[0]:=1;
s1[0]:=0;
for i:=1 to n do p1[i]:=p1[i-1]+s1[i-1];
for i:=1 to n do
 for j:=p[i] to p[i]+s[i]-1 do
  begin
  g1[p1[g[j]]]:=i;
  inc(p1[g[j]]);
  end;
for i:=1 to n do p1[i]:=p1[i-1]+s1[i-1];
t:=0;
fillchar(f1,sizeof(f1),0);
for i:=1 to n do
 for j:=1 to 2 do
  if not f1[i,j] then dfs1(i,j);
cc:=0;
for i:=2*n downto 1 do
 if c[r[i,1],r[i,2]]=0 then
  begin
  inc(cc);
  sfd1(r[i,1],r[i,2]);
  end;
for i:=1 to n do
 if c[i,1]=c[a[i],2] then
  begin
  writeln('NO');
  close(output);
  halt(0);
  end;
writeln('YES');
for i:=1 to n do write(a[i],' ');
writeln;
close(output);
end.
