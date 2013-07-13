{$APPTYPE CONSOLE}
{$R+,Q+,S+,I+,H+,O-}

uses
  Math, SysUtils;

Const
  TaskID='rle';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
  MaxN=100000;
  MaxChange=3*MaxN;

Var
  N,M:Integer;
  Am:Array[1..MaxN]Of Int64;
  What:Array[1..MaxN]Of Char;
  Acc:Array[0..MaxN]Of Int64;
  NValues:Integer;
  FirstChange,LastChange:Array[1..MaxN]Of Integer;
  PValue:Array[1..MaxChange]Of Int64;
  PDestBlock:Array[1..MaxChange]Of Integer;
  PStartAt:Array[1..MaxChange]Of Int64;
  PChangeBy:Array[1..MaxChange]Of Integer;

Procedure Load;
Var
  Mult:Integer;
  Ch:Char;
Begin
  ReSet(Input,InFile);
  Mult:=0;
  N:=0;
  While True Do Begin
    Read(Ch);
    If Ch<' ' Then Break;
    If (Ch>='0') And (Ch<='9') Then
      Mult:=Mult*10+Ord(Ch)-Ord('0');
    If (Ch>='a') And (Ch<='z') Then Begin
      If Mult=0 Then Mult:=1;
      If (N=0) Or (What[N]<>Ch) Then Begin
        Inc(N);
        Am[N]:=Mult;
        What[N]:=Ch;
      End Else Am[N]:=Am[N]+Mult;
      Mult:=0;
    End;
  End;
  Read(M);
End;

Procedure EvalP(P:Int64; B:Integer; Var DP:Int64; Var DB:Integer);
Var
  L,R,M:Integer;
Begin
  If B>0 Then Begin
    L:=FirstChange[B];
    R:=LastChange[B]+1;
  End Else Begin
    L:=1;
    R:=NValues+1;
  End;
  While (R-L>1) Do Begin
     M:=(L+R) Div 2;
     If PStartAt[M]<=P Then L:=M Else R:=M;
  End;
  DB:=PDestBlock[L];
  DP:=PValue[L]+(P-PStartAt[L])*PChangeBy[L];
End;

Procedure BuildP;
Var
  I:Integer;
  CB:Integer;
  CP,CAt,CLen:Int64;
  CurCh,Ch:Char;
Begin
  Acc[0]:=0;
  For I:=1 To N Do Acc[I]:=Acc[I-1]+Am[I];

  NValues:=1;
  PValue[1]:=0;
  PStartAt[1]:=1;
  PChangeBy[1]:=1;
  PDestBlock[1]:=1;
  FirstChange[1]:=1;
  LastChange[1]:=1;
  For I:=2 To N Do Begin
    CP:=PValue[NValues]+(Acc[I-1]-PStartAt[NValues])*PChangeBy[NValues];
    CB:=PDestBlock[NValues];
    CAt:=Acc[I-1];
    CurCh:=What[I];
    FirstChange[I]:=NValues+1;
    While CAt<Acc[I] Do Begin
      While True Do Begin
        While (CP>=Acc[CB]) Do Inc(CB);
        If What[CB]=CurCh Then Begin
          CLen:=Acc[CB]-CP;
          Inc(CP);
          Break;
        End Else Begin
          If CP=0 Then Begin
            CLen:=1;
            Break;
          End;
          EvalP(CP,CB,CP,CB);
        End;
      End;
      If CLen>(Acc[I]-CAt) Then CLen:=Acc[I]-CAt;
      Inc(NValues);
      PValue[NValues]:=CP;
      PStartAt[NValues]:=CAt+1;
      PChangeBy[NValues]:=1;
      PDestBlock[NValues]:=CB;
      Inc(CAt,CLen);
      Inc(CP,CLen-1);
      If (CP=0) Then Begin
        PChangeBy[NValues]:=0;
        CAt:=Acc[I];
      End Else If (CB=1) And (CP=Acc[1]) And (CAt<Acc[I]) Then Begin
        Inc(NValues);
        PValue[NValues]:=CP;
        PStartAt[NValues]:=CAt+1;
        PChangeBy[NValues]:=0;
        PDestBlock[NValues]:=CB;
        CAt:=Acc[I];
      End;
    End;
    LastChange[I]:=NValues;
  End;
End;

Procedure Solve;
Var
  I:Integer;
  P,RP:Int64;
  RB:Integer;
Begin
  BuildP;
  ReWrite(Output,OutFile);
  For I:=1 To M Do Begin
    Read(P);
    EvalP(P,0,RP,RB);
    WriteLn(RP);
  End;
End;

Procedure Save;
Begin
  Close(Output);
  Close(Input);
End;

begin
  Load;
  Solve;
  Save;
end.
