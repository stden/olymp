{$Mode Delphi}

var q:array[1..100000] of integer;
    id:array[1..100000] of integer;
    otr:array[1..100000] of integer;
    now:array[1..100000] of integer;
    r:array[1..200000] of integer;
    max,maxi:integer;
    i,n,num:integer;

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
      swap(id[i],id[j]);
      inc(i);
      dec(j);
    end;
  end;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;

procedure update(i,j:integer);
begin
  i:=i+n*2-1;
  j:=j+n*2-1;
  while i<=j do begin
    if odd(i) then r[i]:=r[i]+1;
    if not odd(j) then r[j]:=r[j]+1;
    i:=(i+1) shr 1;
    j:=(j-1) shr 1;
  end;
end;

begin
  assign(input,'segments.in');
  assign(output,'segments.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do begin
    read(otr[i*2-1],otr[i*2]);
    if otr[i*2-1]>otr[i*2] then swap(otr[i*2-1],otr[i*2]);
    id[i*2-1]:=i*2-1;
    id[i*2]:=i*2;
    q[i*2-1]:=otr[i*2-1];
    q[i*2]:=otr[i*2];
  end;
  qsort(1,n*2);
  i:=1;
  num:=1;
  now[id[1]]:=1;
  for i:=2 to n*2 do begin
    if q[i]=q[i-1] then
      now[id[i]]:=num
    else begin
      inc(num);
      now[id[i]]:=num;
    end;
  end;
  for i:=1 to n do
    update(now[i*2-1],now[i*2]);
  for i:=1 to n*2-1 do begin
    r[i*2]:=r[i*2]+r[i];
    r[i*2+1]:=r[i*2+1]+r[i];
  end;
  max:=0;
  maxi:=0;
  for i:=1 to n*2 do begin
    if max<r[now[i]+n*2-1]  then begin
      max:=r[now[i]+n*2-1];
      maxi:=otr[i];
    end;
  end;
  writeln(max,' ',maxi);
  close(input);
  close(output);
end.
