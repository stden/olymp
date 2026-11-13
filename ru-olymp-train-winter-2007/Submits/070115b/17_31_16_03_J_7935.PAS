{$O3,B-,I-,Q-,R-,S-}
const
 INF  = 1000000001;
 maxN = 30000;
 maxE = 400000;
type
 int  = longint;
 TRec = record
  val,id:int;
 end;
var
 h,pos,id,d,beg:array[1..maxN]of int;
 e:array[1..2*maxE]of record w,cost,next:int; end;
 n,m,hs,free:int;
 i,v,w,cost:int;

procedure addEdge(v,w,cost:int);
begin
 e[free].w:=w; e[free].cost:=cost;
 e[free].next:=beg[v];
 beg[v]:=free;
 inc(free);
end;

procedure swap(i,j:int);inline;
var t:int;
begin
 t:=h[i]; h[i]:=h[j]; h[j]:=t;
 pos[id[i]]:=j; pos[id[j]]:=i;
 t:=id[i]; id[i]:=id[j]; id[j]:=t;
end;

procedure siftup(i:int);
begin
 while ((i div 2)>=1) do begin
  if (h[i]<h[i div 2]) then begin
   swap(i, i div 2);
   i:=i div 2;
  end;
 end;
end;

procedure siftdown(i:int);
var j:int;
begin
 while (2*i<=hs) do begin
  if (h[2*i]<h[i]) then j:=2*i else j:=i;
  if (2*i+1<=hs)and(h[2*i+1]<h[j]) then j:=2*i+1;
  if (i=j) then break;
  swap(i,j);
  i:=j;
 end;
end;

procedure add(elID, val:int);
begin
 inc(hs);
 h[hs]:=val; id[hs]:=elID; pos[elID]:=hs;
 siftup(hs);
end;

function extractMin():TRec;
var res:TRec;
begin;
 res.val:=h[1]; res.id:=id[1];
 swap(1,hs);
 dec(hs);
 siftdown(1);
 extractMin:=res;
end;

procedure relax(v,dist:int);
begin
 if (h[pos[v]]>dist) then begin
  h[pos[v]]:=dist;
  siftup(pos[v]);
 end;
end;

procedure dijkstra(st:int);
var
 tmp:TRec;
 v,i,cur:int;
begin
 hs:=0;
 for i:=1 to n do
  add(i, INF);
 relax(st,0);
 while (hs>0) do begin
  tmp:=extractMin();
  v:=tmp.id; d[v]:=tmp.val;
  cur:=beg[v];
  while (cur<>0) do begin
   relax(e[cur].w,d[v]+e[cur].cost);
   cur:=e[cur].next;
  end;
 end;
end;

Begin
 assign(input, 'path.in');
 reset(input);
 assign(output,'path.out');
 rewrite(output);
 readln(n,m);
 free:=1;
 fillchar(beg,sizeof(beg),0);
 for i:=1 to m do begin
  read(v,w,cost);
  addEdge(v,w,cost);
  addEdge(w,v,cost);
 end;
 dijkstra(1);
 for i:=1 to n do
  write(d[i],' ');
 close(output);
End.
