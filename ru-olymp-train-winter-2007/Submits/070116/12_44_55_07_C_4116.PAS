//Written by Assaron
//assaron@mail.ru
type
integer=longint;
plist=^tlist;
tlist=record
  next:plist;
  v:integer;
end;
var
way:array[1..50000]of integer;
edges:array[1..50000]of plist;
last,marked:array[1..50000]of boolean;
n:integer;
deleted:integer;
max:integer;
maxv:integer;
function findway(u,v,k:integer):boolean;
var
p:plist;
begin
  marked[u]:=true;
  if u=v then begin
    findway:=true;
    way[k]:=v;
    exit;
  end;
  p:=edges[u];
  while p<>nil do begin
    if not marked[p^.v] and findway(p^.v,v,k+1) then begin
      findway:=true;
      way[k]:=u;
      exit;
    end;
    p:=p^.next;
  end;
  findway:=false;
end;
procedure addedge(u,v:integer);
var
p:plist;
begin
  p:=new(plist);
  p^.v:=v;
  p^.next:=edges[u];
  edges[u]:=p;
end;
procedure dfs(v:integer;deapth:integer);
var
p:plist;
begin
  if deapth>max then begin
    max:=deapth;
    maxv:=v;
  end;
  marked[v]:=true;
  p:=edges[v];
  while (p<>nil) do begin
    if not marked[p^.v] then dfs(p^.v,deapth+1);
    p:=p^.next;
  end;
end;
function delete(u,v:integer):integer;
var
p:plist;
t:plist;
i:integer;
len:integer;
begin
  for i:=1 to n do marked[i]:=false;
  findway(u,v,1);
  for i:=1 to n do marked[i]:=false;
  i:=0;
  repeat
    inc(i);
    marked[way[i]]:=true;
  until way[i]=v;
  len:=i;
  p:=edges[u];
  while (p<>nil) and marked[p^.v] do begin
    edges[u]:=p^.next;
    freemem(p);
    p:=edges[u];
  end;
  t:=p;
  while p<>nil do begin
    if marked[p^.v] then begin
      t^.next:=p^.next;
      freemem(p);
      p:=t^.next;
    end else begin
      t:=p;
      p:=p^.next;
    end;
  end;
  for i:=2 to len do begin
    last[way[i]]:=false;
    inc(deleted);
    p:=edges[way[i]];
    while p<>nil do begin
      if not marked[p^.v] then addedge(u,p^.v);
      t:=p;
      p:=p^.next;
      freemem(t);
    end;
  end;
  for i:=1 to len do edges[way[i]]:=edges[u];
end;
var
resedges:array[1..50000]of record
  u,v:integer;
end;
i:integer;
a,b:integer;
count:integer;
t:integer;
begin
  assign(input,'biconn.in');
  assign(output,'biconn.out');
  reset(input);
  rewrite(output);
  readln(n);
  if n=1 then begin
    writeln(0);
    close(input);
    close(output);
    halt;
  end;
  for i:=1 to n-1 do begin
    readln(a,b);
    addedge(a,b);
    addedge(b,a);
  end;
  for i:=1 to n do marked[i]:=false;
  for i:=1 to n do last[i]:=true;
  max:=-1;
  dfs(1,0);
  count:=0;
  deleted:=0;
  while true do begin
    max:=-1;
    for i:=1 to n do marked[i]:=false;
    dfs(maxv,0);
    a:=maxv;
    max:=-1;
    for i:=1 to n do marked[i]:=false;
    dfs(maxv,0);
    b:=maxv;
    inc(count);
    resedges[count].u:=a;
    resedges[count].v:=b;
    delete(a,b);
    if deleted=n then break;
    for i:=1 to n do marked[i]:=false;
    max:=-1;
    dfs(a,0);
    if maxv=a then break;
  end;
  writeln(count);
  for i:=1 to count do writeln(resedges[i].u,' ',resedges[i].v);
  close(input);
  close(output);
end.