{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 INF  = 1000000001;
 maxN = 20000;
 maxE = 200000;
type
 int  = longint;
var
 beg,color,list:array[1..maxN]of int;
 e:array[1..maxE]of record w,next,num:int; act:boolean; end;
 ans:array[1..maxE]of int;
 n,m,num,free,v,w,cur,cnt,i:int;

procedure addEdge(v,w,num:int);
begin
 e[free].w:=w; e[free].act:=true;
 e[free].num:=num;
 e[free].next:=beg[v];
 beg[v]:=free;
 inc(free);
end;

procedure dfs1(v:int);
var cur,w:int;
begin
 color[v]:=1;
 inc(num); list[num]:=v;
 cur:=beg[v];
 while (cur<>0) do begin
  w:=e[cur].w;
  if (color[w]=0) then begin
   dfs1(w);
   e[cur].act:=false;
  end;
  cur:=e[cur].next;
 end;
end;

procedure dfs2(v:int);
var cur,w:int;
begin
 color[v]:=num;
 cur:=beg[v];
 while (cur<>0) do begin
  w:=e[cur].w;
  if (color[w]=0)and(e[cur].act)
   then dfs2(w);
  cur:=e[cur].next;
 end;
end;

Begin
 assign(input, 'bridges.in');
 reset(input);
 assign(output,'bridges.out');
 rewrite(output);
 //input
 read(n,m);
 fillchar(beg,sizeof(beg),0);
 free:=1;
 for i:=1 to m do begin
  read(v,w);
  addEdge(v,w,i);
  addEdge(w,v,i);
 end;
 //first dfs
 fillchar(color,sizeof(color),0);
 fillchar(list,sizeof(list),0);
 num:=0;
 for v:=1 to n do
  if (color[v]=0) then dfs1(v);
 //second dfs
 fillchar(color,sizeof(color),0);
 num:=0;
 for v:=1 to n do
  if (color[list[v]]=0) then begin
   inc(num);
   dfs2(list[v]);
  end;
 //out
 cnt:=0;
 for v:=1 to n do begin
  cur:=beg[v];
  while (cur<>0) do begin
   w:=e[cur].w;
   if (color[v]<>color[w])and(v<w) then begin
    inc(cnt);
    ans[cnt]:=e[cur].num;
   end;
   cur:=e[cur].next;
  end;
 end;
 writeln(cnt);
 for i:=1 to cnt do
  writeln(ans[cnt]);
 close(output);
End.
