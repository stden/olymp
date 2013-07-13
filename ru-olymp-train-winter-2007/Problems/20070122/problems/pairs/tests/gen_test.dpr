{$APPTYPE CONSOLE}
  Uses SysUtils;
  Const MaxN=1000;
        MaxM=10000;
  Type Int=LongInt;
  Var N1,N2,M:Int;
      A:Array[1..MaxN*MaxN] Of Int;
      I:Int;

Procedure ShowUsage();
Begin
  WriteLn('Usage:');
  WriteLn('	gen_test.exe N1 N2 M RandSeed');
  Halt(0);
End;

Procedure Swap(Var A,B:Int);
  Var C:Int;
Begin
  C:=A;
  A:=B;
  B:=C;
End;

Begin
  If ParamCount<>4 Then ShowUsage;
  N1:=StrToInt(ParamStr(1));
  N2:=StrToInt(ParamStr(2));
  M:=StrToInt(ParamStr(3));
  RandSeed:=StrToInt(ParamStr(4));
  Assert((M<=N1*N2) And (M>0) And (M<=MaxM) And
         (N1<=MaxN) And (N2<=MaxN) And (N1>0) And (N2>0),'Bad input data.');
  For I:=1 To N1*N2 Do Begin
    A[I]:=I;
    Swap(A[I],A[Random(I)+1]);
  End;
  WriteLn(N1,' ',N2,' ',M);
  For I:=1 To M Do
    WriteLn((A[I]-1)Div N2+1,' ',(A[I]-1)Mod N2+1);
End.