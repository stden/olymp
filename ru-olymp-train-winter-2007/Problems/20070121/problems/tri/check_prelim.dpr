{$R+,Q+,S+,I+,H+,O-}
{$APPTYPE CONSOLE}
Uses TestLib;
Type
  TTri=Record
    A,B,C:Integer;
  End;
Var
  T:Array[1..4]Of TTri;
  I:Integer;
Procedure Swap(Var A,B:Integer);
Var
  T:Integer;
Begin
  T:=A;
  A:=B;
  B:=T;
End;
Function Have(A,B,C:Integer):Boolean;
Var
  I:Integer;
Begin
  Result:=False;
  For I:=1 To 4 Do If (T[I].A=A) And (T[I].B=B) And (T[I].C=C) Then Result:=True;
End;
Begin
  For I:=1 To 4 Do With T[I] Do Begin
    A:=Ouf.ReadLongInt;
    B:=Ouf.ReadLongInt;
    C:=Ouf.ReadLongInt;
    If A>B Then Swap(A,B);
    If B>C Then Swap(B,C);
    If A>B Then Swap(A,B);
  End;
  If Have(1,2,3) And Have(4,5,6) And ((Have(1,3,4) And Have(1,4,6)) Or (Have(1,3,6) And Have(3,4,6))) Then
    Quit(_OK,'')
  Else
    Quit(_WA,'');
End.
