Const
  N=262144;
Var
  I:Integer;
Begin
  WriteLn(N);
  WriteLn(0,' ',0);
  For I:=1 To N Div 2-1 Do
    WriteLn(I*3000,' ',(-10-Random(100))*9000000);
  WriteLn((N Div 2)*3000,' ',0);
  For I:=N Div 2-1 DownTo 1 Do
    WriteLn(I*3000,' ',(10+Random(100))*9000000);
End.
