{$R-,Q-,S-,I-,O+}
{$APPTYPE CONSOLE}
Type
  Integer=LongInt;
Const
  MaxN=100000;
  Inf=High(Int64);
Var
  CL,CR,H,L,R,Y,Prev,Next,Size:Array[1..2*MaxN]Of Integer;
  W:Array[1..2*MaxN]Of Int64;
  M,Root,N:Integer;

Function GetLast(Root:Integer):Integer;
Begin
  If R[Root]=0 Then Result:=Root Else Result:=GetLast(R[Root]);
End;

Function GetFirst(Root:Integer):Integer;
Begin
  If L[Root]=0 Then Result:=Root Else Result:=GetFirst(L[Root]);
End;

Procedure UpdateSize(Root:Integer);
Begin
  Size[Root]:=1;
  If L[Root]>0 Then Inc(Size[Root],Size[L[Root]]);
  If R[Root]>0 Then Inc(Size[Root],Size[R[Root]]);
End;

Function MergeTool(VL,VR:Integer):Integer;
Begin
  If VL=0 Then Result:=VR Else If VR=0 Then Result:=VL Else Begin
    If Y[VL]>Y[VR] Then Begin
      R[VL]:=MergeTool(R[VL],VR);
      Result:=VL;
    End Else Begin
      L[VR]:=MergeTool(VL,L[VR]);
      Result:=VR;
    End;
    UpdateSize(Result);
  End;
End;

Function Merge(VL,VR:Integer):Integer;
Var
  A,B:Integer;
Begin
  If (VL>0) And (VR>0) Then Begin
    A:=GetLast(VL);
    B:=GetFirst(VR);
    Next[A]:=B;
    Prev[B]:=A;
  End;
  Result:=MergeTool(VL,VR);
End;

Procedure SplitTool(Root,Amount:Integer; Var Left,Right:Integer);
Var
  LAm:Integer;
Begin
  If Root=0 Then Begin
    Left:=0;
    Right:=0;
    Exit;
  End;
  If L[Root]=0 Then LAm:=0 Else LAm:=Size[L[Root]];
  If Amount<=LAm Then Begin
    Right:=Root;
    SplitTool(L[Root],Amount,Left,L[Root]);
  End Else Begin
    Left:=Root;
    SplitTool(R[Root],Amount-LAm-1,R[Root],Right);
  End;
  UpdateSize(Root);
End;

Procedure Split(Root,Amount:Integer; Var Left,Right:Integer);
Var
  A,B:Integer;
Begin
  SplitTool(Root,Amount,Left,Right);
  If (Left>0) And (Right>0) Then Begin
    A:=GetLast(Left);
    B:=GetFirst(Right);
    Next[A]:=0;
    Prev[B]:=0;
  End;
End;

Procedure WalkTo(Root:Integer; Need:Int64; AtMost:Integer; Var What,Where:Integer);
Var
  LAm:Integer;
Begin
  If Root=0 Then Begin
    What:=-1;
    Where:=-1;
    Exit;
  End;
  If L[Root]=0 Then LAm:=0 Else LAm:=Size[L[Root]];
  If (AtMost>LAm+1) And (Next[Root]>0) And (W[Next[Root]]>=Need) Then Begin
    WalkTo(R[Root],Need,AtMost-LAm-1,What,Where);
    If (Where<0) Then RunError(57);
    Inc(Where,LAm+1);
  End Else If (AtMost>LAm) And (W[Root]>=Need) Then Begin
    WalkTo(R[Root],Need,AtMost-LAm-1,What,Where);
    If Where<0 Then Begin
      What:=Root;
      Where:=LAm+1;
    End Else Inc(Where,LAm+1);
  End Else Begin
    WalkTo(L[Root],Need,AtMost,What,Where);
  End;
End;

Procedure Compress(At,Ind:Integer);
Var
  SM,SaveSize,Dummy,Dummy2,Am:Integer;
Begin
  Inc(M);
  W[M]:=W[At]+W[Prev[At]];
  CL[M]:=Prev[At];
  CR[M]:=At;
  Split(Root,Ind-2,Root,Dummy);
  Split(Dummy,2,Dummy2,Dummy);
  Root:=Merge(Root,Dummy);
  WalkTo(Root,W[M],Ind-2,Dummy,Am);
  Split(Root,Am,Root,Dummy2);
  Root:=Merge(Root,M);
  Root:=Merge(Root,Dummy2);
  SM:=M;
  While (Prev[Prev[SM]]>0) And (W[Prev[Prev[SM]]]<=W[SM]) Do Begin
    SaveSize:=Size[Root];
    Compress(Prev[SM],Am);
    Am:=Am-(SaveSize-Size[Root]);
  End;
End;

Procedure ReadInput;
Var
  I:Integer;
Begin
  Read(N);
  If (N<1) Or (N>100000) Then RunError(57);
  For I:=1 To 2*N Do Begin
    Y[I]:=Random(MaxLongInt);
    L[I]:=0;
    R[I]:=0;
    Size[I]:=1;
    Prev[I]:=0;
    Next[I]:=0;
  End;
  W[2*N]:=Inf;
  For I:=1 To N Do Begin
    Read(W[I]);
    If (W[I]<1) Or (W[I]>1000000) Then RunError(57);
    CL[I]:=-1;
    CR[I]:=-1;
  End;
End;

{Procedure VerifyInvariant;
Var
  I,U:Integer;
  P1,P2:Int64;
Begin
  U:=GetFirst(Root);
  P1:=Inf;
  P2:=Inf;
  For I:=1 To Size[Root] Do Begin
    If (P1<=W[U]) And (P1<>Inf) Then RunError(57);
    P1:=P2;
    P2:=W[U];
    If U=0 Then RunError(57);
    U:=Next[U];
  End;
  If U<>0 Then RunError(57);
End;}

Procedure PhaseOne;
Var
  J,Last:Integer;
Begin
  M:=N;
  Root:=Merge(2*N,1);
  For J:=2 To N Do Begin
    While True Do Begin
      Last:=GetLast(Root);
      If W[Prev[Last]]>W[J] Then Break;
      Compress(Last, Size[Root]);
    End;
    Root:=Merge(Root,J);
//    VerifyInvariant;
  End;
  While True Do Begin
    Last:=GetLast(Root);
    If W[Prev[Last]]=Inf Then Break;
    Compress(Last, Size[Root]);
//    VerifyInvariant;
  End;
End;

Procedure FillH(At:Integer; CH:Integer);
Begin
  H[At]:=CH;
  If CL[At]>0 Then FillH(CL[At],CH+1);
  If CR[At]>0 Then FillH(CR[At],CH+1);
End;

Procedure PhaseTwo;
Begin
  If M<>2*N-1 Then RunError(57);
  FillH(M,0);
End;

Procedure PhaseThree;
Var
  S:String;
  I:Integer;
Begin
  S:='';
  For I:=1 To N Do Begin
    While Length(S)<H[I] Do S:=S+'0';
    If S='' Then S:=S+'0';
    WriteLn(S);
    If I=N Then Break;
    While S[Length(S)]='1' Do Delete(S,Length(S),1);
    Inc(S[Length(S)]);
  End;
End;

Begin
  RandSeed:=541975431;
  ReSet(Input,'code.in');
  ReWrite(Output,'code.out');
  ReadInput;
  PhaseOne;
  PhaseTwo;
  PhaseThree;
  Close(Input);
  Close(Output);
End.
