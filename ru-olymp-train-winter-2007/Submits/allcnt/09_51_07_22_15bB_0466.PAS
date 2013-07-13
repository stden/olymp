{$MODE DELPHI}

var q:array[1..800] of integer;
    go:array[1..40000] of integer;
    nx:array[1..40000] of integer;
    f:array[1..40000] of int64;
    c:array[1..40000] of int64;
    rv:array[1..40000] of integer;
    id:array[1..40000] of integer;
    ans:int64;
    t,a,b,ct,s,i,n,m,u:integer;
    mark:array[1..800] of boolean;
    pow:array[0..62] of int64;
    edge:array[1..40000] of boolean;
    count:integer;
function dfs(v:integer;k:int64):boolean;
var t:integer;
begin
  mark[v]:=true;
  t:=q[v];
  if v=n then begin
    dfs:=true;
    exit;
  end;
  while t<>0 do begin
    if not mark[go[t]] and (c[t]-f[t]>=k) and dfs(go[t],k) then  begin
       dfs:=true;
       f[t]:=f[t]+k;
       f[rv[t]]:=f[rv[t]]-k;
       exit;
    end;
    t:=nx[t];
  end;
  dfs:=false;
end;

procedure add(a,b,ct,i:integer);
begin
  inc(u);
  nx[u]:=q[a];
  go[u]:=b;
  c[u]:=ct;
  rv[u]:=u+1;
  q[a]:=u;
  f[u]:=0;
  id[u]:=i;
  inc(u);
  nx[u]:=q[b];
  go[u]:=a;
  c[u]:=ct;
  rv[u]:=u-1;
  f[u]:=0;
  q[b]:=u;
  id[u]:=i;
end;


begin
  u:=0;
  assign(input,'cut.in');
  assign(output,'cut.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  pow[0]:=1;
  for i:=1 to 62 do
  pow[i]:=pow[i-1]*2;
  for i:=1 to m do begin
    read(a,b,ct);
    add(a,b,ct,i);
//    add(b,a,ct);
  end;
  s:=1;
  ans:=0;
  for i:=2 downto 0 do begin
    fillchar(mark,sizeof(mark),0);
    while dfs(s,pow[i]) do begin
       ans:=ans+pow[i];
       fillchar(mark,sizeof(mark),0);
     end;
  end;
  count:=0;
  for i:=1 to n do begin
    t:=q[i];
    while t<>0 do begin
      if f[t]=c[t] then begin
        inc(count);
        edge[id[t]]:=true;
      end;
      t:=nx[t];
    end;
  end;
  writeln(count,' ',ans);
  for i:=1 to m do
  if edge[i] then write(i,' ');
  close(input);
  close(output);
end.
