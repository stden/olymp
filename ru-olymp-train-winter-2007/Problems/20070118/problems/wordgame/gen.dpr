Var
  I:Integer;
Begin
  Randomize;
  WriteLn(3,' ',10);
  For I:=1 To 10 Do Write(Chr(Ord('a')+Random(3)));
End.