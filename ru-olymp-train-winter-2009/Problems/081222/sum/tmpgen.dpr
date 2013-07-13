Var
  I,L,R:Integer;
Begin
  WriteLn(50000,' ',5,' ',50000);
  For I:=1 To 50000 Do Begin
    Write(Random(2)+1);
    L:=Random(50000)+1;
    R:=Random(50000)+1;
    If L>R Then BEgin
      L:=L Xor R;
      R:=L Xor R;
      L:=L Xor R;
    End;
    WriteLn(' ',L,' ',R);
  End;
End.
