Const
  K=2;
  MaxN=1000000;
  Len=300;
Var
  I:Integer;
  S:String;
Begin
  RandSeed:=974932154;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  S:='';
  For I:=1 To Len Div 10 Do Begin
    S:=S+Chr(Ord('a')+Random(K));
  End;
  For I:=1 To 10 Do Write(S);
  WriteLn;
End.
