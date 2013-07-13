{$M 16000000}
//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
const
 maxN = 100000;
 maxM = 200000;
type
 int  = longint;
 Edge = record w,next:int; end;
var
 beg,bo,color,list,vert:array[1..maxN]of int;
 e,eo:array[1..maxM]of Edge;
 ok:array[1..maxN]of boolean;
 ans:array[1..maxM]of record v,w:int; end;
 n,m,num,free,cnt,i,v,w,cur:int;

procedure addEdge(v,w:int);
begin
 e[free].w:=w;
 e[free].next:=beg[v];
 beg[v]:=free;
 inc(free);
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

//v and w are SCCs
procedure addToRes(v,w:int);
begin
 inc(cnt);
 ans[cnt].v:=vert[v];
 ans[cnt].w:=vert[w];
end;

procedure dfs(v:int;tNC:boolean);
var cur:int;
begin
 color[v]:=1;
 cur:=beg[v];
 while (cur<>0) do begin
  if (color[e[cur].w]=0) then begin
   dfs(e[cur].w,tNC);
   tNC:=false;
  end;
  cur:=e[cur].next;
 end;
 if (beg[v]<>0) then exit;
 if (tNC) then begin
  addToRes(v,list[(i mod num)+1]); //from v to root of the next tree
 end else begin
  addToRes(v,list[i]); //from v to root of v's tree
 end;
end;

Begin
 assign(input, 'republic.in');
 reset(input);
 assign(output,'republic.out');
 rewrite(output);
 read(n,m);
 free:=1;
 fillchar(beg,sizeof(beg),0);
 for i:=1 to m do begin
  read(v,w);
  addEdge(v,w);
 end;
 //strongly connected components
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
 //decomposition
 for v:=1 to n do
  vert[color[v]]:=v;
 free:=1;
 fillchar(beg,sizeof(beg),0);
 fillchar(ok,sizeof(ok),true);
 for v:=1 to n do begin
  cur:=bo[v];
  while (cur<>0) do begin
   w:=eo[cur].w;
   if (color[v]<>color[w]) then begin
    addEdge(color[v],color[w]); //duplicate edges
    ok[color[w]]:=false;
   end;
   cur:=eo[cur].next;
  end;
 end;
 n:=num;
 //Solve
 num:=0;
 for v:=1 to n do
  if (ok[v]) then begin
   inc(num);
   list[num]:=v;
  end;
 cnt:=0;
 fillchar(color,sizeof(color),0);
 for i:=1 to num do
  dfs(list[i],true);
 //Out
 writeln(cnt);
 for i:=1 to cnt do
  writeln(ans[i].v,' ',ans[i].w);
 close(output);
End.
