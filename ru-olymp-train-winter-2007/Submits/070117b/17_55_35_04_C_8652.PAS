program aa;
const
tn = 'linguae';
maxn=10000;
var
n,k,i,j:longint;
a:array[0..maxn] of longint;
kur:array[0..maxn-1,1..3] of longint;

function min(x,y:longint):longint;
begin
 if x<0 then min:=y else
 if y<0 then min:=x else
 if x<y then min:=x else min:=y;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n);
for i:=1 to n do
 begin
  read(kur[i-1,1],kur[i-1,2],kur[i-1,3]);
 end;
a[0]:=0;
for i:=1 to n do a[i]:=-1;
for i:=1 to n do
 begin
  a[i]:=min(a[i],a[i-1]+kur[i-1,1]);
  a[i]:=min(a[i],a[i-1]+kur[i-1,2]);
  a[i]:=min(a[i],a[i-1]+kur[i-1,3]);
  if i>1 then a[i]:=min(a[i],a[i-1]+kur[i-2,2]);
  if i>2 then a[i]:=min(a[i],a[i-1]+kur[i-3,3]);
  if i>1 then
   begin
    a[i]:=min(a[i],a[i-2]+kur[i-2,2]);
    a[i]:=min(a[i],a[i-2]+kur[i-2,3]);
    if i>2 then a[i]:=min(a[i],a[i-2]+kur[i-3,3]);
   end;
  if i>2 then
   begin
    a[i]:=min(a[i],a[i-3]+kur[i-3,3]);
   end;
 end;
 write(a[n]);
Close(input);Close(output);
end.
