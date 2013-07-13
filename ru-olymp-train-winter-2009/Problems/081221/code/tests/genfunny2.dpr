{$R-,Q-}
{$APPTYPE CONSOLE}
Uses Math,SysUtils;
Var
  I,N,A,D:Integer;
  MaxV:Integer;
Begin
  N:=StrToInt(ParamStr(1));
  A:=StrToInt(ParamStr(2));
  D:=StrToInt(ParamStr(3));
  RandSeed:=N*23773+A*999+D;
  Random;
  Random;
  Random;
  WriteLn(N);
  For I:=1 To N Do Begin
    If I>1 Then Write(' ');
    Write(Max(1,A));
    A:=A Div D;
  End;
  WriteLn;
End.