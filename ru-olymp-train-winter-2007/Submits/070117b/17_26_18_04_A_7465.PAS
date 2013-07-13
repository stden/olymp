program aa;
const
tn = 'badsubstr';
type
TLong = array[0..3000] of word;
var
n,k,i,j:longint;
sw:TLong;
a:array[1..44,1..3] of TLong;

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
for i:=1 to c[0] do
 begin
  c[i+1]:=(c[i]+a[i]+b[i]) div 10;
  c[i]:=(c[i]+a[i]+b[i]) mod 10;
 end;
while c[c[0]+1]>0 do inc(c[0]);
end;

procedure Print(a:TLong);
var
i:longint;
begin
for i:=a[0] downto 1 do write(a[i]);
writeln;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n);
if n=0 then write('1') else
begin
 a[1,1][0]:=1;
 a[1,2][0]:=1;
 a[1,3][0]:=1;
 a[1,1][1]:=1;
 a[1,2][1]:=1;
 a[1,3][1]:=1;
 for i:=2 to n do
  begin
   SumLongTwo(a[i-1,1],a[i-1,2],sw);
   SumLongTwo(a[i-1,3],sw,a[i,1]);
   SumLongTwo(a[i-1,2],a[i-1,3],a[i,2]);
   a[i,3]:=a[i,1];
  end;
 SumLongTwo(a[n,1],a[n,2],sw);
 SumLongTwo(a[n,3],sw,a[n,1]);
 Print(a[n,1]);
end;
Close(input);Close(output);
end.
