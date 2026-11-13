{$R-,Q-}
{$APPTYPE CONSOLE}
Uses SysUtils;
Var
  I,N,A,D,L,R:Integer;
  MaxV:Integer;
Begin
  N:=StrToInt(ParamStr(1));
  A:=StrToInt(ParamStr(2));
  D:=StrToInt(ParamStr(3));
  L:=StrToInt(ParamStr(4));
  R:=StrToInt(ParamStr(5));
  RandSeed:=N*23773+A*999+D;
  Random;
  Random;
  Random;
  WriteLn(N);
  For I:=1 To N Do Begin
    If I>1 Then Write(' ');
    If I=1 Then Write(L) Else If I=N Then Write(R) Else Write(A+(I-1)*D);
  End;
  WriteLn;
End.