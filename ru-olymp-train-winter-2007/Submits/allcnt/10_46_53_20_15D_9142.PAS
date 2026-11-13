{$M 16000000}
type tcount=array[0..200]of longint;
var tt,ttc,k,i,j,n:longint;
    g:array[1..5,0..200]of longint;
    was0,can0:array[0..200]of boolean;
    was,can:array[0..200,0..200]of boolean;
    wasg:array[0..200,0..200,1..5]of boolean;
    ok:boolean;

procedure dfs0(a:longint);
var i:longint;
begin
  if (a=0) then
    exit;
  was0[a]:=true;
  if can0[a] then
    exit;
  for i:=1 to k do
    if not was0[g[i,a]] then
      dfs0(g[i,a]);
  for i:=1 to k do
    if can0[g[i,a]] then
    begin
      can0[a]:=true;
      exit;
    end;
end;

procedure dfs(a,b:longint);
var i:longint;
begin
  if (a=b) then
    exit;
  if can[a,b] then
    exit;
  for i:=1 to k do
    if not wasg[a,b,i] then
      if not was[g[i,a],g[i,b]] then
      begin
        wasg[a,b,i]:=true;
        dfs(g[i,a],g[i,b]);
      end;
  for i:=1 to k do
    if can[g[i,a],g[i,b]] then
    begin
      can[a,b]:=true;
      exit;
    end;
end;

begin
  randomize;
  assign(input,'bit2.in');
  reset(input);
  assign(output,'bit2.out');
  rewrite(output);
  read(tt);
  for ttc:=1 to tt do
  begin
    read(n,k);
    for i:=1 to k do
      for j:=1 to n do
        read(g[i,j-1]);
    ok:=true;
    fillchar(was0,sizeof(was0),false);
    fillchar(can0,sizeof(can0),false);
    can0[0]:=true;
    for i:=0 to n-1 do
    begin
      dfs0(i);
      if not can0[i] then
      begin
        ok:=false;
        break;
      end;
    end;
    fillchar(can,sizeof(can),false);
    fillchar(was,sizeof(was),false);
    fillchar(wasg,sizeof(wasg),false);
    for i:=0 to n-1 do
      can[i,i]:=true;
    for i:=0 to n-1 do
      for j:=0 to n-1 do
      begin
        dfs(i,j);
        if not can[i,j] then
        begin
          ok:=false;
          break;
        end;
      end;
    if ok then
      writeln('YES')
    else
      writeln('NO');
  end;
  close(input);
  close(output);
end.
