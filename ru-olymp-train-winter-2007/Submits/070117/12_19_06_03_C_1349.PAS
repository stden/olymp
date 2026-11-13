//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
uses
 SysUtils, Math;
const
 INF  = 1000000001;
 maxN = 30;
type
 int  = longint;
 Matrix = array[1..maxN,1..maxN]of int64;
var
 a,b:Matrix;
 d,dist,kol:array[1..maxN]of int;
 k,kn:array[1..maxN]of int64;
 n,m,t,st,i,u,v:int;
 res,p:int64;

function exp(a:int64;n:int):int64;
var res:int64;
begin
 res:=1;
 while (n>0) do begin
  if (odd(n)) then res := (res*a) mod p;
  a := (a*a) mod p;
  n := n div 2;
 end;
 exp:=res;
end;

function mul(const a,b:Matrix):Matrix;
var
 res:Matrix;
 i,j,k:int;
begin
 fillchar(res,sizeof(res),0);
 for i:=1 to n do
  for j:=1 to n do
   for k:=1 to n do
    res[i,j]:=(res[i,j] + a[i,k]*b[k,j]) mod p;
 mul:=res;
end;

function exp(a:Matrix;pow:int):Matrix;
var
 res:Matrix;
 i:int;
begin
 fillchar(res,sizeof(res),0);
 for i:=1 to n do res[i,i]:=1;
 while (pow>0) do begin
  if (odd(pow)) then res := mul(res, a);
  a := mul(a,a);
  pow := pow div 2;
 end;
 exp:=res;
end;

procedure bfs(st:int);
var
 list:array[1..maxN]of int;
 i,p,q,v,w:int;
begin
 for i:=1 to n do d[i]:=INF;
 d[st]:=0;
 p:=1; list[p]:=st;
 q:=1;
 while (p<=q) do begin
  v:=list[p]; inc(p);
  for w:=1 to n do
   if (a[v,w]=1)and(d[w]=INF) then begin
    d[w]:=d[v]+1;
    inc(q); list[q]:=w;
   end;
 end;
end;

Begin
 assign(input, 'restore.in');
 reset(input);
 assign(output,'restore.out');
 rewrite(output);
 read(n,m,p);
 fillchar(a,sizeof(a),0);
 for i:=1 to m do begin
  read(u,v);
  a[u,v]:=1; a[v,u]:=1;
 end;
 read(st);
 read(t);
 for i:=1 to t do begin
  read(dist[i],kol[i]);
 end;
 //finding D
 bfs(st);
 //Solve
 for i:=1 to n do
  if (d[i]=dist[1])
   then k[i]:=1
   else k[i]:=0;
 for i:=1 to t do begin
  //going to that distance
  if (i>1) then begin
   fillchar(kn,sizeof(kn),0);
   for u:=1 to n do
    for v:=1 to n do
     if (a[u,v]=1)and(d[v]=dist[i]) then kn[v]:=(kn[v]+k[u]) mod p;
   k:=kn;
  end;
  //kol[i]-1 times on same D
  b:=a;
  for u:=1 to n do
   for v:=1 to n do
    if (d[u]<>dist[i])or(d[v]<>dist[i])
     then b[u,v]:=0;
  b:=exp(b,kol[i]-1);
  fillchar(kn,sizeof(kn),0);
  for u:=1 to n do
   for v:=1 to n do
    kn[u] := (kn[u] + k[v]*b[u,v]) mod p;
  for u:=1 to n do
   if (d[u]<>dist[i]) then k[u]:=0;
  k:=kn;
 end;
 //Out
 res:=0;
 for i:=1 to n do res:=(res+k[i]) mod p;
 writeln(res);

 close(output);
End.
