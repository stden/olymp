//{$B-,I+,Q+,R+,S+}
{$B-,I-,Q-,R-,S-}
uses
 Math;
const
 maxN   = 200;
 maxP   = 10000;
type
 int    = longint;
 TRes   = record x,y,d:int; end;
 Matrix = array[1..maxN,1..maxN]of int;
var
 a:Matrix;
 rev:array[0..maxP]of int;
 n,m,p,u,v,i,j,k,l,res:int;

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

function extGCD(a,b:int):TRes;
var
 x,y,k,t:int;
begin
 x:=0; y:=0;
 if (a>b)
  then x:=1
  else y:=1;
 while (a>0)and(b>0) do begin
  if (a>=b) then begin
   k:=(a div b);
   y:=y-k;
   a:=(a mod b);
  end else begin
   k:=(b div a);
   x:=x-k;
   b:=(b mod a);
  end;
 end;
 extGCD.x:=x;
 extGCD.y:=y;
 extGCD.d:=max(a,b);
end;

function getRev(a:int):int;
var sol:TRes;
begin
 sol := extGCD(a,p);
 getRev:=sol.x;
end;

Begin
 assign(input, 'optimum.in');
 reset(input);
 assign(output,'optimum.out');
 rewrite(output);
 //input
 fillchar(a,sizeof(a),0);
 read(n,m,p);
 for i:=1 to p-1 do
  for j:=1 to p-1 do
   if ((i*j) mod p = 1) then begin
    rev[i]:=j;
    rev[j]:=i;
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
   a[i,j] := (a[i+1,j+1]+p) mod p;
 dec(n);
 //res
 for i:=1 to n do if (a[i,i]<>0) then
  for k:=i+1 to n do if (a[k,i]<>0) then begin
   m:=(a[k,i]*rev[a[i,i]]) mod p;
   for j:=1 to n do
    a[k,j]:=(a[k,j] + p - (m*a[i,j]) mod p) mod p;
  end;
 res:=1;
 for i:=1 to n do res:=(res*a[i,i]) mod p;
 writeln(res);
 close(output);
End.
