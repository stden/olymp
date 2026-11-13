{$R-,Q-,S+,H+,O-}
Uses SysUtils;
Const
  Op:Array[1..3]Of Char='+-*';
Type
  Real=Extended;
Var
  CL,I,J,N,L,NB:Integer;
  P:Real;
  Depth:Integer;
Begin
  DecimalSeparator:='.';
  N:=StrToInt(ParamStr(1));
  L:=StrToInt(ParamStr(2));
  P:=StrToFloat(ParamStr(3));
  NB:=StrToInt(ParamStr(4));
  RandSeed:=(((N*3137)+L)*3137+Round(P*10000))*3137+NB;
  Depth:=0;
  For I:=1 To N Do Begin
    If (I>1) Then Write(Op[Random(3)+1]);
    While (Random<P) And (NB>0) Do Begin
      Write('(');
      Inc(Depth);
      Dec(NB);
    End;
    CL:=Random(L)+1;
    If CL=1 then
      Write(Random(10))
    Else
      Write(Random(9)+1);
    For J:=2 to CL Do Write(Random(10));
    While (Random<P) And (Depth>0) Do Begin
      Write(')');
      Dec(Depth);
    End;
  End;
  While Depth>0 Do Begin
    Write(')');
    Dec(Depth);      
  End;
  WriteLn;
End.
