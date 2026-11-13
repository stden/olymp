{$M+ 16000000}
const maxp=10000;
      mpp=10;
type tcount=array[0..200]of longint;
var t,tt,ttc,k,i,j,n:longint;
    g:array[1..5,0..200]of longint;
    was0,can0:array[1..200]of boolean;
    was,can:array[1..200,1..200]of boolean;
    cnt:tcount;
    ok:boolean;
label 1;

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
  was[a,b]:=true;
  for i:=1 to k do
    if not was[g[i,a],g[i,b]] then
      dfs(g[i,a],g[i,b]);
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
    fillchar(was0,sizeof(was0),false);
    fillchar(can0,sizeof(can0),false);
    can0[0]:=true;
    for i:=0 to n-1 do
    begin
      dfs0(i);
      if not can0[i] then
      begin
        writeln('NO');
        goto 1;
      end;
    end;
    fillchar(was,sizeof(was),false);
    fillchar(can,sizeof(can),false);
    for i:=0 to n-1 do
      can[i,i]:=true;
    for i:=0 to n-1 do
      for j:=0 to n-1 do
      begin
        dfs(i,j);
        if not can[i,j] then
        begin
          writeln('NO');
          goto 1;
        end;
      end;
    writeln('YES');
1:
  end;
  close(input);
  close(output);
end.
