{$Mode Delphi}
{$M 16000000}
var q:array[1..1000] of integer;
    nx,go,id:array[1..10000] of integer;
    del:array[1..10000] of boolean;
    inpair:array[1..10000] of boolean;
    p,oldp:array[1..1000] of integer;
    mark:array[1..1000] of boolean;
    flag:array[1..1000] of boolean;
    ans:array[1..10000000] of record
                                a,b:integer;
                             end;
    res:integer;
    u,a,b,i,t,k,n1,n2,temp,m:integer;
    maxpair,nowpair:integer;

procedure swap(var a,b:integer);
var c:integer;
begin
  c:=a;
  a:=b;
  b:=c;
end;

function  dfs(v:integer):boolean;
var t:integer;
begin
  mark[v]:=true;
  t:=q[v];
  dfs:=false;
  while t<>0 do begin
    if (not del[t]) and ((p[go[t]]=0) or (not mark[p[go[t]]] and dfs(p[go[t]]))) then begin
      p[go[t]]:=v;
      dfs:=true;
      exit;
    end;
    t:=nx[t];
  end;
end;

procedure marked(a,b:integer);
var t:integer;
begin
  t:=q[a];
  while t<>0 do begin
    if go[t]=b then begin
      inpair[t]:=true;
      exit;
    end;
    t:=nx[t];
  end;
end;

procedure build;
var i,j:integer;
begin
  oldp:=p;
  for i:=1 to 2 do begin
    fillchar(mark,sizeof(mark),0);
    for j:=1 to n1 do
      if not mark[j] and not flag[j] then
        if dfs(j) then begin
          inc(nowpair);
          break;
        end;
  end;
  p:=oldp;
end;

procedure add(a,b,i:integer);
begin
  inc(u);
  id[u]:=i;
  nx[u]:=q[a];
  go[u]:=b;
  del[u]:=false;
  inpair[u]:=false;
  q[a]:=u;
end;

procedure trydel(a,b:integer);
var t,i,temp:integer;
    oldpair:integer;
begin
  for i:=1 to n1 do begin
    t:=q[i];
    while t<>0 do begin
      if not del[t] then begin
        oldpair:=nowpair;
        if inpair[t] then begin
          nowpair:=nowpair-1;
          temp:=p[go[t]];
          p[go[t]]:=0;
          flag[i]:=false;
        end;
        del[t]:=true;
        build;
        if nowpair<>maxpair then begin
          inc(res);
          ans[res].a:=id[t];
          ans[res].b:=id[b];
        end;
        del[t]:=false;
        nowpair:=oldpair;
        p[go[b]]:=0;
        if inpair[t] then begin
          p[go[t]]:=temp;
          flag[i]:=true;
        end;
      end;
      t:=nx[t];
    end;
  end;
end;

procedure qsort(l,r:integer);
var i,j,x,y:integer;
begin
  i:=l;
  j:=r;
  x:=random(j-i+1)+i;
  y:=ans[x].b;
  x:=ans[x].a;
  while i<=j do begin
    while (ans[i].a<x) or ((ans[i].a=x) and (ans[i].b<y)) do inc(i);
    while (ans[j].a>x) or ((ans[i].a=x) and (ans[j].b>y)) do dec(j);
    if i<=j then begin
      swap(ans[i].a,ans[j].a);
      swap(ans[i].b,ans[j].b);
      inc(i);
      dec(j);
    end;
  end;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;

begin
  assign(input,'pairs.in');
  assign(output,'pairs.out');
  reset(input);
  rewrite(output);
  readln(n1,n2,m);
  for i:=1 to m do begin
    read(a,b);
    add(a,b,i);
  end;
  maxpair:=0;
  for i:=1 to n1 do begin
    fillchar(mark,sizeof(mark),0);
    if dfs(i) then maxpair:=maxpair+1;
  end;
  for i:=1 to n2 do
    if p[i]<>0 then  begin
      marked(p[i],i);
      flag[p[i]]:=true;
    end;
  for i:=1 to n1 do begin
    t:=q[i];
    while t<>0 do begin
      if inpair[t] then begin
         nowpair:=maxpair-1;
         del[t]:=true;
         flag[i]:=false;
         temp:=p[go[t]];
         p[go[t]]:=0;
         trydel(i,t);
         flag[i]:=true;
         del[t]:=false;
         p[go[t]]:=temp;
      end;
      t:=nx[t];
    end;
  end;
  for i:=1 to res do
  if ans[i].a>ans[i].b then
    swap(ans[i].a,ans[i].b);
  qsort(1,res);
  k:=0;
  for i:=1 to res-1 do
    if (ans[i].a<>ans[i+1].b) or (ans[i].b<>ans[i+1].b) then
      inc(k);
  if res>0 then inc(k);
  writeln(k);
  close(input);
  close(output);
end.
