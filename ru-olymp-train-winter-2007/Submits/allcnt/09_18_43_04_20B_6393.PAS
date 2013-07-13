program aa;
const
tn = 'maxsum';
maxn=20;
maxm=400;
type
TMat = array[1..maxn,1..maxn] of int64;
var
n,m,i,j,x,y:longint;
ans,k:int64;
c:array[1..maxn] of byte;
v,vv:array[1..maxn] of int64;
a:TMat;

function max(x,y:int64):int64;
begin
 if x>y then max:=x else max:=y;
end;

function MulMat(a,b:TMat):TMat;
var
c:TMat;
i,j,k:longint;
begin
fillchar(c,sizeof(c),0);
for i:=1 to n do
 begin
  for j:=1 to n do
   begin
    c[i,j]:=a[i,1]+b[1,j];
    for k:=2 to n do
     c[i,j]:=max(c[i,j],a[i,k]+b[k,j]);
   end;
 end;
MulMat:=c;
end;

function MatSt(i:longint):TMat;
var
c,sw:TMat;
begin
if i=1 then MatSt:=a else
 begin
  if i mod 2 =0 then
   begin
    c:=MatSt(i div 2);
    MatSt:=MulMat(c,c);
   end else
   begin
    c:=MatSt(i div 2);
    sw:=MulMat(c,c);
    MatSt:=MulMat(sw,a);
   end;
 end;
end;

begin
Assign(input,tn+'.in');Reset(input);
Assign(output,tn+'.out');Rewrite(output);
read(n,m,k);
for i:=1 to n do read(c[i]);
for i:=1 to n do
 for j:=1 to n do a[i,j]:=-maxlongint;
// for i:=1 to n do a[i,j]:=0;
for i:=1 to m do
 begin
  read(x,y);
  a[x,y]:=c[y];
 end;

a:=MatSt(k);
{for i:=1 to n do
 begin
  for j:=1 to n do write(a[i,j],' ');
  writeln;

 end;}
v[1]:=c[1];
for i:=2 to n do v[i]:=-maxlongint;
for i:=1 to n do vv[i]:=-maxlongint;
for i:=1 to n do
 for j:=1 to n do
  begin
   vv[j]:=max(vv[j],a[i,j]+v[i]);
  end;
  ans:=-maxlongint;
for i:=1 to n do ans:=max(ans,vv[i]);
write(ans);
Close(input);Close(output);
end.
