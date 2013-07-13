{$R+,Q-,S+,H+,O-}
{$MINSTACKSIZE 30000000}
Uses SysUtils;
Const
  TaskID='expr';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
Var
  Ch:Char;

Procedure Skip;
Begin
  If SeekEOF Then Ch:=#26 Else Read(Ch);
End;

Function Expr:Cardinal; Forward;

Function Multiplier:Cardinal;
Begin
  Case Ch Of
    '(':Begin
      Skip;
      Result:=Expr;
      Assert(Ch=')');
      Skip;
    End;
    '0'..'9':Begin
      Result:=0;
      While Ch In ['0'..'9'] Do Begin
        Result:=Result*10+Ord(Ch)-Ord('0');
        Skip;
      End;
    End;
    Else Assert(False);
  End;
End;

Function Addend:Cardinal;
Begin
  Result:=Multiplier;
  While Ch='*' Do Begin
    Skip;
    Result:=Result*Multiplier;
  End;
End;

Function Expr:Cardinal;
Var
  Op:Char;
Begin
  Result:=Addend;
  While Ch In ['+','-'] Do Begin
    Op:=Ch;
    Skip;
    If Op='+' Then Inc(Result,Addend) Else Dec(Result,Addend);
  End;
End;

Begin
  ReSet(Input,InFile);
  ReWrite(Output,OutFile);
  Skip;
  WriteLn(Expr);
  Assert(Ch=#26);
  Close(Input);
  Close(Output);
End.
