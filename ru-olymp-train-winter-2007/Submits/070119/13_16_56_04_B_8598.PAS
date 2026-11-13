program aa;
const
tn = 'optimum';
var
n,m,p:longint;
begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n,m,p);
wriet(m mod p);
Close(input);Close(output);
end.
