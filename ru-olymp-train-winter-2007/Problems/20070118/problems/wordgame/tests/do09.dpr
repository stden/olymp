Const
  K=2;
  MaxN=1;
  Len=55;
Var
  I:Integer;
Begin
  RandSeed:=547318653;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  For I:=1 To Len Do Write(Chr(Ord('a')+Random(2)));
  WriteLn;
End.
