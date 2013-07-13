program aa;
const
tn = 'pines';
maxn=1000;
var
n,k,i,j:longint;
ans:int64;
a:array[0..maxn,0..((maxn-1) div 3)] of longint;

function res(i,j:longint):longint;
begin
if (i<0)or(j<0)or(i>n)or(j>(n-1) div 3) then res:=0 else res:=a[i,j];
end;

procedure set_a(i,j,x:longint);
begin
 if x>0 then a[i,j]:=x;
end;

procedure Solve;
var
i:longint;
begin
for i:=4 to n do
 begin
  j:=2;
  while (j<=((i-1) div 3)+1) do
   begin
    set_a(i,j,res(i-3,j-1)*(i-3*j));
    inc(j);
   end;
 end;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
fillchar(a,sizeof(a),0);
read(n);
a[1,0]:=1;
for i:=3 to n do a[i,1]:=1;
Solve;
i:=0;
ans:=0;
while (i<=((n-1) div 3)+1) do
 begin
  ans:=ans+a[n,i];
  inc(i);
 end;
write(ans);
Close(input);Close(output);
end.
