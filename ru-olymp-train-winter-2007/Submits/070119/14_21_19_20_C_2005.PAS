{$M 32000000}
{$I-,Q-,R-,S-}
var ac,c_o,ak,nxt,n,m,i,j,a,b:longint;
    connect,was,inuse:array[1..200000]of boolean;
    aci,lmove,cout,cnt,parent:array[1..200000]of longint;
    r_next,r_first,r_e:array[1..200000]of longint;
    r_o:longint;
    d_next,d_ffirst,d_first,d_e:array[1..200000]of longint;
    d_o:longint;
    ans:array[1..1000000]of record
                              a,b:longint;
                            end;

function dfs(x,p:longint):boolean;
begin
  dfs:=false;
  if connect[x] then
    exit;
  lmove[x]:=p;
  j:=d_first[x];
  while j<>0 do
  begin
    if parent[d_e[j]]<>parent[x] then
      if lmove[d_e[j]]<>p then
        if dfs(d_e[j],p) then
        begin
          dfs:=true;
          exit;
        end;
    j:=d_next[j];
  end;
  connect[x]:=true;
  ak:=ak+1;
  ans[ak].a:=x;
  ans[ak].b:=p;
  dfs:=true;
end;

function dfs_p(x,p:longint):boolean;
begin
  lmove[x]:=p;
  j:=d_first[x];
  while j<>0 do
  begin
    if parent[d_e[j]]<>parent[x] then
      if lmove[d_e[j]]<>p then
        if dfs_p(d_e[j],p) then
        begin
          dfs_p:=true;
          exit;
        end;
    j:=d_next[j];
  end;
  connect[x]:=true;
  ak:=ak+1;
  ans[ak].a:=x;
  ans[ak].b:=p;
  dfs_p:=true;
end;

procedure dfs_d(x,c:longint);
var j:longint;
begin
  lmove[x]:=c;
  j:=d_ffirst[x];
  while j<>0 do
  begin
    if lmove[d_e[j]]<>c then
      dfs_d(d_e[j],c);
    j:=d_next[j];
  end;
end;

procedure dfs_r(x,c:longint);
var j:longint;
begin
  parent[x]:=c;
  was[x]:=false;
  j:=r_first[x];
  while j<>0 do
  begin
    if (was[r_e[j]])and(lmove[r_e[j]]=c) then
      dfs_r(r_e[j],c);
    j:=r_next[j];
  end;
end;

procedure add_d(a,b:longint);
begin
  inc(d_o);
  d_e[d_o]:=b;
  d_next[d_o]:=d_first[a];
  d_first[a]:=d_o;
  d_ffirst[a]:=d_o;
end;

procedure add_r(a,b:longint);
begin
  inc(r_o);
  r_e[r_o]:=b;
  r_next[r_o]:=r_first[a];
  r_first[a]:=r_o;
end;

begin
  assign(input,'republic.in');
  reset(input);
  assign(output,'republic.out');
  rewrite(output);
  read(n,m);
  d_o:=0;
  r_o:=0;
  for i:=1 to m do
  begin
    read(a,b);
    if a=b then
      continue;
    add_d(a,b);
    add_r(b,a);
  end;
  fillchar(lmove,sizeof(lmove),0);
  fillchar(was,sizeof(was),true);
  c_o:=0;
  for i:=1 to n do
    if parent[i]=0 then
    begin
      c_o:=c_o+1;
      dfs_d(i,i);
      dfs_r(i,i);
    end;
  if c_o=1 then
  begin
    writeln(0);
    close(input);
    close(output);
    halt;
  end;
  fillchar(inuse,sizeof(inuse),false);
  for i:=1 to n do
    inuse[parent[i]]:=true;
  fillchar(cnt,sizeof(cnt),0);
  fillchar(cout,sizeof(cout),0);
  for i:=1 to n do
    if inuse[i] then
    begin
      j:=d_first[i];
      while j<>0 do
      begin
        nxt:=d_next[j];
        if (parent[i]<>parent[d_e[j]]) then
        begin
          inc(cnt[parent[d_e[j]]]);
          inc(cout[i]);
          d_e[j]:=parent[d_e[j]];
        end;
        j:=nxt;
      end;
    end;
  for i:=1 to n do
    if not inuse[i] then
    begin
      j:=d_first[i];
      while j<>0 do
      begin
        nxt:=d_next[j];
        if parent[i]<>parent[d_e[j]] then
        begin
          inc(cnt[parent[d_e[j]]]);
          inc(cout[parent[i]]);
          d_next[j]:=d_first[parent[i]];
          d_first[parent[i]]:=j;
          d_e[j]:=parent[d_e[j]];
        end;
        j:=nxt;
      end;
      d_first[i]:=0;
    end;
  ak:=0;
  ac:=0;
  for i:=1 to n do
    if (cnt[i]=0)and(inuse[i]) then
    begin
      inc(ac);
      aci[ac]:=i;
    end;
  ak:=0;
  fillchar(connect,sizeof(connect),false);
  fillchar(lmove,sizeof(lmove),0);
  for i:=1 to ac do
    if not dfs(aci[i],aci[i mod ac+1]) then
      dfs_p(aci[i],aci[i mod ac+1]);
  for i:=1 to n do
    if (cout[i]=0)and(not connect[i]) then
    begin
      inc(ak);
      ans[ak].a:=i;
      ans[ak].b:=aci[1];
    end;
  writeln(ak);
  for i:=1 to ak do
    writeln(ans[i].a,' ',ans[i].b);
  close(output);
  close(input);
end.
