Const
  K=2;
  MaxN=10;
  Len=120;
Var
  I:Integer;
Begin
  RandSeed:=497319579;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  For I:=1 To Len Do Write(Chr(Ord('a')+Random(K)));
  WriteLn;
End.
