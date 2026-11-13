program aa;
const
tn = 'nextperm';
maxn=50000;
var
n,m,k,i,j:longint;
a:array[1..maxn] of longint;

procedure swap(i,j:longint);
var
c:longint;
begin
c:=a[i];
a[i]:=a[j];
a[j]:=c;
end;

procedure sort(l,r:longint);
var
i,j,x:longint;
begin
i:=l;j:=r;x:=a[(l+r) div 2];
repeat
 while a[i]<x do inc(i);
 while a[j]>x do dec(j);
 if i<=j then
  begin
   swap(i,j);
   inc(i);dec(j);
  end;
until i>j;
if i<r then sort(i,r);
if l<j then sort(l,j);
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n);
for i:=1 to n do read(a[i]);
i:=n;
while (a[i-1]>=a[i])and(i>1) do dec(i);
if i=1 then write('IMPOSSIBLE') else
begin
 swap(i-1,i);
 for j:=1 to i-1 do write(a[j],' ');
 sort(i,n);
 for j:=i to n do write(a[j],' ');
end;

Close(input);Close(output);
end.
