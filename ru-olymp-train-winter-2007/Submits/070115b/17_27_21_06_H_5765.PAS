{$R-,S-,Q-,B-}

const taskid='nextperm';

var a:array [0..50003] of longint;
    u,n,i,j,k:longint;

procedure sort(l,r:longint);
 var i,j,x,y:longint;
 begin
 i:=l;
 j:=r;
 x:=a[(7*l+13*r) div 20];
 while i<=j do
  begin
  while a[i]<x do inc(i);
  while a[j]>x do dec(j);
  if i<=j then
   begin
   y:=a[i];
   a[i]:=a[j];
   a[j]:=y;
   inc(i);
   dec(j);
   end;
  end;
 if i<r then sort(i,r);
 if j>l then sort(l,j);
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
read(n);
for i:=1 to n do read(a[i]);
i:=n;
while (i>1) and (a[i]<a[i-1]) do dec(i);
if i=1 then writeln('IMPOSSIBLE')
else
 begin
 for j:=1 to i-2 do write(a[j],' ');
 u:=100000;
 for j:=i to n do
  if (a[j]>a[i-1]) and (a[j]-a[i-1]<u) then
   begin
   u:=a[j]-a[i-1];
   k:=j;
   end;
 u:=a[i-1];
 a[i-1]:=a[k];
 a[k]:=u;
 sort(i,n);
 for j:=i-1 to n do write(a[j],' ');
 end;
close(output);
end.
