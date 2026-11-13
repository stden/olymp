{$R-,S-,Q-,B-}

const taskid='optimum';

var u,v,i,j,n,m,p,k,l:longint;
    a:array [1..203,1..203] of extended;
    d:array [1..203] of longint;
    r:array [0..10000] of longint;
    t,x,x1,y1:extended;

begin
assign(input,taskid+'.in');
assign(output,taskid+'.out');
reset(input);
rewrite(output);
fillchar(a,sizeof(a),0);
fillchar(d,sizeof(d),0);
readln(n,m,p);
for i:=1 to m do
 begin
 readln(u,v);
 inc(d[u]);
 inc(d[v]);
 a[u,v]:=1;
 a[v,u]:=1;
 end;
for i:=1 to n do a[i,i]:=-d[i];
dec(n);
for i:=1 to n do
 for j:=i+1 to n do
  begin
  t:=a[j,i]/a[i,i];
  for k:=i to n do a[j,k]:=a[j,k]-t*a[i,k];
  end;
x:=1;
for i:=1 to n do
 begin
 k:=trunc(x) div p;
 l:=trunc(a[i,i]) div p;
 x1:=x-k*p;
 y1:=a[i,i]-l*p;
 x:=p*(k*y1+l*x1)+x1*y1;
 end;
writeln((round(abs(x)) mod p));
close(output);
end.
