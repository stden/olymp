{$R+,Q+,S+,I+,O-}
{$MODE DELPHI}
Uses Math,SysUtils;

type integer = longint;

Const 
  MaxK=5;
  MaxN=100000;
Type
  TArr=Array[0..MaxK-1]Of Integer;
Var
  N,K:Integer;
  Tree:Array[1..4*MaxN]Of TArr;
  Sum:Array[1..4*MaxN]Of Integer;
  Delta:Array[1..4*MaxN]Of Integer;

Procedure InitTree(Root,RL,RR:Integer);
Var
  RM:Integer;
Begin
  Tree[Root,0]:=RR-RL+1;
  If RL=RR Then Exit;
  RM:=(RL+RR) Div 2;
  InitTree(Root*2,RL,RM);
  InitTree(Root*2+1,RM+1,RR);
End;

Procedure AddToVertex(Root,What:Integer);
Var
  Tmp:TArr;
  I,J:Integer;
Begin
  FillChar(Tmp,SizeOf(Tmp),0);
  Sum[Root]:=0;
  J:=What Mod K;
  For I:=0 To K-1 Do Begin
    Tmp[J]:=Tree[Root,I];
    Inc(Sum[Root],J*Tmp[J]);
    Inc(J);
    If J=K Then J:=0;
  End;
  Tree[Root]:=Tmp;
End;

Procedure UpdateVertex(Root:Integer);
Var
  I:Integer;
Begin
  For I:=0 To K-1 Do Tree[Root,I]:=Tree[Root*2,I]+Tree[Root*2+1,I];
  AddToVertex(Root,Delta[Root]);
End;

Procedure Discharge(Root:Integer);
Begin
  If Delta[Root]=0 Then Exit;
  AddToVertex(Root*2,Delta[Root]);
  AddToVertex(Root*2+1,Delta[Root]);
  Delta[Root*2]:=(Delta[Root*2]+Delta[Root]) Mod K;
  Delta[Root*2+1]:=(Delta[Root*2+1]+Delta[Root]) Mod K;
  Delta[Root]:=0;
End;

Procedure Update(Root,RL,RR,L,R,By:Integer);
Var
  RM:Integer;
Begin
  If L>R Then Exit;
  If (RL=L) And (RR=R) Then Begin
    Delta[Root]:=(Delta[Root]+By) Mod K;
    AddToVertex(Root,By);
  End Else Begin
    RM:=(RL+RR) Div 2;
    Update(Root*2,RL,RM,L,Min(R,RM),By);
    Update(Root*2+1,RM+1,RR,Max(L,RM+1),R,By);
    UpdateVertex(Root);
  End;
End;

Function Retrieve(Root,RL,RR,L,R:Integer):Integer;
Var
  RM:Integer;
Begin
  If L>R Then Result:=0 Else Begin
    If (L=RL) And (R=RR) Then Result:=Sum[Root] Else Begin
      Discharge(Root);
      RM:=(RL+RR) Div 2;
      Result:=Retrieve(Root*2,RL,RM,L,Min(R,RM))+Retrieve(Root*2+1,RM+1,RR,Max(L,RM+1),R);
    End;
  End;
End;

Var
  I,M:Integer;
  A,B,C,D:Integer;

Begin
  assign(Input,'sum.in'); reset(input);
  assign(Output,'sum.out'); rewrite(output);
  Read(N);
  Read(K);
  FillChar(Tree,SizeOf(Tree),0);
  FillChar(Sum,SizeOf(Sum),0);
  FillChar(Delta,SizeOf(Delta),0);
  InitTree(1,1,N);
  Read(M);
  For I:=1 To M Do Begin
    Read(A);
    If A=1 Then Begin
      Read(B,C);
      Update(1,1,N,B,C,1);
    End Else Begin
      Read(B,C);
      WriteLn(Retrieve(1,1,N,B,C));
    End;
  End;
  Close(Input);
  Close(Output);
End.
