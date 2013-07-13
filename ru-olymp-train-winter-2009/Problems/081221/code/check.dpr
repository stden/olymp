{$I+,R+,Q+,S+}
{$APPTYPE CONSOLE}
Uses testlib;
Const
  MaxN=100000;
Type
  Integer=LongInt;
Var
  N:Integer;
  W:Array[1..MaxN]Of Int64;
  O,A:Int64;
Function IntToStr(A:Int64):String;
Begin
  Str(A,Result);
End;
Function ReadCode(Var Src:InStream; PECode,WACode:TResult):Int64;
Var
  S,Prev:String;
  I,J:Integer;
Begin
  Prev:=Pred('0');
  Result:=0;
  For I:=1 To N Do Begin
    S:=Src.ReadWord(Blanks,Blanks, true);
    For J:=1 To Length(S) Do If (S[J]<>'0') And (S[J]<>'1') Then
      Quit(PECode, 'Strange char in output: #'+IntToStr(Ord(S[J])));
    If S<=Prev Then Quit(WACode, 'Not lexicographical: [' + S + '] after [' + Prev + ']');
    If Copy(S,1,Length(Prev))=Prev Then Quit(WACode, 'Not prefix: [' + S + '] after [' + Prev + ']');
    Result:=Result+W[I]*Length(S);
    Prev:=S;
  End;  
End;
Var
  I:Integer;
Begin
  N:=Inf.ReadLongInt;
  For I:=1 To N Do W[I]:=Inf.ReadLongInt;
  A:=ReadCode(Ans,_Fail,_Fail);
  O:=ReadCode(Ouf,_PE,_WA);
  If O<A Then
    Quit(_Fail, 'He''s better than us! '+IntToStr(O) + ' instead of ' + IntToStr(A))
  Else If O>A Then
    Quit(_WA, 'too much. '+IntToStr(O) + ' instead of ' + IntToStr(A))
  Else
    Quit(_OK, 'N=' + IntToStr(N));
End.