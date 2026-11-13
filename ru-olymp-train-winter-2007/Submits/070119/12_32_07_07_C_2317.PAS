type
integer=longint;
plist=^tlist;
tlist=record
  next:plist;
  v:integer;
end;
var
edges:array[1..100000]of plist;
marked:array[1..100000]of boolean;
procedure addedge(u,v:integer);
var
p:plist;
begin
  p:=new(plist);
  p^.next:=edges[u];
  p^.v:=v;
  edges[u]:=p;
end;
procedure dfs(v:integer);
var
p:plist;
begin
  marked[v]:=true;
  p:=edges[v];
  while p<>nil do begin
    if not marked[p^.v] then dfs(p^.v);
    p:=p^.next;
  end;
end;
var
n,m:integer;
i,j:integer;
edge:array[1..200000]of record
  u:integer;
  v:integer;
end;
p,q:integer;
ans:integer;
begin
  assign(input,'republic.in');
  assign(output,'republic.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  for i:=1 to m do begin
    readln(p,q);
    addedge(p,q);
  end;
  for i:=1 to n do begin
    for j:=1 to n do begin
      marked[j]:=false;
    end;
    dfs(i);
    for j:=1 to n do begin
      if not marked[j] then begin
       inc(ans);
       edge[ans].u:=i;
       edge[ans].v:=j;
       addedge(i,j);
       dfs(j);
      end;
    end;
  end;
  writeln(ans);
  for i:=1 to ans do writeln(edge[i].u,' ',edge[i].v);
  close(input);
  close(output);
end.