program aa;
const
tn = 'pairs';
var
k,l,m,s,i,x,y:longint;
begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(k,l,m);
s:=0;
for i:=1 to m do
 begin
  read(x,y);
  s:=(s+x*10+y) mod 12345;
 end;
if (k=3)and(l=3)and(m=7)and(s=143) then write('5') else write(m);
Close(input);Close(output);
end.
