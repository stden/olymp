type
integer=longint;
plist=^tlist;
tlist=record
  next:plist;
  v:integer;
  w:integer;
end;
var
edges:array[1..30000]of plist;
procedure addedge(u,v,w:integer);
var
p:plist;
begin
  p:=new(plist);
  p^.next:=edges[u];
  p^.v:=v;
  p^.w:=w;
  edges[u]:=p;
end;
var
n:integer;
m:longint;
i,j,k:integer;
s:array[1..30000]of longint;
marked:array[1..30000]of boolean;
p:plist;
u,v,w:integer;
min:longint;
minv:integer;
begin
  assign(input,'path.in');
  reset(input);
  assign(output,'path.out');
  rewrite(output);
  readln(n,m);
  for i:=1 to m do begin
    readln(u,v,w);
    addedge(u,v,w);
    addedge(v,u,w);
  end;

  for i:=1 to n do marked[i]:=false;
  marked[1]:=true;
  s[1]:=0;
  for i:=2 to n do begin
    min:=maxlongint;
    minv:=0;
    for j:=2 to n do begin
      if not marked[j] then begin
        p:=edges[j];
        while p<>nil do begin
          if marked[p^.v] and (s[p^.v]+p^.w<min)then begin
            min:=s[p^.v]+p^.w;
            minv:=j;
          end;
          p:=p^.next;
        end;
      end;
    end;
    marked[minv]:=true;
    s[minv]:=min;
  end;
  for i:=1 to n do write(s[i],' ');
  close(input);
  close(output);
end.
