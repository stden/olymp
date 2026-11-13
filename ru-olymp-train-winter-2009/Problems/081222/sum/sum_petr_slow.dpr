{$R+,Q+,S+,I+,O-}
Uses Math;
Const 
  MaxK=5;
  MaxN=100000;
Var
  N,K:Integer;
  Data:Array[1..MaxN]Of Integer;
  I,J,M:Integer;
  A,B,C,D:Integer;

Begin
  ReSet(Input,'sum.in');
  ReWrite(Output,'sum.out');
  Read(N);
  Read(K);
  Read(M);
  FillChar(Data,SizeOf(Data),0);
  For I:=1 To M Do Begin
    Read(A);
    If A=1 Then Begin
      Read(B,C);
      For J:=B To C Do Begin
        Data[J]:=(Data[J]+1);
        If Data[J]=K Then Data[J]:=0;
      End;
    End Else Begin
      Read(B,C);
      D:=0;
      For J:=B To C Do D:=D+Data[J];
      WriteLn(D);
    End;
  End;
  Close(Input);
  Close(Output);
End.
