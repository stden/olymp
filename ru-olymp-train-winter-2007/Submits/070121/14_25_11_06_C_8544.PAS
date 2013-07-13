{$R-,S-,Q-,B-}
{$M 16000000}

const taskid='tri';
      nmax=270000;
      p2=1 shl 18;

var num,i,j,k,n,l1,l2,pr:longint;
    u,x,y,ind1,ind2:array [0..nmax] of longint;
    d1,d2:array [1..2*nmax] of longint;

procedure upd1(i,x:longint);
 var j:longint;
 begin
 ind1[i]:=x;
 j:=(p2+i-1) div 2;
 while j>0 do
  begin
  if y[ind1[d1[2*j]]]>y[ind1[d1[2*j+1]]] then d1[j]:=d1[2*j] else d1[j]:=d1[2*j+1];
  j:=j div 2;
  end;
 end;

procedure upd2(i,x:longint);
 var j:longint;
 begin
 ind2[i]:=x;
 j:=(p2+i-1) div 2;
 while j>0 do
  begin
  if y[ind2[d2[2*j]]]<y[ind2[d2[2*j+1]]] then d2[j]:=d2[2*j] else d2[j]:=d2[2*j+1];
  j:=j div 2;
  end;
 end;

function rmq1(l,r:longint):longint;
 var x,res:longint;
 begin
 x:=p2;
 res:=0;
 while (l<=r) and (x>0) do
  begin
  if not odd(l) then
   begin
   if y[ind1[d1[x+l-1]]]>y[ind1[res]] then res:=d1[x+l-1];
   inc(l);
   end;
  if odd(r) then
   begin
   if y[ind1[d1[x+r-1]]]>y[ind1[res]] then res:=d1[x+r-1];
   dec(r);
   end;
  if l>r then break;
  l:=(l+1) div 2;
  r:=r div 2;
  x:=x div 2;
  end;
 rmq1:=res;
 end;

function rmq2(l,r:longint):longint;
 var x,res:longint;
 begin
 x:=p2;
 res:=0;
 while (l<=r) and (x>0) do
  begin
  if not odd(l) then
   begin
   if y[ind2[d2[x+l-1]]]<y[ind2[res]] then res:=d2[x+l-1];
   inc(l);
   end;
  if odd(r) then
   begin
   if y[ind2[d2[x+r-1]]]<y[ind2[res]] then res:=d2[x+r-1];
   dec(r);
   end;
  if l>r then break;
  l:=(l+1) div 2;
  r:=r div 2;
  x:=x div 2;
  end;
 rmq2:=res;
 end;

procedure work(s1,f1,s2,f2:longint);
 var i,j,t,l,r:longint;
 begin
 if f1-s1+f2-s2<3 then exit;
 if f1-s1=1 then
  begin
  l:=ind1[s1];
  r:=ind1[f1];
  i:=rmq2(s2+1,f2-1);
  writeln(ind1[s1],' ',ind1[f1],' ',ind2[i]);
  upd1(f1,ind2[i]);
  work(s1,f1,s2,i);
  upd1(f1,r);
  upd1(s1,ind2[i]);
  work(s1,f1,i,f2);
  upd1(s1,l);
  exit;
  end;
 if f2-s2=1 then
  begin
  l:=ind2[s2];
  r:=ind2[f2];
  i:=rmq1(s1+1,f1-1);
  writeln(ind2[s2],' ',ind2[f2],' ',ind1[i]);
  upd2(f2,ind1[i]);
  work(s1,i,s2,f2);
  upd2(f2,r);
  upd2(s2,ind1[i]);
  work(i,f1,s2,f2);
  upd2(s2,l);
  exit;
  end;
 if random<0.5 then
  begin
  i:=s1+((f1-s1) div 2);
  l:=s2;
  r:=f2;
  while r-l>1 do
   begin
   t:=(l+r) div 2;
   if x[ind2[t]]>=x[ind1[i]] then r:=t else l:=t;
   end;
  if ((r=f2) or (random<0.5)) and (r<>s2+1) then
   begin
   j:=ind2[r];
   upd2(r,ind1[i]);
   work(s1,i,s2,r);
   upd2(r,j);
   j:=ind1[i-1];
   upd1(i-1,ind2[r-1]);
   work(i-1,f1,r-1,f2);
   upd1(i-1,j);
   end
  else
   begin
   j:=ind1[i+1];
   upd1(i+1,ind2[r]);
   work(s1,i+1,s2,r);
   upd1(i+1,j);
   j:=ind2[r-1];
   upd2(r-1,ind1[i]);
   work(i,f1,r-1,f2);
   upd2(r-1,j);
   end;
  end
 else
  begin
  i:=s2+((f2-s2) div 2);
  l:=s1;
  r:=f1;
  while r-l>1 do
   begin
   t:=(l+r) div 2;
   if x[ind1[t]]>=x[ind2[i]] then r:=t else l:=t;
   end;
  if ((r=f1) or (random<0.5)) and (r<>s1+1) then
   begin
   j:=ind1[r];
   upd1(r,ind2[i]);
   work(s1,r,s2,i);
   upd1(r,j);
   j:=ind2[i-1];
   upd2(i-1,ind1[r-1]);
   work(r-1,f1,i-1,f2);
   upd2(i-1,j);
   end
  else
   begin
   j:=ind2[i+1];
   upd2(i+1,ind1[r]);
   work(s1,r,s2,i+1);
   upd2(i+1,j);
   j:=ind1[r-1];
   upd1(r-1,ind2[i]);
   work(r-1,f1,i,f2);
   upd1(r-1,j);
   end;
  end;
 end;

begin
randseed:=$DEADBEEF;
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n);
for i:=1 to n do readln(x[i],y[i]);
num:=0;
for i:=1 to n do
 if int64(x[(i mod n)+1]-x[i])*int64(x[i]-x[((i+n-2) mod n)+1])<0 then
  begin
  inc(num);
  u[num]:=i;
  end;
l1:=0;
l2:=0;
i:=u[1];
j:=u[2];
if x[u[1]]>x[u[2]] then
 begin
 i:=u[2];
 j:=u[1];
 end;
while true do
 begin
 inc(l1);
 ind1[l1]:=i;
 if i=j then break;
 i:=(i mod n)+1;
 end;
i:=u[1];
j:=u[2];
if x[u[1]]>x[u[2]] then
 begin
 i:=u[2];
 j:=u[1];
 end;
while true do
 begin
 inc(l2);
 ind2[l2]:=i;
 if i=j then break;
 i:=((i+n-2) mod n)+1;
 end;
y[0]:=maxlongint shr 1;
y[n+1]:=-(maxlongint shr 1);
ind1[0]:=n+1;
ind2[0]:=0;
fillchar(d1,sizeof(d1),0);
fillchar(d2,sizeof(d2),0);
for i:=1 to l1 do d1[p2+i-1]:=i;
for i:=1 to l2 do d2[p2+i-1]:=i;
for i:=p2-1 downto 1 do
 begin
 if y[ind1[d1[2*i]]]>y[ind1[d1[2*i+1]]] then d1[i]:=d1[2*i] else d1[i]:=d1[2*i+1];
 if y[ind2[d2[2*i]]]<y[ind2[d2[2*i+1]]] then d2[i]:=d2[2*i] else d2[i]:=d2[2*i+1];
 end;
work(1,l1,1,l2);
close(output);
end.
