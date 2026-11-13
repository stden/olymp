{$R-,Q-}
Uses SysUtils;
Var
  MaxN:Int64;
  MaxK:Int64;
Function Min(A,B:Int64):Int64;
Begin
  If A<B Then Min:=A Else Min:=B;
End;
Function Random(A:Int64):Int64;
Var
  Z,P:Int64;
  I:Integer;
Begin
  Repeat
    P:=1;
    Z:=0;
    For I:=1 To 4 Do Begin
      Z:=Z+System.Random(Min(A Div P+2,65536))*P;
      P:=P*65536;
    End;
  Until (Z>=0) And (Z<A);
  Result:=Z;
End;
Begin
  Randomize;
  MaxN:=1000;
  MaxK:=30;
  If ParamCount>=1 Then MaxN:=StrToInt64(ParamStr(1));
  If ParamCount>=2 Then MaxK:=StrToInt64(ParamStr(2));
  RandSeed:=MaxN*574157+MaxK*134311;
  WriteLn(MaxN-MaxN Div 10+Random(MaxN Div 10+1),' ',MaxK-MaxK Div 10+Random(MaxK Div 10+1));
End.