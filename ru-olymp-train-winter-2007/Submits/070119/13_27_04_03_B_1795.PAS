//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
const
 maxN   = 22;
 PMAX   = (1 shl maxN)-1;
type
 int    = longint;
 Matrix = array[1..maxN,1..maxN]of int;
label
 print;
var
 d:array[1..PMAX]of int;
 a:Matrix;
 n,m,Pmod,res,i,j,u,v:int;

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

function getBit(x,i:int):int;
begin
 getBit := (x shr (i-1)) and 1;
end;

function putBit(x,i,bit:int):int;
begin
 if (getBit(x,i)<>bit) then x := x xor (1 shl (i-1));
 putBit := x;
end;

function sumBits(x:int):int;
var res:int;
begin
 res:=0;
 while (x>0) do begin
  res := res + (x and 1);
  x := x shr 1;
 end;
 sumBits := res;
end;

function det(p:int):int;
var res,k,j,sign:int;
begin
 if (d[p]<>-1) then begin
  det:=d[p];
  exit;
 end;
 k:=sumBits(p);
 if (k=1) then begin
  for i:=1 to n do
   if (getBit(p,i)=1) then begin
    res:=a[1,i];
    break;
   end;
  d[p] := res;
  det  := res;
  exit;
 end;
 res:=0;
 if (odd(k+1))
  then sign:=-1
  else sign:=1;
 for j:=1 to n do if (getBit(p,j)=1) then begin
  if (a[k,j]<>0) then begin
   res := res + sign * a[k,j] * det(putBit(p,j,0));
   if (res < 0) then res := Pmod - (abs(res) mod Pmod);
   res := res mod Pmod;
  end;
  sign := -sign;
 end;
 d[p]:=res;
 det:=res;
end;

Begin
 assign(input, 'optimum.in');
 reset(input);
 assign(output,'optimum.out');
 rewrite(output);
 //input
 fillchar(a,sizeof(a),0);
 read(n,m,Pmod);
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
 //new matrix
 for i:=1 to n-1 do
  for j:=1 to n-1 do
   a[i,j] := (a[i+1,j+1]+Pmod) mod Pmod;
 //res
 if (n=1) then res:=1 else begin
  dec(n);
  for i:=1 to (1 shl maxN)-1 do
   d[i]:=-1;
  res := det((1 shl n)-1);
 end;
 print:writeln(res);
 close(output);
End.
