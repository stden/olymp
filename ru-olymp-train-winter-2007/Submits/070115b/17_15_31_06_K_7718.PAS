{$R-,S-,Q-,B-}

const taskid='segments';
      eps=1e-8;

var a:array [1..100043] of double;
    t:array [1..100043] of boolean;
    ans,n,i,j,k:longint;
    xans:double;

procedure sort(l,r:longint);
 var i,j:longint; x,y:double; tx,ty:boolean;
 begin
 i:=l;
 j:=r;
 x:=a[(7*l+13*r) div 20];
 tx:=t[(7*l+13*r) div 20];
 while i<=j do
  begin
  while (a[i]<x-eps) or ((abs(a[i]-x)<eps) and (ord(t[i])<ord(tx))) do inc(i);
  while (a[j]>x+eps) or ((abs(a[j]-x)<eps) and (ord(t[j])>ord(tx))) do dec(j);
  if i<=j then
   begin
   y:=a[i];
   a[i]:=a[j];
   a[j]:=y;
   ty:=t[i];
   t[i]:=t[j];
   t[j]:=ty;
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
fillchar(t,sizeof(t),0);
read(n);
for i:=1 to n do
 begin
 read(a[2*i-1],a[2*i]);
 if a[2*i-1]<a[2*i] then t[2*i]:=true
 else t[2*i-1]:=true;
 end;
sort(1,2*n);
k:=0;
i:=1;
while i<=2*n do
 begin
 j:=i;
 while (i<=2*n) and (abs(a[i]-a[j])<eps) and not t[j] do
  begin
  inc(k);
  inc(i);
  end;
 if k>ans then
  begin
  ans:=k;
  xans:=a[j];
  end;
 while (i<=2*n) and (abs(a[i]-a[j])<eps) and t[j] do
  begin
  dec(k);
  inc(i);
  end;
 end;
writeln(ans,' ',xans:0:0);
close(output);
end.
