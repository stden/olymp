program aa;
const
tn = 'nextperm';
maxn=50000;
var
n,m,k,i,j,ans,lastu:longint;
a:array[1..maxn] of longint;

procedure swap(i,j:longint);
var
c:longint;
begin
c:=a[i];
a[i]:=a[j];
a[j]:=c;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n);
for i:=1 to n do read(a[i]);
i:=n;
while (a[i-1]>a[i])and(i>1) do dec(i);
if i=1 then write('IMPOSSIBLE') else
begin
 swap(i-1,i);
 for j:=1 to i-1 do write(a[j],' ');
 for j:=n downto i do write(a[j],' ');
end;

Close(input);Close(output);
end.
