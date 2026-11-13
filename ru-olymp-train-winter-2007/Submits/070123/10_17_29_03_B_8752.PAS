{$M 16000000}
{$H-,B-}
{$I-,Q-,R-,S-}
const
 maxN = 2*100000;
 maxM =   300000;
type
 int  = longint;
 Edge = record w,next:int; end;
var
 beg,bo,color,list :  array[1..maxN]of int;
 e,eo   :  array[1..maxM]of Edge;
 A,B,L  :  array[0..maxN]of int;
 F      :  array[0..maxN]of boolean;
 Q      :  array[0..maxN]of int;
 qh,qt  :  int;
 n,num,free,k,i,v,w,cur:int;

procedure printAnswer(res:boolean);
begin
 if (res) then begin
  writeln('YES');
  for i:=1 to (n div 2) do
   write(A[i],' ');
 end else writeln('NO');
 close(output);
 halt(0);
end;

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
  if (F[B[w]])and(L[B[w]]=L[v]+1)and(dfs(B[w])) then begin
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
  for i:=1 to n do if (A[i]=0) then put(i,0);
  while (qh<qt) do begin
   x:=get; if (L[x]=L[0]) then break;
   cur:=beg[x];
   while (cur<>0) do begin
    j:=e[cur].w;
    if (not F[B[j]]) then put(B[j],L[x]+1);
    cur:=e[cur].next;
   end;
  end;
  if (not F[0]) then break;
  for i:=1 to n do
   if (A[i]=0)and(dfs(i)) then inc(cnt);
 until false;
 getMaxPS:=cnt;
end;
procedure dfs1(v:int);
var cur:int;
begin
 color[v]:=1;
 cur:=beg[v];
 while (cur<>0) do begin
  if (color[e[cur].w]=0) then dfs1(e[cur].w);
  cur:=e[cur].next;
 end;
 list[num]:=v; dec(num);
end;

procedure dfs2(v:int);
var cur:int;
begin
 color[v]:=num;
 cur:=beg[v];
 while (cur<>0) do begin
  if (color[e[cur].w]=0) then dfs2(e[cur].w);
  cur:=e[cur].next;
 end;
end;


Begin
 assign(input, 'omax.in');
 reset(input);
 assign(output,'omax.out');
 rewrite(output);
 read(n);
 free:=1;
 for v:=1 to n do begin
  read(k);
  for i:=1 to k do begin
   read(w);
   addEdge(v,w);
  end;
 end;
 //If not full
 if (getMaxPS<n) then printAnswer(false);
 //New graph
 for v:=1 to n do begin
  if (beg[v]<>0)and(e[beg[v]].w=A[v]) then
   beg[v]:=e[beg[v]].next;
  cur:=beg[v];
  while (cur<>0)and(e[cur].next<>0) do begin
   if (e[e[cur].next].w=A[v]) then begin
    e[cur].next:=e[e[cur].next].next;
    break;
   end;
   cur:=e[cur].next;
  end;
  addEdge(n+A[v],v);
 end;
 for v:=1 to n do begin
  cur:=beg[v];
  while (cur<>0) do begin
   e[cur].w:=n+e[cur].w;
   cur:=e[cur].next;
  end;
 end;
 n:=2*n;
 //Strongly connected components
 //first  dfs
 for v:=1 to n do begin
  color[v]:=0; list[v]:=0;
 end;
 num:=n;
 for v:=1 to n do
  if (color[v]=0) then dfs1(v);
 //At
 bo:=beg; eo:=e;
 free:=1;
 fillchar(beg,sizeof(beg),0);
 for v:=1 to n do begin
  cur:=bo[v];
  while (cur<>0) do begin
   addEdge(eo[cur].w,v);
   cur:=eo[cur].next;
  end;
 end;
 //second dfs
 for v:=1 to n do color[v]:=0;
 num:=0;
 for v:=1 to n do
  if (color[list[v]]=0) then begin
   inc(num);
   dfs2(list[v]);
  end;
 //Returning from At
 e:=eo; beg:=bo;
 //Res
 for v:=(n div 2)+1 to n do begin
  cur:=beg[v];
  while (cur<>0) do begin
   if (color[v]=color[e[cur].w]) then printAnswer(false);
   cur:=e[cur].next;
  end;
 end;
 printAnswer(true);
End.
