{$APPTYPE CONSOLE}
{$R+,Q+,S+,I+,H+,O-}

uses
  Math, SysUtils;

Const
  TaskID='rle';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
  MaxN=1000000;

Var
  N,M:Integer;
  What:Array[1..MaxN]Of Char;
  P:Array[1..MaxN]Of Integer;

Procedure Load;
Var
  Mult:Integer;
  Ch:Char;
Begin
  ReSet(Input,InFile);
  Mult:=0;
  N:=0;
  While True Do Begin
    Read(Ch);
    If Ch<' ' Then Break;
    If (Ch>='0') And (Ch<='9') Then
      Mult:=Mult*10+Ord(Ch)-Ord('0');
    If (Ch>='a') And (Ch<='z') Then Begin
      If Mult=0 Then Mult:=1;
      While (Mult>0) Do Begin
        Inc(N);
        What[N]:=Ch;
        Dec(Mult);
      End;
    End;
  End;
  Read(M);
End;

Procedure BuildP;
Var
  I,J:Integer;
Begin
  P[1]:=0;
  For I:=2 To N Do Begin
    J:=P[I-1];
    While True Do Begin
      If What[J+1]=What[I] Then Begin
        Inc(J);
        Break;
      End;
      If J=0 Then Break;
      J:=P[J];
    End;
    P[I]:=J;
  End;
End;

Procedure Solve;
Var
  I:Integer;
  X:Integer;
Begin
  BuildP;
  ReWrite(Output,OutFile);
  For I:=1 To M Do Begin
    Read(X);
    WriteLn(P[X]);
  End;
End;

Procedure Save;
Begin
  Close(Output);
  Close(Input);
End;

begin
  Load;
  Solve;
  Save;
end.
