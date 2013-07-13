{$MINSTACKSIZE 30000000}
Uses SysUtils;

Type
  TTree=Class
  Public
    N:Integer;
    Parent:Array Of Integer;
    Constructor Create(N:Integer);
    Constructor CreateRandom(N:Integer);
    Constructor CreateStar(N:Integer);
    Constructor CreateChain(N:Integer);
    Constructor CreateSubstitution(Big,Small:TTree);
    Constructor CreateFullSubstitution(Big,Small:TTree);
    Constructor CreateIterated(Sample:TTree; Depth:Integer);
    Function Duplicate:TTree;
    Function Shuffle:TTree;
    Procedure WriteOut();
    Destructor Free;
  End;

Destructor TTree.Free;
Begin
  Finalize(Parent);
End;

Constructor TTree.Create(N:Integer);
Begin
  Self.N:=N;
  SetLength(Parent,N+1);
End;

Constructor TTree.CreateRandom(N:Integer);
Var
  I:Integer;
Begin
  Create(N);
  For I:=2 To N Do Parent[I]:=Random(I-1)+1;
End;

Constructor TTree.CreateStar(N:Integer);
Var
  I:Integer;
Begin
  Create(N);
  For I:=2 To N Do Parent[I]:=1;
End;

Constructor TTree.CreateChain(N:Integer);
Var
  I:Integer;
Begin
  Create(N);
  For I:=2 To N Do Parent[I]:=I-1;
End;

Constructor TTree.CreateSubstitution(Big,Small:TTree);
Var
  Mark:Array Of Boolean;
  I,J:Integer;
Begin
  N:=Big.N;
  SetLength(Parent,N+1);
  For I:=2 To N Do Parent[I]:=Big.Parent[I];
  SetLength(Mark,N+1);
  For I:=1 To N Do Mark[I]:=True;
  For I:=2 To N Do Mark[Parent[I]]:=False;
  For I:=1 To N Do If Mark[I] Then Begin
    Inc(N,Small.N-1);
    SetLength(Parent,N+1);
    For J:=2 To Small.N Do Begin
      If Small.Parent[J]=1 Then
        Parent[N-Small.N+J]:=I
      Else
        Parent[N-Small.N+J]:=Small.Parent[J]+N-Small.N;
    End;
  End;
  Finalize(Mark);
  Big.Free;
  Small.Free;
End;

Constructor TTree.CreateFullSubstitution(Big,Small:TTree);
Var
  I,J:Integer;
Begin
  N:=Big.N;
  SetLength(Parent,N+1);
  For I:=2 To N Do Parent[I]:=Big.Parent[I];
  For I:=1 To N Do Begin
    Inc(N,Small.N-1);
    SetLength(Parent,N+1);
    For J:=2 To Small.N Do Begin
      If Small.Parent[J]=1 Then
        Parent[N-Small.N+J]:=I
      Else
        Parent[N-Small.N+J]:=Small.Parent[J]+N-Small.N;
    End;
  End;
  Big.Free;
  Small.Free;
End;

Function TTree.Shuffle:TTree;
Var
  NewParent,Ind,Heap,NumC,Weight:Array Of Integer;
  Cur,CInd,I,J,T,NHeap:Integer;
Procedure Swap(A,B:Integer);
Var
  T:Integer;
Begin
  T:=Heap[A];
  Heap[A]:=Heap[B];
  Heap[B]:=T;
End;
Procedure HeapUp(At:Integer);
Begin
  While (At>1) And (Weight[Heap[At]]>Weight[Heap[At Div 2]]) Do Begin
    Swap(At Div 2,At);
    At:=At Div 2;
  End;
End;
Procedure AddToHeap(What:Integer);
Begin
  Inc(NHeap);
  Heap[NHeap]:=What;
  HeapUp(NHeap);
End;
Procedure HeapDown(At:Integer);
Var
  I:Integer;
Begin
  While True Do Begin
    I:=At;
    If (2*At<=NHeap) And (Weight[Heap[2*At]]<Weight[Heap[I]]) Then I:=2*At;
    If (2*At+1<=NHeap) And (Weight[Heap[2*At+1]]<Weight[Heap[I]]) Then I:=2*At+1;
    If I=At Then Break;
    Swap(At,I);
    At:=I;
  End;
End;
Function GetFromHeap:Integer;
Begin
  Result:=Heap[1];
  Heap[1]:=Heap[NHeap];
  Dec(NHeap);
  HeapDown(1);
End;

Begin
  SetLength(Heap,N+1);
  SetLength(Weight,N+1);
  SetLength(NumC,N+1);
  SetLength(Ind,N+1);
  SetLength(NewParent,N+1);
  For I:=1 To N Do Weight[I]:=I;
  For I:=1 To N Do Begin
    J:=I+Random(N-I+1);
    If I<>J Then Begin
      T:=Weight[I];
      Weight[I]:=Weight[J];
      Weight[J]:=T;
    End;
  End;
  For I:=1 To N Do NumC[I]:=0;
  For I:=2 To N Do Inc(NumC[Parent[I]]);
  NHeap:=0;
  For I:=1 To N Do If NumC[I]=0 Then AddToHeap(I);
  CInd:=N;
  While NHeap>0 Do Begin
    Cur:=GetFromHeap;
    Ind[Cur]:=CInd;
    Dec(CInd);
    If Cur>1 Then Begin
      Dec(NumC[Parent[Cur]]);
      If NumC[Parent[Cur]]=0 Then AddToHeap(Parent[Cur]);
    End;
  End;
  For I:=2 To N Do NewParent[Ind[I]]:=Ind[Parent[I]];
  For I:=2 To N Do Parent[I]:=NewParent[I];
  Finalize(NewParent);
  Finalize(Heap);
  Finalize(Weight);
  Finalize(NumC);
  Finalize(Ind);
  Result:=Self;
End;

Function TTree.Duplicate:TTree;
Var
  I:Integer;
Begin
  Result:=TTree.Create(N);
  For I:=2 To N Do Result.Parent[I]:=Parent[I];
End;

Constructor TTree.CreateIterated(Sample:TTree; Depth:Integer);
Var
  I:Integer;
  Tmp:TTree;
Begin
  If Depth=1 Then Begin
    Create(Sample.N);
    For I:=2 To N Do Parent[I]:=Sample.Parent[I];
    Sample.Free;
  End Else Begin 
    Tmp:=TTree.CreateIterated(Sample.Duplicate,Depth-1);
    CreateSubstitution(Tmp,Sample);
  End;
End;

Procedure TTree.WriteOut();
Var
  I, j:Integer;
  p: array of longint;
Begin
  WriteLn(N);

  setlength(p, n + 1);
  for i := 1 to n do begin
  	j := random(i) + 1;
  	p[i] := p[j];
  	p[j] := i;
  end;

  For I:=2 To N Do Begin
  	if (random(2) = 0) then
	    Writeln(p[i], ' ', p[Parent[I]])
	else
	    Writeln(p[Parent[I]], ' ', p[i]);
  End;
End;

Begin
  RandSeed:=20202020;

  TTree.CreateStar(400).Shuffle().WriteOut();
  TTree.CreateStar(500).Shuffle().WriteOut();
End.