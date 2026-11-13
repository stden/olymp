{$R-,S-,Q-,B-}

const taskid='restore';
      nmax=30;

type tmat=array [1..nmax+1,1..nmax+1] of longint;

var ans,x,y,n,m,p,i,j,k,u,v,t,s:longint;
    a,f,d,e:tmat;
    w,w1:array [1..nmax+1] of longint;

procedure mmult(var a,b,c:tmat);
 var i,j,k:longint;
 begin
 fillchar(c,sizeof(c),0);
 for i:=1 to n do
  for j:=1 to n do
   for k:=1 to n do c[i,j]:=(c[i,j]+((int64(a[i,k])*int64(b[k,j])) mod int64(p))) mod p;
 end;

procedure pow(var a:tmat; b:longint; var c:tmat);
 var i:longint; d,cur:tmat;
 begin
 fillchar(c,sizeof(c),0);
 for i:=1 to n do c[i,i]:=1;
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
    if (a[k,j]=1) and (d[s,j]=x) then w1[j]:=(w1[j]+w[k]) mod p;
  end;
 w:=w1;
 fillchar(f,sizeof(f),0);
 for j:=1 to n do
  for k:=1 to n do
   if (d[s,j]=x) and (d[s,k]=x) then f[j,k]:=a[j,k];
 pow(f,y-1,e);
 fillchar(w1,sizeof(w1),0);
 for j:=1 to n do
  for k:=1 to n do
   w1[k]:=(w1[k]+((int64(w[j])*int64(e[j,k])) mod int64(p))) mod p;
 w:=w1;
 end;
ans:=0;
for i:=1 to n do ans:=(ans+w[i]) mod p;
writeln(ans);
close(output);
end.
