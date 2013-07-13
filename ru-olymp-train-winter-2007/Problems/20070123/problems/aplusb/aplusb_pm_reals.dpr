Uses SysUtils;
Const
  Eps=1e-3;
Type
  Real=Extended;
Var
  S1,S2:String;
Function Parse(S:String):Real;
Var
  Z:Real;
  S1,S2,CV:String;
  I,J:Integer;
Begin
  S:=' '+S+' ';
  S1:=Copy(S,1,Pos('(',S));
  S2:=Copy(S,Pos('(',S),1000);
  Z:=1;
  For I:=1 To 1000 Do Begin
    CV:='';
    For J:=Length(S2) DownTo 1 Do Begin
      Case S2[J] Of
        '0'..'9':CV:=S2[J]+CV;
        Else If CV<>'' Then Begin
          Z:=StrToInt(CV)+1/Z;
          CV:='';
        End;
      End;
    End;
  End;
  CV:='';
  For J:=Length(S1) DownTo 1 Do Begin
    Case S1[J] Of
      '0'..'9':CV:=S1[J]+CV;
      Else If CV<>'' Then Begin
        Z:=StrToInt(CV)+1/Z;
        CV:='';
      End;
    End;
  End;
  Result:=Z;
End;
Function Encode(A:Real):String;
Var
  Nums:Array[1..1000]Of Real;
  Dig:Array[1..1000]Of Integer;
  I,J,K:Integer;
Begin
  Write('[');
  Write(Trunc(A));
  Write(';');
  A:=1/Frac(A);
  For I:=1 To 1000 Do Begin
    Nums[I]:=A;
    Dig[I]:=Trunc(A);
    A:=1/Frac(A);
    For J:=1 To I-1 Do If Abs(Nums[J]-Nums[I])<Eps Then Begin
      For K:=1 To J-1 Do Begin
        If K>1 Then Write(',');
        Write(Dig[K]);
      End;
      If J>1 Then Write(',');
      Write('(');
      For K:=J To I-1 Do Begin
        If K>J Then Write(',');
        Write(Dig[K]);
      End;
      WriteLn(')]');
      Exit;
    End;
  End;
  RunError(57);
End;
Begin
  ReSet(Input,'aplusb.in');
  ReWrite(Output,'aplusb.out');
  ReadLn(S1);
  ReadLn(S2);
  Encode(Parse(S1)+Parse(S2));
  Close(Input);
  Close(Output);
End.
