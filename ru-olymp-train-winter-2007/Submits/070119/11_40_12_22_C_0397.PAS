{$Mode Delphi}

var q,w:array[1..100000] of integer;
    go:array[1..400000] of integer;
    nx:array[1..400000] of integer;
    nn:array[1..100000] of integer;
    inst,outst:array[1..100000] of integer;
    inzero,outzero:array[1..100000] of integer;
    time:array[1..100000] of integer;
    mark:array[1..100000] of boolean;
    color:array[1..100000] of integer;
    ans:array[1..100000] of record
                              a,b:integer;
                            end;
    res:integer;
    tm,u,cn,i,j,t,a,b,n,m,cinzero,coutzero:integer;

procedure addq(a,b:integer);
begin
  inc(u);
  nx[u]:=q[a];
  go[u]:=b;
  q[a]:=u;
end;
procedure addw(a,b:integer);
begin
  inc(u);
  nx[u]:=w[a];
  go[u]:=b;
  w[a]:=u;
  inc(inst[b]);
  inc(outst[a]);
end;
procedure addnn(a,b:integer);
begin
  inc(u);
  nx[u]:=nn[a];
  go[u]:=b;
  nn[a]:=u;
end;

procedure dfs(v:integer);
var t:integer;
begin
  mark[v]:=true;
  t:=q[v];
  while t<>0 do begin
    if not mark[go[t]] then
    dfs(go[t]);
    t:=nx[t];
  end;
  inc(tm);
  time[tm]:=v;
end;

procedure sfd(v,cl:integer);
var t:integer;
begin
  color[v]:=cl;
  t:=q[v];
  while t<>0 do begin
    if color[go[t]]=0 then
      dfs(go[t]);
    t:=nx[t];
  end;
end;

begin
  u:=0;
  cinzero:=0;
  coutzero:=0;
  res:=0;
  tm:=0;
  assign(input,'republic.in');
  assign(output,'republic.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  for i:=1 to m do begin
    read(a,b);
    addq(a,b);
  end;
  for i:=1 to n do
  if not mark[i] then
     dfs(i);
  cn:=0;
  for i:=1 to n do
    if color[time[i]]=0 then begin
      inc(cn);
      sfd(time[i],cn);
    end;
  for i:=1 to n do
  addnn(color[i],i);
  for i:=1 to cn do begin
    t:=nn[i];
    while t<>0 do begin
      j:=q[go[t]];
      while j<>0 do begin
        if color[go[j]]<>i then
          addw(i,color[go[j]]);
        j:=nx[j];
      end;
      t:=nx[t];
    end;
  end;
  if cn=1 then begin
    writeln('0');
    close(input);
    close(output);
    halt(0);
  end;
  for i:=1 to cn do
    if (inst[i]=0) and (outst[i]=0) then begin
      inc(cinzero);
      inzero[cinzero]:=i;
    end;
  for i:=1 to cn do
    if (inst[i]=0) then begin
      inc(cinzero);
      inzero[cinzero]:=i;
    end;
  for i:=1 to cinzero-1 do begin
    inc(res);
    inc(outst[inzero[i]]);
    ans[res].a:=go[nn[inzero[i]]];
    ans[res].b:=go[nn[inzero[i+1]]];
  end;
  for i:=1 to cn do
    if (outst[i]=0) then begin
      inc(coutzero);
      outzero[coutzero]:=i;
    end;
  for i:=1 to coutzero do begin
    inc(res);
    ans[res].a:=go[nn[outzero[i]]];
    ans[res].b:=go[nn[inzero[1]]];
  end;
  writeln(res);
  for i:=1 to res do
  writeln(ans[i].a,' ',ans[i].b);
  close(input);
  close(output);
end.
