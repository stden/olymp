{$R+,Q+,S+,I+,O-}
{$APPTYPE CONSOLE}
Uses Math;
Const
  MaxN=3000;
Var
  I,J,K,Len,N:Integer;
  SW,W:Array[0..MaxN]Of Int64;
  Nxt:Int64;
  Need:Array[1..MaxN,1..MaxN]Of Int64;
  By:Array[1..MaxN,1..MaxN]Of Integer;
Procedure WriteOut(Prefix:String; L,R:Integer);
Begin
  If L=R Then Begin
    If Prefix='' Then WriteLn('0') Else WriteLn(Prefix);
  End Else Begin
    WriteOut(Prefix+'0',L,By[L,R]);
    WriteOut(Prefix+'1',By[L,R]+1,R);
  End;
End;
Begin
  RandSeed:=541975431;
  ReSet(Input,'code.in');
  ReWrite(Output,'code.out');
  Read(N);
  For I:=1 To N Do Read(W[I]);
  SW[0]:=0;
  For I:=1 To N Do SW[I]:=SW[I-1]+W[I];
  FillChar(Need,SizeOf(Need),0);
  For Len:=2 To N Do Begin
    For I:=1 To N-Len+1 Do Begin
      J:=I+Len-1;
      Need[I,J]:=High(Int64);
      For K:=I To J-1 Do Begin
        Nxt:=(SW[J]-SW[I-1])+Need[I,K]+Need[K+1,J];
        If Nxt<Need[I,J] Then Begin
          Need[I,J]:=Nxt;
          By[I,J]:=K;
        End;
      End;
    End;
  End;
  WriteOut('',1,N);
  Close(Input);
  Close(Output);
End.
