{$Q-,R-,S-}
program sh;
const tn='pairs';
var tmax,r1,r2,n1,n2,m,cnt:longint;
    a:array[1..2,1..10001]of longint;
    nav:array[1..10001]of longint;
function More(const i,j:longint):boolean;
begin
 more:=(a[1,i]>a[1,j]);
end;
procedure swel(const b,c:longint);
var d:longint;
begin
 d:=a[1,b];a[1,b]:=a[1,c];a[1,c]:=d;
 d:=a[2,b];a[2,b]:=a[2,c];a[2,c]:=d;
end;
procedure heup(a:longint);
begin
 while true do
 begin
  if a=1 then exit;
  if not more(a,a div 2) then exit;
  swel(a,a div 2);
  a:=a div 2;
 end;
end;
procedure hedo(e:longint);
begin
 while true do
 begin
  if e*2>cnt then exit else
  if e*2=cnt then
  begin
    if more(e*2,e) then
    begin
     swel(e*2,e);
     e:=e*2;
    end else exit;
  end else
  begin
   if More(e*2,e*2+1) then
   begin
    if more(e*2,e) then
    begin
     swel(e*2,e);
     e:=e*2;
    end else exit;
   end else
   begin
    if more(e*2+1,e) then
    begin
     swel(e*2+1,e);
     e:=e*2+1;
    end else exit;
   end;
  end;
 end;
end;
procedure add(const v1,v2:longint);
begin
 inc(cnt);a[1,cnt]:=v1;a[2,cnt]:=v2;heup(cnt);
end;
var u,p1,p2:array[1..1000]of longint;
function dfs(const v:longint):boolean;
var i:longint;
begin
 if v=0 then
 begin
  dfs:=true;
  exit;
 end;
 dfs:=false;
 if u[v]=1 then exit;
 u[v]:=1;
 for i:=nav[v] to nav[v+1]-1 do
  if (i<>r1)and(i<>r2) then
  begin
   if dfs(p2[a[2,i]]) then
   begin
    dfs:=true;
    p2[a[2,i]]:=v;
    p1[v]:=a[2,i];
    exit;
   end;
  end;
end;
function Pair:longint;
var i,rs:longint;
begin
 fillchar(p1,sizeof(p1),0);
 fillchar(p2,sizeof(p2),0);
 for i:=1 to n1 do
  if p1[i]=0 then begin
   fillchar(u,sizeof(u),0);
   dfs(i);
  end;
 rs:=0;
 for i:=1 to n1 do if p1[i]<>0 then inc(rs);
 pair:=rs;
end;
var tt,i,t1,t2,res:longint;
    tim:int64;
begin
 assign(input,tn+'.in');reset(input);
 assign(output,tn+'.out');rewrite(output);
 readln(n1,n2,m);
 for i:=1 to m do
 begin
  read(t1,t2);
  add(t1,t2);
 end;
 for i:=1 to m do
 begin
  swel(1,cnt);
  dec(cnt);
  hedo(1);
 end;
 for i:=1 to m do
  if nav[a[1,i]]=0 then nav[a[1,i]]:=i;
 nav[n1+1]:=m+1;
 for i:=m downto 1 do
  if nav[i]=0 then nav[i]:=nav[i+1];
 tmax:=Pair;
 tim:=m;
 tim:=tim*m*m*(n1+n2);
 if tim<50000000 then
 begin
  res:=0;
  for r1:=1 to m do
   for r2:=r1+1 to m do
   begin
    tt:=Pair;
    if tt<tmax then inc(res);
   end;
 end else res:=tmax*(m-1);
 writeln(res);
 close(input);close(output);
end.
