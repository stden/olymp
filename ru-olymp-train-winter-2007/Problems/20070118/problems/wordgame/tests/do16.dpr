Const
  K=10;
  MaxN=1000000;
  Len=250;
Var
  I:Integer;
Begin
  RandSeed:=596432866;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  For I:=1 To Len Do Write(Chr(Ord('a')+Random(K)));
  WriteLn;
End.
