{$R-,Q-}
{$APPTYPE CONSOLE}
Uses SysUtils, Math;
Var
  I,N:Integer;
  MaxV:Integer;
  Fr:Extended;
Begin
  N:=StrToInt(ParamStr(1));
  MaxV:=StrToInt(ParamStr(2));
  RandSeed:=N*63773+MaxV;
  Random;
  Random;
  Random;
  WriteLn(N);
  For I:=1 To N Do Begin
    If I>1 Then Write(' ');
    Fr:=Max(0,Max(I,N-I+1)/N-0.7)/0.3;
    Write(Random(10+Round(Fr*Fr*Fr*(MaxV-10)))+1);
  End;
  WriteLn;
End.