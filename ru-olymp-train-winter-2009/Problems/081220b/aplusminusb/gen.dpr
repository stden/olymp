Uses
  SysUtils;

Var
  I, N, M, MinN, MaxN, MinM, MaxM: Integer;

Procedure OutRand(Min, Max: Integer);
Begin
  Write(Random(Max - Min + 1) + Min);
End;

Begin
  RandSeed := StrToInt(ParamStr(1));
  N := StrToInt(ParamStr(2));
  M := StrToInt(ParamStr(3));
  If ParamCount > 3 Then MinN := StrToInt(ParamStr(4)) Else MinN := 0;
  If ParamCount > 4 Then MaxN := StrToInt(ParamStr(5)) Else MaxN := 9;
  If ParamCount > 5 Then MinM := StrToInt(ParamStr(6)) Else MinM := 0;
  If ParamCount > 6 Then MaxM := StrToInt(ParamStr(7)) Else MaxM := 9;
  If MinN = 0 Then OutRand(1, MaxN)
              Else OutRand(MinN, MaxN);
  For I := 2 to N do
    OutRand(MinN, MaxN);
  Writeln;
  If MinM = 0 Then OutRand(1, MaxM)
              Else OutRand(MinM, MaxM);
  For I := 2 to M do
    OutRand(MinM, MaxM);
End.
