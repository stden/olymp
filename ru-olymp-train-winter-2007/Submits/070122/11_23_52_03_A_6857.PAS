{$M 16000000}
{$H+,B-}
//{$I+,Q+,R+,S+}
{$I-,Q-,R-,S-}
const
 maxN = 1000;
 maxE = 10000;
type
 int  = longint;
 Edge = record w,next:int; end;
var
 beg    :  array[1..maxN]of int;
 e      :  array[1..maxE]of Edge;
 act    :  array[1..maxE]of boolean;
 A,B,L  :  array[0..maxN]of int;
 F      :  array[0..maxN]of boolean;
 Q      :  array[0..maxN]of int;
 qh,qt  :  int;
 n1,n2,m,free,i,u,v,w,cu,cv,res,cnt:int;

procedure addEdge(v,w:int);
begin
 e[free].w:=w;
 e[free].next:=beg[v];
 beg[v]:=free;
 inc(free);
end;

function dfs(v:int):boolean;
var cur,w:int;
begin
 dfs:=true;
 if (v=0) then exit;
 F[v]:=false;
 cur:=beg[v];
 while (cur<>0) do begin
  w:=e[cur].w;
  if (act[cur])and(F[B[w]])and(L[B[w]]=L[v]+1)and(dfs(B[w])) then begin
   B[w]:=v; A[v]:=w; exit;
  end;
  cur:=e[cur].next;
 end;
 dfs:=false;
end;

procedure put(x,d:int);
begin
 F[x]:=true;
 L[x]:=d;
 Q[qt]:=x;
 inc(qt);
end;

function get:int;
begin
 get:=Q[qh]; inc(qh);
end;

function getMaxPS():int;
var cur,x,i,j,cnt:int;
begin
 cnt:=0;
 fillchar(A,sizeof(A),0);
 fillchar(B,sizeof(B),0);
 repeat
  qh:=0; qt:=0;
  fillchar(L,sizeof(L), 63);
  fillchar(F,sizeof(F), 0);
  for i:=1 to n1 do if (A[i]=0) then put(i,0);
  while (qh<qt) do begin
   x:=get; if (L[x]=L[0]) then break;
   cur:=beg[x];
   while (cur<>0) do begin
    j:=e[cur].w;
    if (act[cur])and(not F[B[j]]) then put(B[j],L[x]+1);
    cur:=e[cur].next;
   end;
  end;
  if (not F[0]) then break;
  for i:=1 to n1 do
   if (A[i]=0)and(dfs(i)) then inc(cnt);
 until false;
 getMaxPS:=cnt;
end;

Begin
 assign(input, 'pairs.in');
 reset(input);
 assign(output,'pairs.out');
 rewrite(output);
 read(n1,n2,m);
 free:=1;
 for i:=1 to m do begin
  read(v,w);
  addEdge(v,w);
 end;
 fillchar(act,sizeof(act),true);
 cnt := getMaxPS;
 res := 0;
 for u:=1 to n1 do begin
  cu:=beg[u];
  while (cu<>0) do begin
   for v:=u to n1 do begin
    cv:=beg[v];
    while (cv<>0) do begin
     fillchar(act,sizeof(act),true);
     act[cu]:=false; act[cv]:=false;
     if (cu<cv)and(getMaxPS()<cnt) then inc(res);
     cv:=e[cv].next;
    end;
   end;
   cu:=e[cu].next;
  end;
 end;
 writeln(res);
 close(output);
End.
