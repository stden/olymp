var
 max,i,j,k,n:longint;
 mas,ans,tab:array[1..50000]of longint;


procedure QSort(l,r:longint);
var
 i,j,t,x1:longint;
begin
 if l>=r then
  exit;
 i:=l; j:=r;
 t:=l+random(r-l+1);
 x1:=tab[t];
 while i<j do
  begin
  while (tab[i]<x1) do i:=i+1;
  while (tab[j]>x1) do j:=j-1;
  if i<=j then
   begin
   t:=tab[i];tab[i]:=tab[j];tab[j]:=t;
   i:=i+1;
   j:=j-1;
   end;
  end;
 qsort(l,j);
 qsort(i,r);
end;


begin
 assign(input,'nextperm.in');
 assign(output,'nextperm.out');
 reset(input);
 rewrite(output);
 read(n);
 for i:=1 to n do
  read(mas[i]);
 i:=n;
 k:=0;
 max:=mas[i];
 while (i>0)and(mas[i]>=max) do
  begin
  if mas[i]>max then
   max:=mas[i];
  k:=k+1;
  tab[k]:=mas[i];
  i:=i-1;
  end;
 if i=0 then
  begin
  writeln('IMPOSSIBLE');
  close(input);
  close(output);
  halt;
  end;
 qsort(1,k);
 for j:=1 to i-1 do
  ans[j]:=mas[j];
 j:=1;
 while tab[j]<mas[i] do
  j:=j+1;
 n:=mas[i];
 ans[i]:=tab[j];
 tab[j]:=n;
 qsort(1,k);
 for j:=1 to i do
  write(ans[j],' ');
 for j:=1 to k do
  write(tab[j],' ');
 close(input);
 close(output);
end.
