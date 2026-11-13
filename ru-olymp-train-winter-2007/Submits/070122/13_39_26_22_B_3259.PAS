{$Mode Delphi}

var q:array[1..200,0..500] of integer;
    del:array[0..500] of boolean;
    g:array[1..200] of integer;
    go,next:array[1..200] of integer;
    a,c,w:array[1..200] of integer;
    u,p,i,n:integer;



procedure genallvar(v,t,sum,st:integer);
var i:integer;
begin
  if t=0 then begin
     if (q[v,st]<sum) then begin
       q[v,st]:=sum;
     end;
     exit;
  end;
  genallvar(v,next[t],sum,st);
  for i:=0 to 500-st do
    if q[go[t],i]<>-1 then
       genallvar(v,next[t],sum+q[go[t],i],st+i)
end;

procedure add(a,b:integer);
begin
  inc(u);
  go[u]:=b;
  next[u]:=g[a];
  g[a]:=u;
end;

procedure dfs(v:integer);
var t:integer;
begin
  t:=g[v];
  while t<>0 do begin
    dfs(go[t]);
    t:=next[t];
  end;
  q[v,0]:=0;
  genallvar(v,g[v],0,0);
  fillchar(del,sizeof(del),false);
  for i:=500  downto 0 do begin
    if q[v,i]>c[v] then begin
      q[v,i]:=q[v,i]+a[v];
      del[i]:=true;
    end
    else begin
      if (i+w[v]<=500) and (q[v,i]<>-1)and not del[i] then begin
        if q[v,i+w[v]]<q[v,i]+a[v] then begin
          q[v,i+w[v]]:=q[v,i]+a[v];
          del[i+w[v]]:=true;
         end;
      end;
    end;
  end;
  for i:=0 to 500 do
  if not del[i] then q[v,i]:=-1;
end;

begin
  fillchar(q,sizeof(q),255);
  assign(input,'system.in');
  assign(output,'system.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do begin
    read(p,c[i],a[i],w[i]);
    c[i]:=c[i]-a[i];
    if p<>0 then
    add(p,i);
  end;
  dfs(1);
  for i:=1 to 500 do
  if q[1,i]>0 then begin
    writeln(i);
    break;
  end;
  close(input);
  close(output);
end.
