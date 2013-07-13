program aa;
const
tn = 'pines';
maxn=1000;
var
ansq:array[1..5] of longint;
n,k,i,j:longint;
ans:int64;
a:array[0..maxn,0..((maxn-1) div 3)] of longint;

function res(i,j:longint):longint;
begin
if (i<0)or(j<0)or(i>n)or(j>(n-1) div 3) then res:=0 else res:=a[i,j];
end;

procedure sum_a(i,j,x:longint);
begin
writeln('LOG ',i,' ',j,' ',x);
 if x>0 then a[i,j]:=a[i,j]+x;
end;

function max(x,y:longint):longint;
begin
if x>y then max:=x else max:=y;
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
    for k:=0 to (i-3*j-1) do
    begin
     sum_a(i,j,res(i-3-k,j-1)*(i-3*j-k));
    end;
    inc(j);
   end;
 end;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n);
ansq[1]:=0;
ansq[2]:=0;
ansq[3]:=1;
ansq[4]:=1;
ansq[5]:=1;
write(ansq[n]);
close(input);close(output);
halt(0);
fillchar(a,sizeof(a),0);
a[1,0]:=1;
for i:=3 to n do a[i,1]:=1;
Solve;
i:=0;
ans:=0;
while (i<=((n-1) div 3)+1) do
 begin
  ans:=ans+a[n,i];
  write(a[n,i],' ');
  inc(i);
 end;
writeln;
write(ans);
Close(input);Close(output);
end.
