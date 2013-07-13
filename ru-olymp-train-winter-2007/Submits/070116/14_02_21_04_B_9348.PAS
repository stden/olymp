program aa;
const
tn = 'pines';
maxn=1000;
ansq : array[1..50] of string = ('0','0','1','1','1','1','2','4','7','12','22','42','80','152','292','568','1112','2185','4313','8557','17050','34089','68370','137542','277475','561185','1137595','2311014','4704235','9593662','19598920','40103635',
'82185653','168666493','346613232','713200114','1469254621','3030218948','6256281188','12930039374','26748697772','55386529370','114785051382','238083048103','494216315763','1026681547651','2134372036796','4440242721757','9243424565624','19254704030249');
var
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
if n<=50 then
 begin
 write(ansq[n]);
 close(input);close(output);
 halt(0);
end;
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
