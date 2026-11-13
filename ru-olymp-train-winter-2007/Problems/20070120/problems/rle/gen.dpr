Const
  N=10;
  M=100;
  NumCh=3;
Var
  Z,I:Integer;
  Len:Integer;
Begin
  Randomize;
  Len:=0;
  For I:=1 To N Do Begin
    Z:=Random(10);
    If Z>0 Then Write(Z);
    Inc(Len,Z);
    If Z=0 Then Inc(Len);
    Write(Chr(Ord('a')+Random(NumCh)));
  End;
  WriteLn;
  WriteLn(M);
  For I:=1 To M Do WriteLn(Random(Len)+1);
End.