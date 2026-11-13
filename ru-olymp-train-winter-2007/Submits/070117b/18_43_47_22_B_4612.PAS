{$Mode Delphi}
var q:array[0..200,0..200,0..200] of boolean;
    p:array[0..200,0..200,0..200] of record
                                       x,y:integer;
                                       id,num:integer;
                                     end;
    m:array[1..200] of integer;
    mark:array[1..200] of integer;
    cn:array[0..2] of integer;
    n,i,j,k,sum:integer;
    mini,minj,minn:integer;
    min:extended;


procedure dfs(i,j,n:integer);
begin
  if n=0 then exit;
  mark[p[n,i,j].id]:=p[n,i,j].num;
  dfs(p[n,i,j].x,p[n,i,j].y,n-1);
end;

function f(a,b,c:extended):extended;
begin
  f:=sqrt(sqr(a-1/3*sum)+sqr(b-1/3*sum)+sqr(c-1/3*sum))/9;
end;

begin
  assign(input,'change.in');
  assign(output,'change.out');
  reset(input);
  rewrite(output);
  sum:=0;
  readln(n);
  for i:=1 to n do begin
    read(m[i]);
    sum:=sum+m[i];
  end;
  q[0,0,0]:=true;
  for i:=1 to n do
    for j:=0 to 200 do
    for k:=0 to 200 do
    if q[i-1,j,k] then begin
      q[i,j,k]:=true;
      p[i,j,k].x:=j;
      p[i,j,k].y:=k;
      p[i,j,k].num:=0;
      p[i,j,k].id:=i;
      q[i,j+m[i],k]:=true;
      p[i,j+m[i],k].x:=j;
      p[i,j+m[i],k].y:=k;
      p[i,j+m[i],k].id:=i;
      p[i,j+m[i],k].num:=1;
      q[i,j,k+m[i]]:=true;
      p[i,j,k+m[i]].x:=j;
      p[i,j,k+m[i]].y:=k;
      p[i,j,k+m[i]].id:=i;
      p[i,j,k+m[i]].num:=2;
    end;
  min:=1e10;
  for i:=0 to 200 do
  for j:=0 to 200 do
  if q[n,i,j] then begin
    if min>f(i,j,sum-i-j) then begin
      min:=f(i,j,sum-i-j);
      mini:=i;
      minj:=j;
    end;
  end;
  dfs(mini,minj,n);
  for i:=1 to n do
  cn[mark[i]]:=cn[mark[i]]+1;
  write(cn[0],' ');
  for i:=1 to n do
   if mark[i]=0 then write(m[i],' ');
   writeln;
  write(cn[1],' ');
  for i:=1 to n do
    if mark[i]=1 then write(m[i],' ');
    writeln;
  write(cn[2],' ');
  for i:=1 to n do
   if mark[i]=2 then write(m[i],' ');
  close(input);
  close(output);
end.
