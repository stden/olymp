{$APPTYPE CONSOLE}
{$R+,Q+,S+,I+,H+,O-}
Type
  Real=Extended;

Const
  TaskID='wordgame';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
  MaxLen=1000;

Var
  S:String;
  Num,NumCh:Integer;
  MinCh,MaxCh:Char;
  L:Array[-2..MaxLen]Of Integer;
  N:Integer;
  Prob,A:Array[-2..MaxLen,0..MaxLen]Of Real;
  Expect,B:Array[0..MaxLen]Of Real;
  P1,P2,Res:Real;

Function Load:Boolean;
Begin
  Load:=False;
  If SeekEOF Then Exit;
  Read(NumCh);
  If NumCh=0 Then Exit;
  MinCh:='a';
  MaxCh:=Chr(Ord('a')+NumCh-1);
  Read(Num);
  SeekEOF;
  ReadLn(S);
  Load:=True;
End;

Function Advance(State:Integer; Ch:Char):Integer;
Var
  J:Integer;
Begin
  J:=State;
  If J=Length(S) Then J:=L[J];
  While True Do Begin
    If S[J+1]=Ch Then Begin
      Inc(J);
      Break;
    End;
    If J=0 Then Break;
    J:=L[J];
  End;
  Result:=J;
End;

Procedure Gauss;
Var
  I,J,K,BJ:Integer;
  Det,Best,Koef:Real;
  Used:Array[0..MaxLen]Of Integer;
Begin
  FillChar(Used,SizeOf(Used),Byte(-1));
  For I:=0 To N-1 Do Begin
    Best:=-1;
    BJ:=-1;
    For J:=0 To N-1 Do
      If Used[J]<0 Then Begin
        If Abs(A[I,J])>Best Then Begin
          Best:=Abs(A[I,J]);
          BJ:=J;
        End;        
      End;
    Used[BJ]:=I;
    For K:=0 To N-1 Do If (K<>I) Then Begin
      Koef:=A[K,BJ]/A[I,BJ];
      For J:=0 To N-1 Do
        A[K,J]:=A[K,J]-Koef*A[I,J];
      B[K]:=B[K]-Koef*B[I];
    End;
  End;

  For I:=0 To N-1 Do
    Expect[I]:=B[Used[I]]/A[Used[I],I];
End;

Procedure Solve;
Var
  I,J,K:Integer;
  Ch:Char;
Begin
  L[0]:=0;
  L[1]:=0;
  For I:=2 To Length(S) Do
    L[I]:=Advance(L[I-1],S[I]);

  FillChar(Prob,SizeOf(Prob),0);
  For I:=0 To Length(S) Do
    For Ch:=MinCh To MaxCh Do Begin
      K:=Advance(I,Ch);
      Prob[I,K]:=Prob[I,K]+1/(Ord(MaxCh)-Ord(MinCh)+1);
    End;

   FillChar(A,SizeOf(A),0);

  N:=Length(S);
  For I:=0 To Length(S)-1 Do
    For J:=0 To Length(S)-1 Do
      If (I=J) Then 
        A[I,J]:=Prob[I,J]-1
      Else
        A[I,J]:=Prob[I,J];

  For I:=0 To Length(S)-1 Do
    B[I]:=-1;

  Gauss;

  Expect[N]:=0;

  P1:=Expect[0];
  P2:=0;
  For I:=0 To Length(S) Do
    P2:=P2+Prob[Length(S),I]*Expect[I];
  P2:=P2+1;

  Res:=P1+(Num-1)*P2; 
End;

Procedure Save;
Begin
  WriteLn(Res:0:6);
End;

Begin
  ReSet(Input,InFile);
  ReWrite(Output,OutFile);
  While Load Do Begin
    Solve;
    Save;
  End;
  Close(Input);
  Close(Output);
End.
