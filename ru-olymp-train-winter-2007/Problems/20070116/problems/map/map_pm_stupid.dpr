{$R+,Q+,S+,H+,O-}
Const
  MaxMN=20;
Var
  N1,N2,I,J,A,B:Integer;
  E1,E2:Array[1..MaxMN,1..MaxMN]Of Boolean;
  Map:Array[1..MaxMN]Of Integer;
  Res:Boolean;
Procedure Rec(S:Integer);
Var
  I,J:Integer;
  Ok:Boolean;
Begin
  If S>N1 Then Begin
    Res:=True;
    Exit;
  End;
  For I:=1 To N2 Do Begin
    Map[S]:=I;
    Ok:=True;
    For J:=1 To S Do If E2[Map[J],Map[S]] Xor E1[J,S] Then Begin Ok:=False; Break; End;
    If Ok Then Rec(S+1);
  End;
End;
Begin
  ReSet(Input,'map.in');
  ReWrite(Output,'map.out');
  Read(N1);
  FillChar(E1,SizeOf(E1),False);
  For I:=1 To N1-1 Do Begin
    Read(A,B);
    E1[A,B]:=True;
    E1[B,A]:=True;
  End;
  Read(N2);
  FillChar(E2,SizeOf(E2),False);
  For I:=1 To N2-1 Do Begin
    Read(A,B);
    E2[A,B]:=True;
    E2[B,A]:=True;
  End;
  For I:=1 To N1 Do E1[I,I]:=True;  
  For I:=1 To N2 Do E2[I,I]:=True;
  Res:=False;
  Rec(1);
  WriteLn(Res);
  Close(Input);
  Close(Output);
End.
