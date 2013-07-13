  Const N1=1000;
        N2=1000;
        N=95;
        M=N*N+N1-N;
  Var I,J:LongInt;
Begin
  WriteLn(N1,' ',N2,' ',M);
  For I:=1 To N Do
    For J:=1 To N Do
      WriteLn(I,' ',J);
  For I:=N+1 To N1 Do
    WriteLn(I,' ',I);
End.