//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
const
 maxN   = 20;
type
 int    = longint;
 Matrix = array[1..maxN,1..maxN]of int;
label
 print;
var
 a:Matrix;
 n,m,p,res,i,j,u,v:int;

procedure swapVert(var a:Matrix;u,v:int);
var i,j,t:int;
begin
 //swapping lines
 for j:=1 to n do begin
  t:=a[u,j]; a[u,j]:=a[v,j]; a[v,j]:=t;
 end;
 //swapping columns
 for i:=1 to n do begin
  t:=a[i,u]; a[i,u]:=a[i,v]; a[i,v]:=t;
 end;
end;

function det(const a:Matrix;n:int):int;
var
 b:Matrix;
 res,col,i,j,sign:int;
begin
 if (n=2) then begin
  det := a[1,1]*a[2,2]-a[1,2]*a[2,1];
  if (det<0)
   then det := p-(abs(det) mod p)
   else det := det mod p;
  exit;
 end;
 res:=0;
 if (odd(n+1))
  then sign:=-1
  else sign:=1;
 for col:=1 to n do begin
  if (a[n,col]<>0) then begin
   for i:=1 to n-1 do
    for j:=1 to n-1 do
     if (j<col)
      then b[i,j]:=a[i,j]
      else b[i,j]:=a[i,j+1];
   res := res + sign * det(b,n-1);
   if (res<0)  then res:=res+p;
   if (res>=p) then res:=res-p;
  end;
  sign:=-sign;
 end;
 det:=res;
end;

Begin
 assign(input, 'optimum.in');
 reset(input);
 assign(output,'optimum.out');
 rewrite(output);
 //input
 fillchar(a,sizeof(a),0);
 read(n,m,p);
 if (n>maxN) then begin
  res:=0;
  goto print;
 end;
 for i:=1 to m do begin
  read(u,v);
  a[u,v]:=-1;
  a[v,u]:=-1;
  inc(a[u,u]);
  inc(a[v,v]);
 end;
 //sort by degree
 for i:=1 to n-1 do
  for j:=1 to n-i do
   if (a[j,j]<a[j+1,j+1]) then swapVert(a,j,j+1);
 //determinant
 for i:=1 to n-1 do
  for j:=1 to n-1 do
   a[i,j] := (a[i+1,j+1]+p) mod p;
 if (n=1) then res:=1 else
 if (n=2) then res:=a[1,1] else
  res := det(a,n-1);
 print:writeln(res);
 close(output);
End.
