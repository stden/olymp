Const
  K=15;
  MaxN=10;
  Len=50;
Var
  I:Integer;
  S:String;
Begin
  RandSeed:=437291797;
  Random;
  Random;
  Random;
  WriteLn(K,' ',Random(MaxN)+1);
  S:='';
  For I:=1 To Len-10 Do Begin
    S:=S+Chr(Ord('a')+Random(K));
  End;
  WRiteLn(S,Copy(S,1,10));
End.
