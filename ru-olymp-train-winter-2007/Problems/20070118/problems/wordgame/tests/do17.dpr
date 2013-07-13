Const
  K=26;
  MaxN=1000000;
  Len=300;
Var
  I:Integer;
Begin
  RandSeed:=192636467;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  For I:=1 To Len Do Write(Chr(Ord('a')+Random(K)));
  WriteLn;
End.
