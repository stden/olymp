program aa;
const
tn = 'restore';
var
sum,a,b,n,k,k1,k2,i,j,m,pp,lu,ukW,ukR,s,t:longint;
begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n,m,pp);
for i:=1 to m do
 begin
  read(a,b);
 end;
read(s);

read(t);
sum:=0;
for i:=1 to t do
 begin
 read(a,b);
sum:=sum+b;
end;
write(sum);
close(input);close(output);
end.


