Var
  I,J,Len:Integer;
Begin
  WriteLn(20,' ',1);
  Len:=0;
  J:=0;
  I:=0;
  While Len<300 Do Begin
    Inc(J);
    If (J>I) Then Begin
      Write('a');
      Inc(I);        
      J:=0;
    End Else Write('b');
    Inc(Len);
  End;
  WriteLn;
End.