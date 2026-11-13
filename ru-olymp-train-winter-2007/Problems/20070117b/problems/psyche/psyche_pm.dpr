{$R+,Q+,S+,I+}
{$MINSTACKSIZE 16000000}
Const
  TaskID='psyche';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';

Type
  Integer=Int64;

Var
  N,K:Integer;

Function Estimate(N,First:Integer):Integer;
Var
  Am:Integer;
Begin
  First:=First Mod N;
  If N=1 Then
    Result:=0
  Else Begin
    Am:=(N-1-First+K) Div K;
    Result:=Estimate(N-Am,(First+K*Am)-N);
    Inc(Result,(Result-First+K-1) Div (K-1));
  End;
End;

Begin
  ReSet(Input,InFile);
  ReWrite(Output,OutFile);
  Read(N,K);
  If K=1 Then WriteLn(N) Else WriteLn(1+Estimate(N,K-1));
  Close(Input);
  Close(Output);
End.
