{$Mode Delphi}
uses windows;

type IntArr=array[0..500] of integer;

var q:array[0..500] of IntArr;
    x,best:array[0..500] of integer;
    c:array[1..500] of integer;
    bestres:integer;
    n,m:integer;
    time:cardinal;

procedure swap(var a,b:IntArr);
var c:IntArr;
begin
  c:=a;
  a:=b;
  b:=c;
end;

procedure decarr(var a,b:IntArr;k1,k2:integer);
var i:integer;
begin
  for i:=0 to m do
    a[i]:=a[i]*k2-b[i]*k1;
end;

procedure quit;
begin
  writeln(-1);
  close(input);
  close(output);
  halt(0);
end;

procedure checksol(stpos:integer);
var sum:integer;
    i,j,temp,res:integer;
begin
   for j:=0 to stpos-1 do begin
    if q[j,j]<>0 then begin
       sum:=0;
       for i:=stpos to m-1 do
       sum:=sum+x[i]*q[j][i];
       temp:=q[j][m]-sum;
       if (temp mod q[j][j]<>0) or (temp div q[j][j]<0) then exit;
       x[j+1]:=temp div q[j][j];
     end;
   end;
   res:=0;
   for i:=1 to m do
   res:=res+x[i]*c[i];
   if res<bestres then begin
     bestres:=res;
     best:=x;
   end;
end;

procedure dfs(pos,stpos:integer);
var i:integer;
begin
//  if gettickcount-time>1500 then exit;
  if pos=m then begin
    checksol(stpos);
  end
  else
   for i:=0 to 20 do  begin
     x[pos]:=i;
     dfs(pos+1,stpos);
   end;
end;

procedure gauss;
var i,res,j,l:integer;
    f:boolean;
begin
  res:=0;
  for i:=0 to m-1 do begin
    if i=n then break;
    if q[i,i]=0 then
      for j:=1 to n-1 do begin
        if q[j,i]<>0 then begin
          swap(q[i],q[j]);
          break;
        end;
      end;
    if q[i,i]=0 then continue;
    for j:=0 to n-1 do
      if (j<>i) and  (q[j,i]<>0) then begin
        decarr(q[j],q[i],q[j,i],q[i,i]);
      end;
  end;
  l:=10000;
  for i:=0 to m-1 do
   for j:=i+1  to m-1 do
    if q[i,j]<>0 then
      if l>j then l:=j;
  dfs(l,l);
    for i:=0 to n-1 do begin
      l:=0;
      for j:=0 to m-1 do
      l:=l+x[j]*q[i][j];
      if l<>q[i][m] then quit;
    end;
  writeln(bestres);
  for i:=1 to m do
  write(best[i],' ');
end;
var i,j:integer;


begin
  assign(input,'radio.in');
  assign(output,'radio.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  bestres:=100000000;
  for i:=0 to n-1 do
    for j:=0 to m-1 do
    read(q[i,j]);
  for i:=0 to n-1 do
    read(q[i,m]);
  for i:=1 to m-1 do
  read(c[i]);
  gauss;
  close(input);
  close(output);
end.
