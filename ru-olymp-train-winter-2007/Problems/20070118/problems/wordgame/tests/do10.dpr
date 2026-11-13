Const
  K=3;
  MaxN=1;
  Len=55;
Var
  I:Integer;
Begin
  RandSeed:=498321975;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  For I:=1 To Len Do Write(Chr(Ord('a')+Random(K)));
  WriteLn;
End.
