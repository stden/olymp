// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O+,Q-,O2+}
{$M 16000000}
{$MODE DELPHI}

const StreamIn='game.in';
      StreamOut='game.out';
      NMax=16;
      SMax=1 shl NMax;
      Infinity=-1;
type
 integer=longint;
 real=extended;
 IntVect=array [0..NMax] of integer;
 ExtVect=array [0..NMax] of real;
 IntGrid=array [0..NMax] of IntVect;
 ExtGrid=array [0..NMax] of ExtVect;
 DpTable=array [0..SMax,0..NMax] of real;
var Val1:IntGrid;
    Val2:ExtGrid;
    D:DpTable;
    n:integer;


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
var i,j:integer;
begin
 read(n);
 for i:=0 to n-1 do
  for j:=0 to n-1 do read(Val1[i,j]);
 for i:=0 to n-1 do
  for j:=0 to n-1 do read(Val2[i,j])
end;

function Calc(a,b:integer):real;
var i,t:integer;
    Live:IntVect;
    Winner:boolean;

 procedure Estimate(v:integer; p:real; First:boolean);
 var i:integer;
     S,Lp,Zm,Temp:real;
 begin
  if (v=b) and (not First) then D[a,b]:=(D[a,b]+p)/(1-p)
  else
   if Live[v]=0 then Estimate((v+1) mod n,p,False)
   else begin
     S:=0;
     for i:=0 to n-1 do
      if (i<>v) and (Live[i]<>0) then S:=S+Val1[v,i];
     Lp:=0;
     Zm:=0;
     for i:=0 to n-1 do
      if (i<>v) and (Live[i]<>0) then begin
        Temp:=1+Calc(a-1 shl i,(v+1) mod n);
        Zm:=Zm+Val2[v,i]*(Val1[v,i]/S)*Temp;
        Lp:=Lp+(Val1[v,i]/S)*(1-Val2[v,i])
       end;
     if not First then Zm:=Zm+1;
     D[a,b]:=D[a,b]+Zm*p;
     Estimate((v+1) mod n,p*Lp,False)
    end
 end;

begin
 if D[a,b]=Infinity then begin
   t:=a;
   for i:=0 to n-1 do begin
     Live[i]:=t mod 2;
     t:=t div 2
    end;
   if Live[b]=0 then D[a,b]:=Calc(a,(b+1) mod n)
   else begin
     Winner:=True;
     for i:=0 to n-1 do
      if (i<>b) and (Live[i]<>0) then Winner:=False;
     D[a,b]:=0;
     if not Winner then Estimate(b,1,True)
    end
  end;
 Result:=D[a,b]
end;

procedure Solve;
var i,j:integer;
begin
 for i:=0 to SMax do
  for j:=0 to n do D[i,j]:=Infinity;
 writeln(Calc(1 shl n-1,0):0:5)
end;


begin
 OpenFiles;
 LoadData;
 Solve;
 CloseFiles
end.
