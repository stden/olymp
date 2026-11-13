{$D+,I+,L+,Q+,R+,S+,O-}
  Uses SysUtils;
  Const File_In='preference.in';
        File_Out='preference.out';
  Type Int=LongInt;
       TSuit=(Spades, Clubs, Diamonds, Hearts,No);
       	     //Пики, Крести, Буби, Червы
       TCard=Record
               Value:Int;
               Suit:TSuit;
             End;
       THand=Array[1..12]Of TCard;
  Var Hand:Array[1..3]Of THand;
      TmpHand:THand;
      Ans:Record
            GamePrice:Int;
            Discard:Array[1..2]Of TCard;
            Trump:TSuit;
          End;
      CntTrump,I,J,K,Move,Tmp:Int;
      MinPrice,MaxPrice:Real;
      Trump:TSuit;

Function ReadSym:Char;
Begin
  Repeat
    Assert(Not SeekEoF,'Too small information.');
    Read(Result);
  Until (Result In ['7'..'9','T','J','Q','K','A','S','C','D','H']);
End;

Function LessHand(Const Card1,Card2:TCard):Boolean;
Begin
  Result:=(Card1.Suit<Card2.Suit) Or ((Card1.Suit=Card2.Suit) And (Card1.Value<Card2.Value));
End;

Procedure SwapHand(Var Hand1,Hand2:TCard);
  Var Tmp:TCard;
Begin
  Tmp:=Hand1;
  Hand1:=Hand2;
  Hand2:=Tmp;
End;

Procedure SortHand(Var Hand:THand; Const Len:Int);
  Var I,J:Int;
Begin
  For I:=1 TO Len Do Begin
    J:=I;
    While (J>1) And LessHand(Hand[J],Hand[J-1]) Do Begin
      SwapHand(Hand[J],Hand[J-1]);
      Dec(J);
    End;
  End;
End;

Procedure ReadHand(Var Hand:THand; Const Len:Int);
  Var I:Int;
Begin
  For I:=1 To Len Do Begin
    Case ReadSym Of
      '7': Hand[I].Value:=7;
      '8': Hand[I].Value:=8;
      '9': Hand[I].Value:=9;
      'T': Hand[I].Value:=10;
      'J': Hand[I].Value:=11;
      'Q': Hand[I].Value:=12;
      'K': Hand[I].Value:=13;
      'A': Hand[I].Value:=14;
      Else Assert(False,'Bad card');
    End;
    Case ReadSym Of
      'S': Hand[I].Suit:=Spades;
      'C': Hand[I].Suit:=Clubs;
      'D': Hand[I].Suit:=Diamonds;
      'H': Hand[I].Suit:=Hearts;
      Else Assert(False,'Bad card');
    End;
  End;
  SortHand(Hand,Len);
End;

Procedure WriteSuit(Const Suit:TSuit);
Begin
  Case Suit Of
    Spades: Write('S');
    Clubs: Write('C');
    Diamonds: Write('D');
    Hearts: Write('H');
    No: Write('N');
  End;
End;

Procedure WriteCard(Const Card:TCard);
Begin
  Case Card.Value Of
    7: Write('7');
    8: Write('8');
    9: Write('9');
    10: Write('10');
    11: Write('J');
    12: Write('Q');
    13: Write('K');
    14: Write('A');
  End;
  WriteSuit(Card.Suit);
  Write(' ');
End;

Procedure Check(Const Hand:THand; Const I,J:Int; Var Min,Max:Real);
  Var Cards:Array[7..14] Of Boolean;
      Cnt,K:Int;
Begin
  FillChar(Cards,SizeOf(Cards),0);
  For K:=I To J Do
    Cards[Hand[K].Value]:=True;
  Cnt:=J-I+1;
  Case Cnt Of
    1: If Cards[14] Then Begin
         Min:=Min+0.9;
         Max:=Max+1;
       End;
    2: If Cards[14] And Cards[13] Then Begin
         Min:=Min+1.9;
         Max:=Max+2;
       End
       Else If Cards[13] And Cards[12] Then Begin
         Min:=Min+0.9;
         Max:=Max+1;
       End;
    3: If Cards[14] And Cards[13] And Cards[12] Then Begin
         Min:=Min+2.8;
         Max:=Max+3;
       End
       Else If Cards[13] And Cards[12] And Cards[11] Then Begin
         Min:=Min+1.5;
         Max:=Max+2;
       End
       Else If Cards[14] Then Begin
         Min:=Min+0.9;
         Max:=Max+1;
       End
       Else If (Cards[12] Or Cards[13]) And Cards[11] Then
          Max:=Max+0.3;
    4: If Cards[14] And Cards[13] And Cards[12] Then Begin
         Min:=Min+3.7;
         Max:=Max+4;
       End
       Else If Cards[14] And Cards[13] And Cards[11] Then Begin
         Min:=Min+3.5;
         Max:=Max+4;
       End
       Else If Cards[14] And Cards[13] Then Begin
         Min:=Min+2.7;
         Max:=Max+3.5;
       End
       Else If Cards[14] And Cards[12] And Cards[11] Then Begin
         Min:=Min+2.5;
         Max:=Max+3;
       End
       Else If Cards[14] And Cards[11] Then Begin
         Min:=Min+1.5;
         Max:=Max+2.5;
       End
       Else If Cards[14] Then Begin
         Min:=Min+1;
         Max:=Max+3;
       End
       Else If Cards[13] And Cards[12] And Cards[11] Then Begin
         Min:=Min+3;
         Max:=Max+3;
       End
       Else If Cards[13] And Cards[12] Then Begin
         Min:=Min+2.5;
         Max:=Max+3;
       End
       Else If Cards[13] And Cards[11] Then Begin
         Min:=Min+0.5;
         Max:=Max+2;
       End
       Else If Cards[12] And Cards[11] Then Begin
         Min:=Min+0.5;
         Max:=Max+1.5;
       End
       Else Begin
         Min:=Min+0.5;
         Max:=Max+1.5;
       End;
    5: If Not Cards[14] And Not Cards[13] And Not Cards[12] Then Begin
         Min:=Min+2;
         Max:=Max+3;
       End
       Else If Not Cards[13] And Not Cards[12] And Not Cards[11] Then Begin
         Min:=Min+2.7;
         Max:=Max+4;
       End
       Else If Not Cards[14] Then Begin
         Min:=Min+3;
         Max:=Max+4;
       End
       Else If (Not Cards[12] Or Not Cards[13]) And Not Cards[11] Then Begin
          Min:=Min+4.7;
          Max:=Max+4.7;
       End;
    6: If Cards[14] And Cards[13] Then Begin
         Min:=Min+6;
         Max:=Max+6;
       End
       Else If Cards[14] Then Begin
         Min:=Min+5;
         Max:=Max+6;
       End
       Else If Not Cards[14] And (Not Cards[13] Or Not Cards[12])Then Begin
         Min:=Min+4;
         Max:=Max+5;
       End
       Else Begin
         Min:=Min+5;
         Max:=Max+5;
       End;
    7: If Cards[14] Then Begin
         Min:=Min+8;
         Max:=Max+8;
       End
       Else Begin
         Min:=Min+6;
         Max:=Max+6;
       End;
    8: Begin
         Min:=Min+8;
         Max:=Max+8;
       End;
  End;
End;

Begin
  Assign(Input,File_In);
  ReSet(Input);
  Assign(Output,File_Out);
  ReWrite(Output);
  Read(Move);
  Assert((Move>=1)And(Move<=3),'Bad first move');
  ReadHand(Hand[1],12);
  ReadHand(Hand[2],10);
  ReadHand(Hand[3],10);
  Ans.GamePrice:=-1;
  For I:=2 To 12 Do
    For J:=1 To I-1 Do Begin
      If (I=8) And (J=7) Then BEgin
        Tmp:=-1;
      End;
      TmpHand:=Hand[1];
      Tmp:=0;
      For K:=1 To 12 Do
        If (K<>I) And (K<>J) Then Begin
          Inc(Tmp);
          TmpHand[Tmp]:=Hand[1][K];
        End;
      MinPrice:=0;
      MaxPrice:=0;
      Tmp:=1;
      CntTrump:=0;
      TmpHand[11].Suit:=No;
      For K:=1 To 10 Do
        If TmpHand[K].Suit<>TmpHand[K+1].Suit Then Begin
          Check(TmpHand,Tmp,K,MinPrice,MaxPrice);
          If K-Tmp+1>CntTrump Then Begin
            CntTrump:=K-Tmp+1;
            Trump:=TmpHand[K].Suit;
          End;
          Tmp:=K+1;
          If Round((MinPrice+MaxPrice)/2)>Ans.GamePrice Then Begin
            Ans.GamePrice:=Round((MinPrice+MaxPrice)/2);
            Ans.Trump:=Trump;
            Ans.Discard[1]:=Hand[1][I];
            Ans.Discard[2]:=Hand[1][J];            
          End;
        End;
    End;
  WriteLn(Ans.GamePrice);
  WriteCard(Ans.Discard[1]);
  WriteCard(Ans.Discard[2]);
  WriteLn;
  WriteSuit(Ans.Trump);
  Close(Input);
  Close(Output);
End.