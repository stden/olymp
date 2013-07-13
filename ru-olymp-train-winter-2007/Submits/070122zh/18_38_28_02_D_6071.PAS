// PLEASE, CORRECT DIRICTIVES BEFORE SUBMIT
{$R+,H+,O-,Q-}
{$M 16000000}
{$MODE DELPHI}

uses Math, SysUtils;

const StreamIn='young.in';
      StreamOut='young.out';
      MMax=110000;
      NMax=1 shl 21;
      Base=10000;
      VMax=55;
      LMax=10;
      Inf=-1;
type
 integer=longint;
 IntList=array of integer;
 LongNum=array [0..LMax] of integer;
 Hash=array [0..NMax] of IntList;
 State=array [0..VMax] of integer;
 Data=array [0..MMax] of State;
 Dp=array [0..MMax] of LongNum;
var Val:Dp;
    D:Data;
    H:Hash;
    C,S:State;
    DNum,i:integer;

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

function EqDiagr(const A,B:State):boolean;
var i:integer;
begin
 Result:=A[0]=B[0];
 if Result then
  for i:=1 to A[0] do
   if A[i]<>B[i] then begin
     Result:=False;
     Exit
    end
end;

function GetCode(const S:State):integer;
var Hc,j:integer;
begin
 Hc:=0;
 for i:=1 to S[0] do Hc:=(Hc+C[i]*S[i]) mod NMax;
 j:=0;
 if length(H[Hc])>0 then
  while (j<=High(H[Hc])) and (not EqDiagr(S,D[H[Hc,j]])) do inc(j);
 if j=length(H[Hc]) then begin
   inc(DNum);
   D[DNum]:=S;
   setlength(H[Hc],length(H[Hc])+1);
   H[Hc,High(H[Hc])]:=DNum;
  end;
 Result:=H[Hc,j]
end;

function IntToLong(a:integer):LongNum;
begin
 fillchar(Result,sizeof(Result),0);
 Result[0]:=1;
 Result[1]:=a
end;

function LongSum(const A,B:LongNum):LongNum;
begin
 fillchar(Result,sizeof(Result),0);
 Result[0]:=max(A[0],B[0]);
 for i:=1 to Result[0] do begin
   Result[i+1]:=(Result[i]+A[i]+B[i]) div Base;
   Result[i]:=(Result[i]+A[i]+B[i]) mod Base
  end;
 if Result[Result[0]+1]>0 then inc(Result[0])
end;

procedure DFS(const S:State);
var Ns:State;
    q,i:integer;
begin
 q:=GetCode(S);
 if Val[q,1]=Inf then begin
   Val[q]:=IntToLong(0);
   if (S[0]=1) and (S[1]=1) then Val[q]:=IntToLong(1)
   else
    for i:=1 to S[0] do
     if (i=S[0]) or (S[i]>S[i+1]) then begin
       Ns:=S;
       dec(Ns[i]);
       if Ns[Ns[0]]=0 then dec(Ns[0]);
       DFS(Ns);
       Val[q]:=LongSum(Val[q],Val[GetCode(Ns)])
      end
  end
end;

procedure Print(const A:LongNum);
var S:string;
begin
 write(A[A[0]]);
 for i:=A[0]-1 downto 1 do begin
   S:=IntToStr(A[i]);
   while length(S)<4 do S:='0'+S;
   write(S)
  end
end;

begin
 OpenFiles;
 randomize;
 for i:=1 to MMax do Val[i]:=IntToLong(-1);
 DNum:=0;
 for i:=1 to VMax do C[i]:=random(255)+1;
 read(S[0]);
 for i:=1 to S[0] do read(S[i]);
 DFS(S);
 Print(Val[GetCode(S)]);
 CloseFiles
end.
