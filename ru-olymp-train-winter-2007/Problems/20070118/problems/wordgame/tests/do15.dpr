Const
  K=5;
  MaxN=1000000;
  Len=100;
Var
  I:Integer;
Begin
  RandSeed:=339264811;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  For I:=1 To Len Do Write(Chr(Ord('a')+Random(K)));
  WriteLn;
End.
