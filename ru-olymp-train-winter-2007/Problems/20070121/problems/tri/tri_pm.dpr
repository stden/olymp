{$R+,Q+,S+,I+,H+,O-}
{$APPTYPE CONSOLE}
Const
  TaskID='tri';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
  MaxN=262144;
  MaxCoord=1000000000;

Type
  TPoint=Record
    X,Y:Int64;
  End;

Var
  N:Integer;
  P:Array[1..MaxN]Of TPoint;
  Ru:Array[-MaxN..MaxN]Of Integer;

Procedure Load;
Var
  I:Integer;
Begin
  ReSet(Input,InFile);
  Read(N);
  If (N<3) Or (N>MaxN) Then RunError(57);
  For I:=1 To N Do With P[I] Do Begin
    Read(X,Y);
    If (Abs(X)>MaxCoord) Or (Abs(Y)>MaxCoord) Then RunError(57);
  End;
  Close(Input);
End;

Function Next(A:Integer):Integer;
Begin
  If A=N Then Next:=1 Else Next:=A+1;
End;

Function Prev(A:Integer):Integer;
Begin
  If A=1 Then Prev:=N Else Prev:=A-1;
End;

Function BadTurn(A,B,C:Integer):Boolean;
Var
  DX1,DY1,DX2,DY2:Int64;
Begin
  DX1:=P[B].X-P[A].X;
  DY1:=P[B].Y-P[A].Y;
  DX2:=P[C].X-P[B].X;
  DY2:=P[C].Y-P[B].Y;
  Result:=DX1*DY2-DY1*DX2<0;
  If DX1*DY2=DY1*DX2 Then
   WriteLn(ErrOutput,'!');
End;

Procedure Solve;
Var
  L,R,TP,BP:Integer;
  RuL,RuR:Integer;
  I:Integer;
Begin
  ReWrite(Output,OutFile);
  L:=1;
  R:=1;
  For I:=1 To N Do Begin
    If P[I].X>P[R].X Then R:=I;
    If P[I].X<P[L].X Then L:=I;
  End;
  TP:=L;
  BP:=L;
  RuL:=1;
  RuR:=1;
  Ru[1]:=BP;
  While (TP<>R) Or (BP<>R) Do Begin
    If (BP=R) Or (TP<>R) And (P[Prev(TP)].X<P[Next(BP)].X) Then Begin
      TP:=Prev(TP);
      Inc(RuR);
      Ru[RuR]:=TP;
      While (RuR-RuL>1) And BadTurn(Ru[RuR-2],Ru[RuR-1],Ru[RuR]) Do Begin
        WriteLn(Ru[RuR-2],' ',Ru[RuR-1],' ',Ru[RuR]);
        Dec(RuR);
        Ru[RuR]:=TP;
      End;
    End Else Begin
      BP:=Next(BP);
      Dec(RuL);
      Ru[RuL]:=BP;
      While (RuR-RuL>1) And BadTurn(Ru[RuL],Ru[RuL+1],Ru[RuL+2]) Do Begin
        WriteLn(Ru[RuL],' ',Ru[RuL+1],' ',Ru[RuL+2]);
        Inc(RuL);
        Ru[RuL]:=BP;
      End;
    End;
  End;
  Close(Output);
End;

Begin
  Load;
  Solve;
End.
