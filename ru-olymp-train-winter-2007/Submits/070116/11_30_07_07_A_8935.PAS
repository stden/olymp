{$m 1000000}
type
plist=^tlist;
tlist=record
  next:plist;
  v:integer;
end;
var
edges:array[1..2,1..500]of plist;
deapth:array[1..500,0..500]of integer;
map:array[1..500]of integer;
marked,marked1,marked2:array[1..500]of boolean;
n,m:integer;
procedure addedge(tree,u,v:integer);
var
p:plist;
begin
  p:=new(plist);
  p^.v:=v;
  p^.next:=edges[tree,u];
  edges[tree,u]:=p;
end;
procedure getdeapth(tree,v:integer);
var
p:plist;
t:boolean;
i:integer;
begin
  marked[v]:=true;
  for i:=0 to 500 do deapth[v,i]:=0;
  p:=edges[tree,v];
  t:=false;
  while p<>nil do begin
    if not marked[p^.v] then begin
      getdeapth(tree,p^.v);
      for i:=1 to n do begin
        inc(deapth[v,i],deapth[p^.v,i-1]);
      end;
      t:=true;
    end;
    p:=p^.next;
  end;
  if not t then deapth[v,0]:=1;
end;
function isbigger(u,v:integer):boolean;
var
i:integer;
begin
  if deapth[u,0]=1 then begin
    isbigger:=false;
    exit;
  end;
  if deapth[v,0]=1 then begin
    isbigger:=true;
    exit;
  end;
  for i:=n downto 1 do begin
    if deapth[u,i]>deapth[v,i] then begin
      isbigger:=true;
      exit;
    end;
  end;
  isbigger:=false;
end;
function sort(tree,v:integer):integer;
var
perm:integer;
p,p1:plist;
t:integer;
begin
  marked[v]:=true;
  while true do begin
    p:=edges[tree,v];
    perm:=0;
    while true do begin
      p1:=p^.next;
      while (p1<>nil) and (marked[p1^.v]) do p1:=p1^.next;
      if p1=nil then break;
      if isbigger(p1^.v,p^.v) then begin
        t:=p1^.v;
        p1^.v:=p^.v;
        p^.v:=t;
        inc(perm);
      end;
      p:=p1;
    end;
    if perm=0 then break;
  end;
  p:=edges[tree,v];
  while p<>nil do begin
    if not marked[p^.v] then begin
      sort(tree,p^.v);
    end;
    p:=p^.next;
  end;
end;
function test(u,v:integer):boolean;
var
p1,p2:plist;
begin
  marked1[u]:=true;
  marked2[v]:=true;
  p1:=edges[1,u];
  p2:=edges[2,v];
  while true do begin
    while (p1<>nil) and marked1[p1^.v] do p1:=p1^.next;
    if p1=nil then begin
      test:=true;
      map[u]:=v;
      exit;
    end;
    while (p2<>nil) and marked2[p2^.v] do p2:=p2^.next;
    if p2=nil then begin
      test:=false;
      exit;
    end;
    if not test(p1^.v,p2^.v) then begin
      test:=false;
      exit;
    end;
    p1:=p1^.next;
    p2:=p2^.next;
  end;
  test:=true;
  map[u]:=v;
end;
procedure print;
var
i:integer;
begin
  for i:=1 to m do begin
    write(map[i],' ');
  end;
  writeln;
end;
var
i,j:integer;
a,b:integer;
begin
  assign(input,'map.in');
  assign(output,'map.out');
  reset(input);
  rewrite(output);
  readln(m);
  for i:=1 to 500 do edges[1,i]:=nil;
  for i:=1 to 500 do edges[2,i]:=nil;
  for i:=1 to m-1 do begin
    readln(a,b);
    addedge(1,a,b);
    addedge(1,b,a);
  end;
  readln(n);
  for i:=1 to n-1 do begin
    readln(a,b);
    addedge(2,a,b);
    addedge(2,b,a);
  end;

  for i:=1 to m do marked[i]:=false;
  getdeapth(1,1);
  for i:=1 to m do marked[i]:=false;
  sort(1,1);

  for i:=1 to n do begin
    for j:=1 to n do marked[j]:=false;
    getdeapth(2,i);
    for j:=1 to n do marked[j]:=false;
    sort(2,i);
    for j:=1 to n do marked1[j]:=false;
    for j:=1 to n do marked2[j]:=false;
    if test(1,i) then begin
      writeln('YES');
      print;
      close(input);
      close(output);
      exit;
    end;
  end;
  writeln('NO');
  close(input);
  close(output);
end.
