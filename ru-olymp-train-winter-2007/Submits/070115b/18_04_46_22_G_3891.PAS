{$Mode Delphi}

var q:array[1..4000,1..4000] of boolean;
    x,y:array[1..4000] of boolean;
    p:array[1..4000] of integer;
    fucked:array[1..4000] of boolean;
    temp, i,j,res,n,m,k,a:integer;

procedure dfs(v:integer);
var i,j:integer;
begin
  x[v]:=true;
  for i:=1 to m do
    if q[v,i] then begin
      y[i]:=true;
      if (p[i]<>0)  and not x[p[i]] then
      dfs(p[i]);
    end;
end;

begin
  assign(input,'minimal.in');
  assign(output,'minimal.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  for i:=1 to n do begin
    read(k);
    for j:=1 to k do begin
      read(a);
      q[i,a]:=true;
    end;
  end;
  for i:=1 to n do begin
    read(temp);
    if temp<>0 then begin
      fucked[i]:=true;
      p[temp]:=i;
    end;
  end;
  for i:=1 to n do
  if not fucked[i] and not x[i] then
  dfs(i);
  res:=0;
  for i:=1 to n do
  if not x[i] then
  res:=res+1;
  for i:=1 to n do
  if y[i] then
  res:=res+1;
  writeln(res);
  res:=0;
  for i:=1 to n do
  if not x[i]  then res:=res+1;
  write(res,' ');
  for i:=1 to n do
  if not x[i] then
  write(i,' ');
  writeln;
  res:=0;
  for i:=1 to n do
  if y[i] then res:=res+1;
  write(res,' ');
  for i:=1 to n do
  if y[i] then
  write(i,' ');
  writeln;
  close(input);
  close(output);
end.
