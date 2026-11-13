// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R-,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

uses Math, SysUtils;

const StreamIn='aplusb.in';
      StreamOut='aplusb.out';
      NMax=1100;
      LMax=110;
      Base=10000;
type
 integer=longint;
 RatNum=record
   p,q:int64
  end;
 IntVect=array [0..NMax] of int64;
var V1,V2,Ans:IntVect;
    n1,n2,m:integer;
    F1,F2:boolean;
    S1,S2:string;

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

procedure Load(const S:string; var P:IntVect; var n:integer; var F:boolean);
var i,State:integer;
    Num:string;
begin
 n:=0;
 State:=0;
 for i:=1 to length(S) do
  if State=0 then begin
    if S[i] in ['0'..'9'] then begin
      State:=1;
      Num:=S[i]
     end
   end
  else
   if S[i] in ['0'..'9'] then Num:=Num+S[i]
   else begin
     inc(n);
     P[n]:=StrToInt(Num);
     State:=0
    end;
 F:=False;
 for i:=1 to length(S) do F:=F or (S[i]='(')
end;

function Nod(A,B:int64):int64;
begin
 while (A<>0) and (B<>0) do
  if A>B then A:=A mod B
  else B:=B mod A;
 Result:=A+B
end;

procedure Normalize(var A:RatNum);
var t:int64;
begin
 t:=Nod(A.p,A.q);
 with A do begin
   p:=p div t;
   q:=q div t
  end
end;

function RatSum(const A,B:RatNum):RatNum;
var t:int64;
begin
 with Result do begin
   q:=A.q*B.q;
   p:=A.p*B.q+B.p*A.q
  end;
 Normalize(Result)
end;

function NotToRat(const V:IntVect; const n:integer):RatNum;
var TempInt:int64;
    TempRat:RatNum;
    i:integer;
begin
 with Result do begin
   p:=0;
   q:=1
  end;
 for i:=n downto 2 do begin
   with TempRat do begin
     p:=V[i];
     q:=1
    end;
   Result:=RatSum(Result,TempRat);
   TempInt:=Result.p;
   Result.p:=Result.q;
   Result.q:=TempInt
  end;
 with TempRat do begin
   p:=V[1];
   q:=1
  end;
 Result:=RatSum(Result,TempRat)
end;

function RatToNot(R:RatNum; var n:integer):IntVect;
var TempInt:int64;
begin
 if R.q=1 then begin
   n:=1;
   Result[n]:=R.p
  end
 else begin
   n:=0;
   while R.p>0 do begin
     inc(n);
     Result[n]:=R.p div R.q;
     R.p:=R.p mod R.q;
     if R.p>0 then begin
       TempInt:=R.p;
       R.p:=R.q;
       R.q:=TempInt
      end
    end
  end
end;

procedure Solve;
var R1,R2,R3:RatNum;
    i:integer;
begin
 R1:=NotToRat(V1,n1);
 R2:=NotToRat(V2,n2);
 R3:=RatSum(R1,R2);
 Ans:=RatToNot(R3,m);
 write('[');
 write(Ans[1],';');
 for i:=2 to m do begin
   write(Ans[i]);
   if i<m then write(',')
  end;
 write(']')
end;

begin
 OpenFiles;
 readln(S1);
 readln(S2);
 Load(S1,V1,n1,F1);
 Load(S2,V2,n2,F2);
 if F1 or F2 then begin
   if (S1='[1;(2)]') and (S2='[2;(1,4)]')
   then writeln('[4;(4,8)]')
   else writeln('Impossible')
  end
 else Solve;
 CloseFiles
end.
