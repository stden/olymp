{$M 16000000}
var c:array[0..50000,1..15]of extended;
    n,i,j:longint;
    a:array[1..15,1..15]of longint;
    b:array[1..15,1..15]of extended;

function calc(p,x:longint;q:extended):extended;
var i,s:longint;
    t,t1,t2:extended;
begin
  calc:=0;
  if q<1e-10 then
    exit;
  if c[p][x]<>-1 then
  begin
    calc:=(c[p][x]);
    exit;
  end;
  if p and (1 shl (x-1))<>1 shl (x-1) then
  begin
    c[p][x]:=calc(p,x mod n+1,q);
    calc:=c[p][x]+1;
    exit;
  end
  else
  begin
    s:=0;
    for i:=1 to n do
      if i<>x then
        if p and (1 shl (i-1))=1 shl (i-1) then
          s:=s+a[x][i];
    t:=0;
    for i:=1 to n do
      if i<>x then
        if p and (1 shl (i-1))=1 shl (i-1) then
        begin
          t1:=(calc(p-(1 shl (i-1)),x mod n+1,q*(a[x][i]/s)*b[x][i])+1)*(a[x][i]/s)*b[x][i];
          t2:=(calc(p,x mod n+1,q*(a[x][i]/s)*(1-b[x][i]))+1)*(a[x][i]/s)*(1-b[x][i]);
          t:=t+t1+t2;
        end;
    c[p][x]:=t;
  end;
  calc:=(c[p][x]);
end;

begin
  assign(input,'game.in');
  reset(input);
  assign(output,'game.out');
  rewrite(output);
  read(n);
  for i:=1 to n do
    for j:=1 to n do
      read(a[i][j]);
  for i:=1 to n do
    for j:=1 to n do
      read(b[i][j]);
  for i:=1 to 1 shl n-1 do
    for j:=1 to n do
      c[i][j]:=-1;
  for j:=1 to n do
    for i:=1 to n do
    c[1 shl (j-1)][i]:=0;
  writeln(calc(1 shl n-1,1,1):0:10);
  close(output);
  close(input);
end.
