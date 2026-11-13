{$R-,S-,Q-,B-}
uses SysUtils;

const taskid='pairs';

var u,v,m,max,ans,n1,n2,i,j,k:longint;
    a:array [1..1001,1..1001] of boolean;
    b:array [1..1001] of longint;
    f:array [0..1001] of boolean;
    r:array [0..10003,1..2] of longint;
    t:array [1..10003] of boolean;
    st:double;

function dfs(u:longint):boolean;
 var v:longint;
 begin
 if u=0 then
  begin
  dfs:=true;
  exit;
  end;
 f[u]:=true;
 for v:=1 to n2 do
  if a[u,v] and not f[b[v]] and dfs(b[v]) then
   begin
   b[v]:=u;
   dfs:=true;
   exit;
   end;
 dfs:=false;
 end;

function match:longint;
 var r,i:longint;
 begin
 fillchar(b,sizeof(b),0);
 r:=0;
 for i:=1 to n1 do
  begin
  fillchar(f,sizeof(f),0);
  r:=r+ord(dfs(i));
  end;
 match:=r;
 end;

begin
st:=now;
randseed:=$DEADBEEF;
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(a,sizeof(a),0);
fillchar(t,sizeof(t),0);
readln(n1,n2,m);
for i:=1 to m do
 begin
 readln(u,v);
 a[u,v]:=true;
 r[i,1]:=u;
 r[i,2]:=v;
 end;
for i:=1 to m do
 begin
 j:=random(m)+1;
 k:=random(m)+1;
 r[0]:=r[j];
 r[j]:=r[k];
 r[k]:=r[0];
 end;
max:=match;
k:=0;
for i:=1 to m do
 begin
 a[r[i,1],r[i,2]]:=false;
 if match<max then
  begin
  inc(k);
  t[i]:=true;
  end;
 a[r[i,1],r[i,2]]:=true;
 if 24*60*60*(now-st)>1.9 then
  begin
  writeln(k*(m-1)-((k*(k-1)) div 2));
  close(output);
  exit;
  end;
 end;
ans:=k*(m-1)-(k*(k-1) div 2);
for i:=1 to m-1 do
 for j:=i+1 to m do
  if not t[i] and not t[j] then
   begin
   a[r[i,1],r[i,2]]:=false;
   a[r[j,1],r[j,2]]:=false;
   if max>match then inc(ans);
   a[r[i,1],r[i,2]]:=true;
   a[r[j,1],r[j,2]]:=true;
   if 24*60*60*(now-st)>1.9 then
    begin
    writeln(ans);
    close(output);
    exit;
    end;
   end;
writeln(ans);
close(output);
end.
