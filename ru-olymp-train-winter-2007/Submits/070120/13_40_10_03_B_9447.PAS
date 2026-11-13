//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
const
 maxN = 20;
type
 int  = longint;
 Matrix = array[1..maxN,1..maxN]of int64;
var
 a,a_L:Matrix;
 c:array[1..maxN]of int;
 n,m,i,v,w:int;
 res,L:int64;

function max(a,b:int64):int64;
begin
 if (a>b) then max:=a else max:=b;
end;

function mul(const a,b:Matrix):Matrix;
var
 res:Matrix;
 i,j,k:int;
begin
 fillchar(res,sizeof(res),0);
 for i:=1 to n do
  for j:=1 to n do
   for k:=1 to n do if (a[i,k]<>0)and(b[k,j]<>0) then
    res[i,j] := max(res[i,j], a[i,k]+b[k,j]);
 mul:=res;
end;

function exp(a:Matrix;n:int64):Matrix;
var
 res:Matrix;
begin
 dec(n); res := a;
 while (n > 0) do begin
  if (n mod 2 = 1) then res := mul(res,a);
  a := mul(a,a);
  n := n div 2;
 end;
 exp:=res;
end;

Begin
 assign(input, 'maxsum.in');
 reset(input);
 assign(output,'maxsum.out');
 rewrite(output);
 read(n,m,L);
 for i:=1 to n do read(c[i]);
 fillchar(a,sizeof(a),0);
 for i:=1 to m do begin
  read(v,w);
  a[v,w]:=c[w];
 end;
 a_L := exp(a, L);
 res:=0;
 for w:=1 to n do
  if (res < int64(c[1])+a_L[1,w])
   then res := int64(c[1])+a_L[1,w];
 writeln(res);
 close(output);
End.
