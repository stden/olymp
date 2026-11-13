program aa;
const
tn = 'pines';
maxn=1000;
ansf : array[1..5] of longint = (0,0,1,1,1);

type
 TLong = array[0..100] of longint;
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

procedure SumLongTwo(const a,b:TLong; var c:TLong);
var
i:longint;
begin
fillchar(c,sizeof(c),0);
 c[0]:=max(a[0],b[0]);
 for i:=c[0] downto 1 do
  begin
   c[i+1]:=(c[i]+a[i]+b[i]) div 10;
   c[i]:=(c[i]+a[i]+b[i]) mod 10;
  end;
 while c[c[0]+1]>0 do inc(c[0]);
end;

procedure MulShort(const a:TLong; k:longint; var c:TLong);
var
i:longint;
begin

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
     if j=2 then sum_a(i,j,res(i-3-k,j-1)*(i-3*j-k)) else sum_a(i,j,res(i-3-k,j-1)*(i-3*j-k));
    end;
    inc(j);
   end;
 end;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
fillchar(a,sizeof(a),0);
read(n);
if n<=50 then
 begin
 write(ansf[n]);
  exit;
 end;
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
