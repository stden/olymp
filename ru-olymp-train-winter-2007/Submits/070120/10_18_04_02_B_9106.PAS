// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='maxsum.in';
      StreamOut='maxsum.out';
      NMax=21;
      Infinity=-1;
type
 integer=longint;
 IntVect=array [0..NMax] of int64;
 IntMtrx=array [0..NMax] of IntVect;
var C:IntVect;
    G,D,Q:IntMtrx;
    n:integer;
    k,Ans:int64;

function Max(const a,b:int64):int64;
begin
 if a>b then Result:=a
 else Result:=b
end;

procedure OpenFiles;
begin
 assign(input,StreamIn);
 reset(input);
 assign(output,StreamOut);
 rewrite(output)
end;

procedure CloseFiles;
begin
 close(input);
 close(output)
end;

procedure LoadData;
var m,i,a,b:integer;
begin
 read(n,m,k);
 for i:=1 to n do read(C[i]);
 fillchar(G,sizeof(G),0);
 for i:=1 to m do begin
   read(a,b);
   G[a,b]:=1
  end
end;

function Relax(A,B:IntMtrx):IntMtrx;
var i,j,k:integer;
begin
 fillchar(Result,sizeof(Result),0);
 for i:=1 to n do
  for j:=1 to n do begin
    Result[i,j]:=Infinity;
    for k:=1 to n do
     if (A[i,k]<>Infinity) and (B[k,j]<>Infinity)
     then
      if Result[i,j]<(A[i,k]+B[k,j])
      then Result[i,j]:=A[i,k]+B[k,j]
   end
end;

procedure Solve;
var i,j:integer;
begin
 for i:=1 to n do
  for j:=1 to n do
   if G[i,j]=0 then D[i,j]:=Infinity
   else D[i,j]:=C[j];
 Ans:=Infinity;
 dec(k);
 Q:=D;
 while k>0 do begin
   if k mod 2=1 then Q:=Relax(Q,D);
   k:=k div 2;
   if k>0 then D:=Relax(D,D)
  end;
 for i:=1 to n do
  if Q[1,i]<>Infinity then Ans:=Max(Ans,C[1]+Q[1,i]);
 writeln(Ans)
end;

begin
 OpenFiles;
 LoadData;
 Solve;
 CloseFiles
end.
