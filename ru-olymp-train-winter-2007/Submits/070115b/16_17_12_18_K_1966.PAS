var
 a,b:array[1..50000]of longint;
 t,i1,i2,i,j,n,x,d,max:longint;

procedure QSort(l,r:longint);
var
 i,j,t,x1:longint;
begin
 if l>=r then
  exit;
 i:=l; j:=r;
 t:=l+random(r-l+1);
 x1:=a[t];
 while i<j do
  begin
  while (a[i]<x1) do i:=i+1;
  while (a[j]>x1) do j:=j-1;
  if i<=j then
   begin
   t:=a[i];a[i]:=a[j];a[j]:=t;
   i:=i+1;
   j:=j-1;
   end;
  end;
 qsort(l,j);
 qsort(i,r);
end;

procedure QSort2(l,r:longint);
var
 i,j,t,x1:longint;
begin
 if l>=r then
  exit;
 i:=l; j:=r;
 t:=l+random(r-l+1);
 x1:=b[t];
 while i<j do
  begin
  while (b[i]<x1) do i:=i+1;
  while (b[j]>x1) do j:=j-1;
  if i<=j then
   begin
   t:=b[i];b[i]:=b[j];b[j]:=t;
   i:=i+1;
   j:=j-1;
   end;
  end;
 qsort2(l,j);
 qsort2(i,r);
end;

begin
 assign(input,'segments.in');
 assign(output,'segments.out');
 reset(input);
 rewrite(output);
 read(n);
 for i:=1 to n do
  begin
  read(a[i],b[i]);
  if b[i]<a[i] then
   begin
   t:=a[i];
   a[i]:=b[i];
   b[i]:=t;
   end;
  end;
 QSort(1,n);
 QSort2(1,n);
 x:=a[1];
 max:=1;
 d:=1;
 i1:=2;
 i2:=1;
 while (i1<=n)or(i2<=n) do
  begin
  if (i1<=n)and(a[i1]<=b[i2]) then
   begin
   d:=d+1;
   if d>max then
    begin
    x:=a[i1];
    max:=d;
    end;
   i1:=i1+1;
   end
  else
   begin
   d:=d-1;
   i2:=i2+1;
   end;
  end;
 writeln(max,' ',x);
 close(input);
 close(output);
end.