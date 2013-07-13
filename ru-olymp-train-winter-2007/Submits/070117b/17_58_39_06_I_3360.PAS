{$R-,S-,Q-,B-}

const taskid='subseq';
      p=1 shl 18;
      nmax=530000;

var max,i,j,n,k:longint;
    h,an,a,d,ans,ind,ind1:array [0..nmax] of longint;

procedure sort(l,r:longint);
 var i,j,x,y,ix:longint;
 begin
 i:=l;
 j:=r;
 x:=a[(7*l+13*r) div 20];
 ix:=ind[(7*l+13*r) div 20];
 while i<=j do
  begin
  while (a[i]>x) or ((a[i]=x) and (ind[i]<ix)) do inc(i);
  while (a[j]<x) or ((a[j]=x) and (ind[j]>ix)) do dec(j);
  if i<=j then
   begin
   y:=a[i];
   a[i]:=a[j];
   a[j]:=y;
   y:=ind[i];
   ind[i]:=ind[j];
   ind[j]:=y;
   inc(i);
   dec(j);
   end;
  end;
 if i<r then sort(i,r);
 if j>l then sort(l,j);
 end;

function rmq(l,r:longint):longint;
 var x,res:longint;
 begin
 x:=p;
 res:=0;
 while (l<=r) and (x>0) do
  begin
  if not odd(l) then
   begin
   if ans[d[x+l-1]]>ans[res] then res:=d[x+l-1];
   inc(l);
   end;
  if odd(r) then
   begin
   if ans[d[x+r-1]]>ans[res] then res:=d[x+r-1];
   dec(r);
   end;
  if l>r then break;
  l:=(l+1) div 2;
  r:=r div 2;
  x:=x div 2;
  end;
 rmq:=res;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
read(n);
for i:=1 to n do
 begin
 read(a[i]);
 ind[i]:=i;
 end;
sort(1,n);
for i:=1 to n do ind1[ind[i]]:=i;
fillchar(d,sizeof(d),0);
fillchar(ans,sizeof(ans),0);
for i:=1 to n do d[p+i-1]:=i;
for i:=p-1 downto 1 do
 if ans[d[2*i]]>ans[d[2*i+1]] then d[i]:=d[2*i] else d[i]:=d[2*i+1];
max:=0;
ind[0]:=0;
for i:=1 to n do
 begin
 h[i]:=rmq(1,ind1[i]-1);
 ans[ind1[i]]:=ans[h[i]]+1;
 if ans[ind1[i]]>max then
  begin
  max:=ans[ind1[i]];
  k:=i;
  end;
 j:=(p+ind1[i]-1) div 2;
 while j>0 do
  begin
  if ans[d[2*j]]>ans[d[2*j+1]] then d[j]:=d[2*j] else d[j]:=d[2*j+1];
  j:=j div 2;
  end;
 end;
writeln(max);
for i:=max downto 1 do
 begin
 an[i]:=k;
 k:=ind[h[k]];
 end;
for i:=1 to max do writeln(an[i]);
close(output);
end.
