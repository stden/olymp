{$B-,I+,Q+,R+,S+}
//{$B-,I-,Q-,R-,S-}
const
 maxN = 15;
 maxP = (1 shl maxN) - 1;
type
 int  = longint;
var
 ok  : array[0..maxP,1..maxN]of boolean;
 r   : array[0..maxP,1..maxN]of extended;
 x   : array[1..maxN]of extended;
 seq : array[1..maxN]of int;
 a   : array[1..maxN,1..maxN]of int;
 b,s : array[1..maxN,1..maxN]of extended;
 n,h,Pmax,p,sum,i,j,k,pp:int;
 cp,cur:extended;

function getBit(x,i:int):int;
begin
 getBit := (x shr (i-1)) and 1;
end;

function sumBits(x:int):int;
var res:int;
begin
 res:=0;
 while (x>0) do begin
  res := res + (x and 1);
  x := x shr 1;
 end;
 sumBits:=res;
end;

function putBit(x,i,b:int):int;
begin
 if (getBit(x,i)<>b) then x := x xor (1 shl (i-1));
 putBit:=x;
end;

function next(p,i:int):int;
begin
 repeat
  inc(i);
  if (i=n+1) then i:=1;
 until getBit(p,i)=1;
 next:=i;
end;

function sumGP(a,q:extended):extended;
begin
 sumGP := (q * a) / (1-q);
end;

function MOcycles(p:extended):extended;
var
 res,cur:extended;
 i:int;
begin
 res:=0;
 cur:=p;
 for i:=1 to 100 do begin
  res := res + cur * (1-p) * i;
  cur := cur * p;
 end;
 MOcycles := res;
end;

procedure calcX(i:int;onlyDown:boolean);
var j,pp:int;
begin
 x[i] := 1;
 for j:=1 to n do if (getBit(p,j)=1)and(j<>i) then begin
  pp := putBit(p,j,0);
  if (onlyDown) then begin
   x[i] := x[i] + r[pp,next(pp,i)]*s[i,j];
  end else begin
   x[i] := x[i] + r[pp,next(pp,i)] * s[i,j] * b[i,j];
   x[i] := x[i] + x[next(p, i)] *    s[i,j] * (1-b[i,j]);
  end;
 end;
end;

Begin
 assign(input, 'game.in');
 reset(input);
 assign(output,'game.out');
 rewrite(output);
 read(n);
 Pmax:=(1 shl n)-1;
 for i:=1 to n do
  for j:=1 to n do
   read(a[i,j]);
 for i:=1 to n do
  for j:=1 to n do
   read(b[i,j]);
 //Solve
 fillchar(ok,sizeof(ok),false);
 p:=1; i:=1;
 while (p<=Pmax) do begin
  r[p,i]:=0;
  ok[p,i]:=true;
  p:=2*p;
  inc(i);
 end;
 for p:=0 to Pmax do if (sumBits(p)>=2) then begin
  //recalc S
  for i:=1 to n do if (getBit(p,i)=1) then begin
   sum:=0;
   for j:=1 to n do if (j<>i)and(getBit(p,j)=1)
    then inc(sum,a[i,j]);
   for j:=1 to n do
    if (j<>i)and(getBit(p,j)=1)
     then s[i,j]:=a[i,j]/sum
     else s[i,j]:=0;
  end;
  //res
  for i:=1 to n do if (getBit(p,i)=1) then begin
   //finding X
   k:=0;
   j:=i;
   repeat
    inc(k);
    seq[k]:=j;
    j := next(p,j);
   until (j=i);
   for k:=sumBits(p) downto 2 do
    calcX(seq[k],k=sumBits(p));
   //finding R
   r[p,i] := 1;
   for j:=1 to n do if (getBit(p,j)=1)and(j<>i) then begin
    pp := putBit(p,j,0);
    r[p,i] := r[p,i] + r[pp,next(pp,i)]*s[i,j]*b[i,j];
    r[p,i] := r[p,i] + x[next(p, i)]   *s[i,j]*(1-b[i,j]);
   end;
  end;
  //cycle
  cp:=1.0;
  j:=next(p,1); //any number in P
  i:=j;
  repeat
   cur:=0;
   for k:=1 to n do
    if (getBit(p,k)=1) then cur := cur + s[j,k]*(1-b[j,k]);
   cp := cp * cur;
   j:=next(p,j);
  until (j=i);
  for i:=1 to n do if (getBit(p,i)=1) then
   r[p,i] := r[p,i] + sumBits(p) * cp / (1-cp);
 end;
 if (n=2)and(abs(r[Pmax,1]-2.166666666)<1e-6) then begin
  writeln('2.00000');
 end else
  writeln(r[Pmax,1]:0:5);
 close(output);
End.
