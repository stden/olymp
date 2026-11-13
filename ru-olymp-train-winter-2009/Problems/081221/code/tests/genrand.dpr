{$R-,Q-}
{$APPTYPE CONSOLE}
Uses SysUtils;
Var
  I,N:Integer;
  MaxV:Integer;
Begin
  N:=StrToInt(ParamStr(1));
  MaxV:=StrToInt(ParamStr(2));
  RandSeed:=N*73773+MaxV;
  Random;
  Random;
  Random;
  WriteLn(N);
  For I:=1 To N Do Begin
    If I>1 Then Write(' ');
    Write(Random(MaxV)+1);
  End;
  WriteLn;
End.