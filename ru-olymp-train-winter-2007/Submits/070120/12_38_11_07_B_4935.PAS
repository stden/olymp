var
edge:array[1..20,1..20]of boolean;
marked:array[1..20]of boolean;
n:integer;
c,p,len:array[1..20]of integer;
d:array[1..20,0..20]of integer;
procedure dfs(first,k,sum,deapth:integer);
var
i:integer;
begin
  marked[k]:=true;
  for i:=1 to n do begin
    if edge[k,i] and not marked[i] then begin
      dfs(first,i,sum+c[i],deapth+1);
    end;
    if (i=first) and edge[k,i] then begin
      if sum+c[i]>=d[first,deapth+1] then d[first,deapth+1]:=sum+c[i];
    end;
  end;
end;
procedure bfs(beg:integer);
var
queue:array[1..20]of integer;
first,last:integer;
i:integer;
begin
  first:=1;
  last:=1;
  queue[first]:=beg;
  p[beg]:=c[beg];
  len[beg]:=0;
  while first<=last do begin
    for i:=1 to n do begin
      if edge[queue[first],i] and not marked[i] then begin
        marked[i]:=true;
        inc(last);
        queue[last]:=i;
        p[i]:=p[queue[first]]+c[i];
        len[i]:=len[queue[first]]+1;
      end;
    end;
    inc(first);
  end;
end;
function findmax(v:integer;k:int64):int64;
var
t:int64;
max:int64;
i:integer;
begin
  if k=0 then begin
    findmax:=c[v];
    exit;
  end;
  max:=-1;
  for i:=1 to n do begin
    if edge[v,i] then begin
      t:=findmax(i,k-1);
      if t>max then max:=t;
    end;
  end;
  findmax:=t+c[v];
end;
var
max:extended;
m:integer;
k:int64;
ans:int64;
i,j:integer;
u,v:integer;
maxi,maxj:integer;
begin
  assign(input,'maxsum.in');
  assign(output,'maxsum.out');
  reset(input);
  rewrite(output);
  readln(n,m,k);
  for i:=1 to n do read(c[i]);
  readln;
  fillchar(edge,sizeof(edge)div sizeof(boolean),0);
  for i:=1 to m do begin
    readln(u,v);
    edge[u,v]:=true;
  end;
  close(input);
  max:=-1;
  for i:=1 to n do begin
    fillchar(marked,sizeof(marked)div sizeof(boolean),0);
    dfs(i,i,0,0);
    for j:=1 to n do begin
      if d[i,j]/j>max then begin
        max:=d[i,j]/j;
        maxi:=i;
        maxj:=j;
      end;
    end;
  end;
  fillchar(marked,sizeof(marked)div sizeof(boolean),0);
  bfs(1);
  ans:=p[maxi];
  k:=k-len[maxi];
  ans:=ans+(k div maxj)*d[maxi,maxj];
  k:=k mod maxj;
  ans:=ans+findmax(maxi,k)-c[maxi];
  writeln(ans);
  close(output);
end.