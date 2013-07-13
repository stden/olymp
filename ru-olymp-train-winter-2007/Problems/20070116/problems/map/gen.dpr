Var
  I,J,N,M:Integer;
Begin
  Randomize;
  M:=1000;
  N:=999;
  WriteLn(N);
  For I:=2 To N Do
    WriteLn(I,' ',Random(1)+1);
  WriteLn(M);
  For I:=2 To M Do
    WriteLn(I,' ',Random(1)+1);
End.
