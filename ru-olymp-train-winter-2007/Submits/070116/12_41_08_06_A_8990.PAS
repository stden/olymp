{$R-,S-,Q-,B-}
{$M 20000000}
uses SysUtils;

const taskid='map';

var u,v,n,m,i,j,k:longint;
    b,a:array [0..503,0..503] of boolean;
    d,p,c,d1,p1,c1,ans,ind:array [0..503] of longint;
    g,g1:array [0..503,0..503] of longint;
    t:double;

procedure swap(var a,b:longint);
 var t:longint;
 begin
 t:=a;
 a:=b;
 b:=t;
 end;

function dfs1(u:longint):longint;
 var i,j,r:longint;
 begin
 r:=0;
 d[u]:=0;
 for i:=1 to m do
  if a[u,i] and (i<>p[u]) then
   begin
   inc(d[u]);
   g[u,d[u]]:=i;
   p[i]:=u;
   r:=r+dfs1(i);
   end;
 c[u]:=r+1;
 for i:=1 to d[u]-1 do
  for j:=i+1 to d[u] do
   if c[g[u,i]]<c[g[u,j]] then swap(g[u,i],g[u,j]);
 dfs1:=c[u];
 end;

function dfs2(u:longint):longint;
 var i,j,r:longint;
 begin
 r:=0;
 d1[u]:=0;
 for i:=1 to n do
  if b[u,i] and (i<>p1[u]) then
   begin
   inc(d1[u]);
   g1[u,d1[u]]:=i;
   p1[i]:=u;
   r:=r+dfs2(i);
   end;
 c1[u]:=r+1;
 for i:=1 to d1[u]-1 do
  for j:=i+1 to d1[u] do
   if c1[g1[u,i]]<c1[g1[u,j]] then swap(g1[u,i],g1[u,j]);
 for i:=1 to d1[u] do ind[g1[u,i]]:=i;
 dfs2:=c1[u];
 end;

function merge(u,v:longint):boolean;

 var i,j:longint; r:boolean;

 procedure num(l:longint);
  var i:longint;
  begin
  if l=d[u]+1 then
   begin
   r:=true;
   exit;
   end;
  for i:=ind[ans[g[u,l-1]]]+1 to d1[v]-d[u]+l do
   begin
   ans[g[u,l]]:=g1[v,i];
   if merge(g[u,l],g1[v,i]) then num(l+1);
   if r then exit;
   end;
  end;

 begin
 if d[u]>d1[v] then
  begin
  merge:=false;
  exit;
  end;
 r:=false;
 num(1);
 merge:=r;
 end;

begin
t:=timestamptomsecs(datetimetotimestamp(now));
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(a,sizeof(a),0);
fillchar(b,sizeof(b),0);
readln(m);
for i:=1 to m-1 do
 begin
 readln(u,v);
 a[u,v]:=true;
 a[v,u]:=true;
 end;
readln(n);
for i:=1 to n-1 do
 begin
 readln(u,v);
 b[u,v]:=true;
 b[v,u]:=true;
 end;
fillchar(g,sizeof(g),0);
ans[0]:=0;
ind[0]:=0;
p[1]:=0;
dfs1(1);
for i:=1 to n do
 begin
 p1[i]:=0;
 dfs2(i);
 ans[1]:=i;
 if merge(1,i) then
  begin
  writeln('YES');
  for j:=1 to m do write(ans[j],' ');
  close(output);
  halt(0);
  end;
 if t-timestamptomsecs(datetimetotimestamp(now))>1900 then break;
 end;
writeln('NO');
close(output);
end.
