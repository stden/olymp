//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
const
 INF  = 1000000001;
 maxN = 50000;
type
 int  = longint;
 edge = record w,next:int; end;
var
 beg,deg,d,list,prev,pn:array[1..maxN]of int;
 e:array[1..2*maxN]of edge;
 c:array[1..maxN]of boolean;
 ans:array[1..maxN]of record u,v:int; end;
 n,free,cnt,k:int;
 u,v,x,i,cur:int;

procedure addEdge(v,w:int);
begin
 e[free].w:=w;
 e[free].next:=beg[v];
 beg[v]:=free;
 inc(free);
end;

procedure bfs;
var
 p,q,v,w,cur:int;
begin
 p:=1; q:=0;
 for i:=1 to n do
  if (c[i]) then begin
   pn[i]:=0;
   prev[i]:=0;
   d[i]:=0;
   inc(q);
   list[q]:=i;
  end else d[i]:=INF;
 while (p<=q) do begin
  v:=list[p]; inc(p);
  cur:=beg[v];
  while (cur<>0) do begin
   w:=e[cur].w;
   if (d[w]=INF) then begin
    d[w]:=d[v]+1;
    prev[w]:=v;
    if (c[v]) then pn[w]:=w else pn[w]:=pn[v];
    inc(q);
    list[q]:=w;
   end;
   cur:=e[cur].next;
  end;
 end;
end;

function rtp(u:int):int;
begin
 while (not c[u]) do begin
  c[u]:=true; inc(cnt);
  u:=prev[u];
 end;
 rtp:=u;
end;

Begin
 assign(input, 'biconn.in');
 reset(input);
 assign(output,'biconn.out');
 rewrite(output);
 read(n);
 fillchar(deg,sizeof(deg),0);
 fillchar(beg,sizeof(beg),0);
 free:=1;
 for i:=1 to n-1 do begin
  read(u,v);
  inc(deg[u]); inc(deg[v]);
  addEdge(u,v);
  addEdge(v,u);
 end;
 x:=1;
 for i:=1 to n do
  if (deg[i]=1) then x:=i;
 fillchar(c,sizeof(c),false);
 c[x]:=true;
 cnt:=1;
 k:=0;
 while (cnt<n) do begin
  bfs;
  u:=1;
  for i:=1 to n do
   if (not c[i])and((c[u])or(d[i]>d[u])) then u:=i;
  v:=1;
  for i:=1 to n do
   if (not c[i])and(pn[i]<>pn[u]) then v:=i;
  if (pn[u]<>pn[v]) then begin
   inc(k);
   ans[k].u:=u; ans[k].v:=v;
   rtp(u);
   rtp(v);
  end else begin
   if (cnt<>n-1) then begin
    v:=rtp(u);
    inc(k);
    ans[k].u:=u; ans[k].v:=v;
   end else begin
    inc(cnt);
    //now C is "ok"
    cur:=beg[u];
    while (cur<>0) do begin
     c[e[cur].w]:=false;
     cur:=e[cur].next;
    end;
    for v:=1 to n do
     if (c[v]) then break;
    inc(k);
    ans[k].u:=u; ans[k].v:=v;
   end;
  end;
 end;
 writeln(k);
 for i:=1 to k do
  writeln(ans[i].u,' ',ans[i].v);
 close(output);
End.
