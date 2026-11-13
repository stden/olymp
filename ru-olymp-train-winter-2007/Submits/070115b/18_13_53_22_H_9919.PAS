type integer=longint;
var a:array[1..50000]of integer;
    n,i,pos,mini,min:integer;

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
  x:=a[random(j-i+1)+i];
  while i<=j do begin
    while a[i]<x do inc(i);
    while a[j]>x do dec(j);
    if i<=j then begin
      swap(a[i],a[j]);
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
  randseed:=5435;
  rewrite(output);
  readln(n);
  for i:=1 to n do
  read(a[i]);
  for i:=n downto 1 do begin
    if i=1 then begin
      writeln('IMPOSSIBLE');
      close(input);
      close(output);
      halt(0);
    end;
    if a[i]>a[i-1] then begin
      pos:=i;
      break;
    end;
  end;
  min:=54355345;
  mini:=0;
  for i:=pos to n do
  if (a[i]>a[pos-1]) and (a[i]<min) then begin
    min:=a[i];
    mini:=i;
  end;
  swap(a[pos-1],a[mini]);
  qsort(pos,n);
  for i:=1 to n do
  write(a[i],' ');
  close(input);
  close(output);
end.