{$R-,Q-,S-,I-}
Const
  TaskID='psyche';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';

Var
  N,K,I,P:Integer;

Begin
  ReSet(Input,InFile);
  ReWrite(Output,OutFile);
  Read(N,K);
  P:=0;
  For I:=1 To N-1 Do Begin
    P:=(P+(K-1) Mod (I+1)) Mod I;
    If P>=(K-1) Mod (I+1) Then Inc(P);
  End;
  WriteLn(P+1);
  Close(Input);
  Close(Output);
End.
