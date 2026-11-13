{$Mode Delphi}

var q:array[1..50000] of integer;
    i,n,j:integer;

procedure swap(var a,b:integer);
var c:integer;
begin
  c:=a;
  a:=b;
  b:=c;
end;

procedure qsort(l,r:integer);
var i,j,x:integer;
begin
  i:=l;
  j:=r;
  x:=q[random(j-i+1)+i];
  while i<=j do begin
    while q[i]<x do inc(i);
    while q[j]>x do dec(j);
    if i<=j then begin
      swap(q[i],q[j]);
      inc(i);
      dec(j);
    end;
  end;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;



begin
  assign(input,'nextperm.in');
  assign(output,'nextperm.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do
  read(q[i]);
  i:=n;
  while (i>1) and (q[i]<q[i-1]) do dec(i) ;
  if i=1 then writeln('IMPOSSIBLE')
  else begin
    swap(q[i],q[i-1]);
    qsort(i,n);
    for i:=1 to n do
    write(q[i],' ');
  end;
  close(input);
  close(output);
end.