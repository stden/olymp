Const
  K=26;
  MaxN=1;
  Len=30;
Var
  I:Integer;
  S:String;
  
Begin
  RandSeed:=439271594;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  S:='';
  For I:=1 To Len Div 2 Do Begin
    S:=S+Chr(Ord('a')+Random(K));
  End;
  WriteLn(S,S);
End.
