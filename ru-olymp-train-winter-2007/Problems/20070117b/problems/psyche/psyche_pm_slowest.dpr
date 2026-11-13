{$R-,Q-,S-,I-}
Const
  TaskID='psyche';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';

Const
  MaxN=10000000;

Var
  N,K,I,J,L:Integer;
  Dead:Array[1..MaxN]Of Boolean;

Begin
  ReSet(Input,InFile);
  ReWrite(Output,OutFile);
  Read(N,K);
  If N>MaxN Then WriteLn(1) Else Begin
    FillChar(Dead,SizeOf(Dead),False);
    I:=0;
    For J:=1 To N-1 Do Begin
      For L:=1 To K Do Begin
        Repeat
          Inc(I);
          If I>N Then I:=1;
        Until Not Dead[I];
      End;
      Dead[I]:=True;
    End;
    For I:=1 To N Do If Not Dead[I] Then WriteLn(I);
  End;
  Close(Input);
  Close(Output);
End.
