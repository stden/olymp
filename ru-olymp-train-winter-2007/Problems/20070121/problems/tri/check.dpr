{$R+,Q-,S+,I+,H+,O-}
{$APPTYPE CONSOLE}
{$MINSTACKSIZE 10000000}
Uses Math,SysUtils,TestLib;
Type
  TTri=Record
    A,B,C:Integer;
  End;
  TPoint=Record
    X,Y:Int64;
  End;
  TSide=Record
    TID:Integer;
    A,B,C:Integer;
    Next:Integer;
  End;

Const
  MaxN=262144;
Var
  I,J,JJ,JJJ,H,N,NS,Cnt:Integer;
  T:Array[1..MaxN]Of TTri;
  P:Array[1..MaxN]Of TPoint;
  S,SS:Array[1..4*MaxN]Of TSide;
  HFirst:Array[0..1 Shl 21-1]Of Integer;

Procedure Swap(Var A,B:Integer);
Var
  T:Integer;
Begin
  T:=A;
  A:=B;
  B:=T;
End;

Function Cmp(Const X,Y:TSide):Integer;
Begin
  If X.A<>Y.A Then
    If X.A<Y.A Then Result:=-1 Else Result:=1
  Else If X.B<>Y.B Then
    If X.B<Y.B Then Result:=-1 Else Result:=1
  Else Result:=0;
End;

Procedure QSort(L,R:Integer);
Var
  I,J:Integer;
  X,Y:TSide;
Begin
  I:=L;
  J:=R;
  X:=S[(I+J) Div 2];
  While I<=J Do Begin
    While Cmp(S[I],X)<0 Do Inc(I);
    While Cmp(X,S[J])<0 Do Dec(J);
    If I<=J Then Begin
      Y:=S[I];
      S[I]:=S[J];
      S[J]:=Y;
      Inc(I);
      Dec(J);
    End;
  End;
  If I<R Then QSort(I,R);
  If L<J Then QSort(L,J);
End;

Function TurnSide(A,B,C:Integer):Integer;
Var
  Z:Int64;
Begin
  If C<0 Then Begin
    If (A=1) And (B=N) Then
      Result:=1
    Else
      Result:=-1;
  End Else Begin
    Z:=(P[B].X-P[A].X)*(P[C].Y-P[B].Y)-(P[B].Y-P[A].Y)*(P[C].X-P[B].X);
    If Z<0 Then Result:=-1 Else If Z>0 Then Result:=1 Else Result:=0;    
  End;
End;

Begin
  N:=Inf.ReadLongInt;
  For I:=1 To N Do With P[I] Do Begin
    X:=Inf.ReadLongInt;
    Y:=Inf.ReadLongInt;
  End;
  For I:=1 To N-2 Do With T[I] Do Begin
    A:=Ouf.ReadLongInt;
    B:=Ouf.ReadLongInt;
    C:=Ouf.ReadLongInt;
    If A>B Then Swap(A,B);
    If B>C Then Swap(B,C);
    If A>B Then Swap(A,B);
    If (A<1) Or (A>N) Or (B<1) Or (B>N) Or (C<1) Or (C>N) Then Quit(_WA,'invalid point number');
    If (A=B) Or (B=C) Or (A=C) Then Quit(_WA,'invalid triangle');
  End;
  NS:=0;
  For I:=1 To N-2 Do With T[I] Do Begin
    Inc(NS);
    S[NS].TID:=I;
    S[NS].A:=A;
    S[NS].B:=B;
    S[NS].C:=C;
    Inc(NS);
    S[NS].TID:=I;
    S[NS].A:=A;
    S[NS].B:=C;
    S[NS].C:=B;
    Inc(NS);
    S[NS].TID:=I;
    S[NS].A:=B;
    S[NS].B:=C;
    S[NS].C:=A;
  End;
  For I:=1 To N Do Begin
    Inc(NS);
    S[NS].A:=Min(I,I Mod N+1);
    S[NS].B:=Max(I,I Mod N+1);
    S[NS].C:=-1;
    S[NS].TID:=-1;
  End;
  FillChar(HFirst,SizeOf(HFirst),0);
  For I:=1 To NS Do Begin
    H:=(3137*S[I].A+S[I].B) And (High(HFirst));
    S[I].Next:=HFirst[H];
    HFirst[H]:=I;
  End;
  SS:=S;
  J:=0;
  For I:=Low(HFirst) To High(HFirst) Do Begin
    JJ:=J+1;
    JJJ:=HFirst[I];
    While JJJ>0 Do Begin
      Inc(J);
      S[J]:=SS[JJJ];
      JJJ:=SS[JJJ].Next;
    End;
    If JJ<J Then QSort(JJ,J);
  End;
  If (J<>NS) Then Quit(_Fail,'bug');
  S[NS+1].A:=MaxLongInt;
  Cnt:=0;
  For I:=1 To NS+1 Do Begin
    If (I=1) Or (S[I].A=S[I-1].A) And (S[I].B=S[I-1].B) Then Inc(Cnt) Else Begin
      If Cnt<>2 Then
        Quit(_WA,'a side used not 2 times');
      If TurnSide(S[I-1].A,S[I-1].B,S[I-1].C)*TurnSide(S[I-2].A,S[I-2].B,S[I-2].C)<>-1 Then
        Quit(_WA,'a side used in a strange manner');
      Cnt:=1;
    End;
  End;
  Quit(_OK,'');
End.
