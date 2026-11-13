uses math;
var n,m,o,i,a,b,ao,t:longint;
    color,first,order:array[1..20000]of longint;
    was:array[1..20000]of boolean;
    aa,ab,ed,next:array[1..500000]of longint;
    can:array[1..500000]of boolean;

procedure dfs(x,p:longint);
var j:longint;
begin
  was[x]:=true;
  inc(t);
  order[t]:=x;
  j:=first[x];
  while j<>0 do
  begin
    if not was[ed[j]] then
    begin
      dfs(ed[j],x);
      can[j]:=false;
    end;
    j:=next[j];
  end;
end;

procedure dfs2(x,c:longint);
var j:longint;
begin
  was[x]:=true;
  color[x]:=c;
  j:=first[x];
  while j<>0 do
  begin
    if (can[j]) and (not was[ed[j]]) then
      dfs2(ed[j],c);
    j:=next[j];
  end;
end;

procedure addedge(a,b,c:longint);
begin
  inc(o);
  ed[o]:=b;
  next[o]:=first[a];
  first[a]:=o;
end;

begin
  assign(input,'bridges.in');
  reset(input);
  assign(output,'bridges.out');
  rewrite(output);
  read(n,m);
  o:=0;
  for i:=1 to m do
  begin
    read(a,b);
    addedge(a,b,i);
    addedge(b,a,i);
    aa[i]:=a;
    ab[i]:=b;
  end;
  fillchar(order,sizeof(order),0);
  fillchar(was,sizeof(was),false);
  fillchar(can,sizeof(can),true);
  ao:=0;
  t:=0;
  dfs(1,0);
  fillchar(was,sizeof(was),false);
  for i:=1 to n do
    if not was[order[i]] then
      dfs2(order[i],i);
  ao:=0;
  for i:=1 to m do
    if color[aa[i]] <> color[ab[i]] then
      inc(ao);
  writeln(ao);
  for i:=1 to m do
    if color[aa[i]] <> color[ab[i]] then
      writeln(i);
  close(output);
  close(input);
end.
