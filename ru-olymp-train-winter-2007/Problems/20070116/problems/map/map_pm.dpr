{$R+,Q+,S+,H+,O-}
{$APPTYPE CONSOLE}
Uses Math,SysUtils;
Const
  TaskID='map';
  InFile=TaskID+'.in';
  OutFile=TaskID+'.out';
  MaxN=1000;

Type
  TTree=Record
    N:Integer;
    First:Array[1..MaxN]Of Integer;
    EdgeSrc,EdgeDest,EdgeNext:Array[1..2*MaxN]Of Integer;
  End;

Var
  H,G:TTree;
  GParent:Array[1..MaxN]Of Integer;
  Answer:Array[-MaxN..2*MaxN,1..MaxN]Of Boolean;
  Got:Array[-MaxN..2*MaxN,1..MaxN]Of Boolean;
  Match:Array[-MaxN..2*MaxN,1..MaxN]Of Integer;
  Unmatched:Array[-MaxN..-1,1..MaxN]Of Integer;
  Mark:Array[-MaxN..2*MaxN,1..2*MaxN]Of Boolean;
  Res:Boolean;
  ResMatch:Array[1..MaxN]Of Integer;

Procedure ReadTree(Var T:TTree);
Var
  I,NE,A,B:Integer;
Begin
  With T Do Begin
    Read(N);
    assert(n <= 500);
    FillChar(First,SizeOf(First),0);
    NE:=0;
    For I:=1 To N-1 Do Begin
      Read(A,B);
      Inc(NE);
      EdgeSrc[NE]:=A;
      EdgeDest[NE]:=B;
      EdgeNext[NE]:=First[A];
      First[A]:=NE;
      Inc(NE);
      EdgeSrc[NE]:=B;
      EdgeDest[NE]:=A;
      EdgeNext[NE]:=First[B];
      First[B]:=NE;
    End;
  End;
End;

Procedure Load;
Begin
  ReSet(Input,InFile);
  ReadTree(H);
  ReadTree(G);
  Close(Input);
End;

Procedure GDFS(Start,Par:Integer);
Var
  I:Integer;
Begin
  If GParent[Start]<>0 Then Exit;
  GParent[Start]:=Par;
  I:=G.First[Start];
  While I>0 Do Begin
    GDFS(G.EdgeDest[I],Start);
    I:=G.EdgeNext[I];
  End;
End;

Function Get(U,V:Integer):Boolean; Forward;

Function Improve(Start,U,V:Integer):Boolean;
Var
  E,VV:Integer;
Begin
  Result:=False;
  If Mark[U,Start] Then Exit;
  Mark[U,Start]:=True;
  E:=G.First[V];
  While E>0 Do Begin
    VV:=G.EdgeDest[E];
    If (VV<>GParent[V]) And Get(Start,VV) Then Begin
      If (Match[U,VV]=0) Or Improve(Match[U,VV],U,V) Then Begin
        Match[U,VV]:=Start;
        Result:=True;
        Exit;
      End;
    End;
    E:=G.EdgeNext[E];
  End;
End;

Function Get(U,V:Integer):Boolean;
Var
  UU,VV,E,Unm:Integer;
Begin
  If Got[U,V] Then Begin
    Result:=Answer[U,V];
    Exit;
  End;
  If U<0 Then Begin
    E:=H.First[-U];
    Unm:=0;
    While E>0 Do Begin
      FillChar(Mark[U],SizeOf(Mark[U]),False);
      If Not Improve(E,U,V) Then Begin
        If Unm>0 Then Begin
          Unm:=-1;
          Break;
        End;
        Unm:=E;
      End;
      E:=H.EdgeNext[E];
    End;
    Unmatched[U,V]:=Unm;
    Answer[U,V]:=(Unm=0);
  End Else Begin
    UU:=-H.EdgeDest[U];
    Get(UU,V);
    Unm:=Unmatched[UU,V];
    E:=G.First[V];
    While E>0 Do Begin
      VV:=G.EdgeDest[E];
      If (VV<>GParent[V]) And (Match[UU,VV]>0) And (H.EdgeDest[Match[UU,VV]]<>H.EdgeSrc[U]) Then
        Match[U,VV]:=Match[UU,VV];
      E:=G.EdgeNext[E];
    End;
    If (Unm=0) Or (Unm>0) And (H.EdgeDest[Unm]=H.EdgeSrc[U]) Then Begin
      Answer[U,V]:=True;
    End Else If Unm<0 Then
      Answer[U,V]:=False
    Else Begin
      FillChar(Mark[U],SizeOf(Mark[U]),False);
      Answer[U,V]:=Improve(Unm,U,V);
    End;
  End;
  Got[U,V]:=True;
  Result:=Answer[U,V];
End;

Procedure BuildAnswer(U,V:Integer);
Var
  UU,VV,E:Integer;
Begin
  E:=G.First[V];
  If U<0 Then UU:=-U Else UU:=H.EdgeDest[U];
  ResMatch[UU]:=V;
  While E>0 Do Begin
    VV:=G.EdgeDest[E];
    If (VV<>GParent[V]) And (Match[U,VV]>0) Then
      BuildAnswer(Match[U,VV],VV);
    E:=G.EdgeNext[E];
  End;
End;

Procedure Solve;
Var
  A,B:Integer;
Begin
  FillChar(GParent,SizeOf(GParent),0);
  FillChar(Match,SizeOf(Match),0);
  FillChar(Unmatched,SizeOf(Unmatched),0);
  GDFS(1,-1);
  Res:=False;
  FillChar(Got,SizeOf(Got),False);
  For A:=1 To H.N Do
    For B:=1 To G.N Do
      If Get(-A,B) Then Begin
        Res:=True;
        BuildAnswer(-A,B);
        Exit;
      End;
End;

Procedure Save;
Var
  I:Integer;
Begin
  ReWrite(Output,OutFile);
  If Res Then Begin
    WriteLn('YES');
    For I:=1 To H.N Do Begin
      If I>1 Then Write(' ');
      Write(ResMatch[I]);
    End;
    WriteLn;      
  End Else Begin
    WriteLn('NO');
  End;
  Close(Output);
End;

Begin
  Load;
  Solve;
  Save;
End.
