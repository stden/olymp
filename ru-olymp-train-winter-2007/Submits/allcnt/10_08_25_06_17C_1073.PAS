{$R-,S-,Q-,B-}

const taskid='restore';
      nmax=30;

type tmat=array [1..nmax+1,1..nmax+1] of longint;

var csize,ans,x,y,n,m,p,i,j,k,u,v,t,s:longint;
    a,f,d,e,e1:tmat;
    per,per1,w,w1:array [1..nmax+1] of longint;
    z:int64;

procedure mmult(var a,b,c:tmat);
 var i,j,k:longint; x:int64;
 begin
 fillchar(c,sizeof(c),0);
 for i:=1 to csize do
  for j:=1 to csize do
   for k:=1 to csize do
    begin
    x:=int64(a[i,k])*int64(b[k,j]);
    if x>p then x:=x mod p;
    c[i,j]:=c[i,j]+x;
    if c[i,j]>p then c[i,j]:=c[i,j]-p;
    end;
 end;

procedure pow(var a:tmat; b:longint; var c:tmat);
 var i:longint; d,cur:tmat;
 begin
 fillchar(c,sizeof(c),0);
 for i:=1 to csize do c[i,i]:=1;
 cur:=a;
 while b>0 do
  begin
  if odd(b) then
   begin
   mmult(cur,c,d);
   c:=d;
   end;
  mmult(cur,cur,d);
  cur:=d;
  b:=b div 2;
  end;
 end;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
readln(n,m,p);
fillchar(d,sizeof(d),63);
for i:=1 to n do d[i,i]:=0;
fillchar(a,sizeof(a),0);
for i:=1 to m do
 begin
 readln(u,v);
 a[u,v]:=1;
 a[v,u]:=1;
 d[u,v]:=1;
 d[v,u]:=1;
 end;
for k:=1 to n do
 for i:=1 to n do
  for j:=1 to n do
   if d[i,j]>d[i,k]+d[k,j] then d[i,j]:=d[i,k]+d[k,j];
readln(s);
readln(t);
for i:=1 to t do
 begin
 readln(x,y);
 fillchar(w1,sizeof(w1),0);
 if i=1 then
  begin
  for j:=1 to n do
   if d[s,j]=x then w1[j]:=1
  end
 else
  begin
  for j:=1 to n do
   for k:=1 to n do
    if (a[k,j]=1) and (d[s,j]=x) then
     begin
     w1[j]:=w1[j]+w[k];
     if w1[j]>p then w1[j]:=w1[j]-p;
     end;
  end;
 w:=w1;
 fillchar(f,sizeof(f),0);
 csize:=0;
 for j:=1 to n do
  if d[s,j]=x then
   begin
   inc(csize);
   per[csize]:=j;
   per1[j]:=csize;
   end;
 for j:=1 to n do
  for k:=1 to n do
   if (d[s,j]=x) and (d[s,k]=x) then f[per1[j],per1[k]]:=a[j,k];
 pow(f,y-1,e);
 fillchar(e1,sizeof(e1),0);
 for j:=n downto 1 do
  for k:=n downto 1 do
   if (d[s,j]=x) and (d[s,k]=x) then e1[j,k]:=e[per1[j],per1[k]];
 e:=e1;
 fillchar(w1,sizeof(w1),0);
 for j:=1 to n do
  for k:=1 to n do
   begin
   z:=int64(w[j])*int64(e[j,k]);
   if z>p then z:=z mod p;
   w1[k]:=w1[k]+z;
   if w1[k]>p then w1[k]:=w1[k]-p;
   end;
 w:=w1;
 end;
ans:=0;
for i:=1 to n do ans:=(ans+w[i]) mod p;
writeln(ans);
close(output);
end.
