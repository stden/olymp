uses
        SysUtils;
const
        MaxC = 10;
        MaxPl = 3;
        MaxMast = 4;
        MaxDost = 8;
type
        TCard =
        record
          dost, mast : Byte;
        end;
var
        c : Array[1 .. MaxPl, 1 .. MaxC + 2] of TCard;
        have : Array[1 .. MaxPl, 1 .. MaxMast, 0 .. MaxDost] of Boolean;

        cards : Array[1 .. MaxPl, 1 .. MaxMast, 0 .. MaxDost] of LongInt;
        colcards : Array[1 .. MaxPl, 1 .. MaxMast] of LongInt;
        xod : LongInt;
        _end : Real;

Procedure ReadCard(var card : TCard);
var
        c : Char;
begin
  Read(c);
  While not (c in ['7' .. '9', 'T', 'J', 'Q', 'K', 'A']) do
    Read(c);
  Case c of
    '7' : card.dost := 1;
    '8' : card.dost := 2;
    '9' : card.dost := 3;
    'T' : card.dost := 4;
    'J' : card.dost := 5;
    'Q' : card.dost := 6;
    'K' : card.dost := 7;
    'A' : card.dost := 8;
  end;
  Read(c);
  Case c of
    'S' : card.mast := 1;
    'C' : card.mast := 2;
    'D' : card.mast := 3;
    'H' : card.mast := 4;
  end;
end;

Procedure Analyse(const pl : LongInt; const col : LongInt);
var
        i, j, k, l : LongInt;
begin
  FillChar(have[pl], SizeOf(have[pl]), False);
  FillChar(cards[pl], SizeOf(cards[pl]), 0);
  for i := 1 to col do
  begin
    Inc(cards[pl][c[pl][i].mast][0]);
    cards[pl][c[pl][i].mast][cards[pl][c[pl][i].mast][0]] := c[pl][i].dost;
    have[pl][c[pl][i].mast][cards[pl][c[pl][i].mast][0]] := True;
  end;
  for i := 1 to MaxMast do
    colcards[pl][i] := cards[pl][i][0];
  for i := 1 to MaxMast do
    for j := 1 to cards[pl][i][0] do
      for k := 1 to cards[pl][i][0] - 1 do
        if cards[pl][i][k] > cards[pl][i][k + 1] then
        begin
          l := cards[pl][i][k];
          cards[pl][i][k] := cards[pl][i][k + 1];
          cards[pl][i][k + 1] := l;
        end;
end;

Function GetMax(const a : LongInt; const ia : Boolean; const b : LongInt; const ib : Boolean; const c : LongInt; const ic : Boolean) : Byte;
begin
  if ia then
  begin
    if ib then
    begin
      if ic then
      begin
        if (a > b) and (a > c) then
          GetMax := 1
        else
          if (b > c) and (b > a) then
            GetMax := 2
          else
            GetMax := 3;
      end
      else
      begin
        if (a > b) then
          GetMax := 1
        else
          GetMax := 2;
      end;
    end
    else
    begin
      if ic then
      begin
        if a > c then
          GetMax := 1
        else
          GetMax := 3;
      end
      else
        GetMax := 1;
    end;
  end
  else
  begin
    if ib then
    begin
      if ic then
      begin
        if b > c then
          GetMax := 2
        else
          GetMax := 3;
      end
      else
        GetMax := 2;
    end
    else
    begin
      if ic then
        GetMax := 3
      else
        GetMax := 0;
    end;
  end;
end;

Function Win(const nachmast, m1, d1, m2, d2, m3, d3, koz : Byte) : Byte;
begin
  if (m1 = koz) or (m2 = koz) or (m3 = koz) then
    Win := GetMax(cards[1][m1][d1], m1 = koz, cards[2][m2][d2], m2 = koz, cards[3][m3][d3], m3 = koz)
  else
    Win := GetMax(cards[1][m1][d1], m1 = nachmast, cards[2][m2][d2], m2 = nachmast, cards[3][m3][d3], m3 = nachmast);
end;

Function Max(const a, b : Byte) : Byte;
begin
  if a > b then
    Max := a
  else
    Max := b;
end;

Function Min(const a, b : Byte) : Byte;
begin
  if a < b then
    Min := a
  else
    Min := b;
end;

var
        aaa : Boolean;

Function DFS(const xod, koz, g : Byte; const alfa, beta : ShortInt) : Byte;
var
        mast1, dost1, mast2, dost2, mast3, dost3, rez1, rez2, rez3 : Byte;
begin
  if (g = MaxC - 1) and (now > _end) then
    aaa := True;
  if aaa then
  begin
    DFS := alfa;
    Exit;
  end;
  if g = MaxC then
  begin
    DFS := 0;
    Exit;
  end;
  if alfa >= beta then
  begin
    DFS := alfa;
    Exit;
  end;
  Case xod of
    1 :
    begin
      rez1 := 0;
      for mast1 := 1 to MaxMast do
        if colcards[1][mast1] <> 0 then
          for dost1 := 1 to cards[1][mast1][0] do
            if have[1][mast1][dost1] then
            begin
              Dec(colcards[1][mast1]);
              have[1][mast1][dost1] := False;
              rez2 := MaxC;
              for mast2 := 1 to MaxMast do
                if not ((colcards[2][mast2] = 0) or ((colcards[2][mast1] <> 0) and (mast2 <> mast1)) or ((colcards[2][mast1] = 0) and (colcards[2][koz] <> 0) and (mast2 <> koz))) then

                  for dost2 := 1 to cards[2][mast2][0] do
                    if have[2][mast2][dost2] then
                    begin
                      Dec(colcards[2][mast2]);
                      have[2][mast2][dost2] := False;
                      for mast3 := 1 to MaxMast do
                        if not ((colcards[3][mast3] = 0) or ((colcards[3][mast1] <> 0) and (mast3 <> mast1)) or ((colcards[3][mast1] = 0) and (colcards[3][koz] <> 0) and (mast3 <> koz))) then
                          for dost3 := 1 to cards[3][mast3][0] do
                            if have[3][mast3][dost3] then
                            begin
                              Dec(colcards[3][mast3]);
                              have[3][mast3][dost3] := False;
                              rez2 := Min(rez2, DFS(Win(mast1, mast1, dost1, mast2, dost2, mast3, dost3, koz), koz, g + 1, alfa, rez2));
                              Inc(colcards[3][mast3]);
                              have[3][mast3][dost3] := True;
                            end;
                      Inc(colcards[2][mast2]);
                      have[2][mast2][dost2] := True;
                    end;
              Inc(colcards[1][mast1]);
              have[1][mast1][dost1] := True;
              rez1 := Max(rez1, rez2);
            end;
      DFS := rez1 + 1;
    end;
    2 :
    begin
      rez1 := MaxC;
      for mast2 := 1 to MaxMast do
        if colcards[2][mast2] <> 0 then
          for dost2 := 1 to cards[2][mast2][0] do
            if have[2][mast2][dost2] then
            begin
              Dec(colcards[2][mast2]);
              have[2][mast2][dost2] := False;
              for mast3 := 1 to MaxMast do
                if not ((colcards[3][mast3] = 0) or ((colcards[3][mast2] <> 0) and (mast3 <> mast2)) or ((colcards[3][mast2] = 0) and (colcards[3][koz] <> 0) and (mast3 <> koz))) then
                  for dost3 := 1 to cards[3][mast3][0] do
                    if have[3][mast3][dost3] then
                    begin
                      Dec(colcards[3][mast3]);
                      have[3][mast3][dost3] := False;
                      rez2 := 0;
                      for  mast1 := 1 to MaxMast do
                        if not ((colcards[1][mast1] = 0) or ((colcards[1][mast2] <> 0) and (mast1 <> mast2)) or ((colcards[1][mast2] = 0) and (colcards[1][koz] <> 0) and (mast1 <> koz))) then
                          for dost1 := 1 to cards[1][mast1][0] do
                            if have[1][mast1][dost1] then
                            begin
                              Dec(colcards[1][mast1]);
                              have[1][mast1][dost1] := False;
                              rez2 := Max(rez2, DFS(Win(mast2, mast1, dost1, mast2, dost2, mast3, dost3, koz), koz, g + 1, rez2, beta));
                              Inc(colcards[1][mast1]);
                              have[1][mast1][dost1] := True;
                            end;
                      rez1 := Min(rez1, rez2);
                      Inc(colcards[3][mast3]);
                      have[3][mast3][dost3] := True;
                    end;
              Inc(colcards[2][mast2]);
              have[2][mast2][dost2] := True;
            end;
      DFS := rez1;
    end;
    3 :
    begin
      rez1 := MaxC;
      for mast3 := 1 to MaxMast do
        if colcards[3][mast3] <> 0 then
          for dost3 := 1 to cards[3][mast3][0] do
            if have[3][mast3][dost3] then
            begin
              Dec(colcards[3][mast3]);
              have[3][mast3][dost3] := False;
              rez2 := 0;
              for mast1 := 1 to MaxMast do
                if not ((colcards[1][mast1] = 0) or ((colcards[1][mast3] <> 0) and (mast1 <> mast3)) or ((colcards[1][mast3] = 0) and (colcards[1][koz] <> 0) and (mast1 <> koz))) then
                  for dost1 := 1 to cards[1][mast1][0] do
                    if have[1][mast1][dost1] then
                    begin
                      Dec(colcards[1][mast1]);
                      have[1][mast1][dost1] := False;
                      rez3 := MaxC;
                      for mast2 := 1 to MaxMast do
                        if not ((colcards[2][mast2] = 0) or ((colcards[2][mast3] <> 0) and (mast2 <> mast3)) or ((colcards[2][mast3] = 0) and (colcards[2][koz] <> 0) and (mast2 <> koz))) then
                          for dost2 := 1 to cards[2][mast2][0] do
                            if have[2][mast2][dost2] then
                            begin
                              Dec(colcards[2][mast2]);
                              have[2][mast2][dost2] := False;
                              rez3 := Min(rez3, DFS(Win(mast3, mast1, dost1, mast2, dost2, mast3, dost3, koz), koz, g + 1, alfa, rez3));
                              Inc(colcards[2][mast2]);
                              have[2][mast2][dost2] := True;
                            end;
                      rez2 := Max(rez2, rez3);
                      Inc(colcards[1][mast1]);
                      have[1][mast1][dost1] := True;
                    end;
              rez1 := Min(rez1, rez2);
              Inc(colcards[3][mast3]);
              have[3][mast3][dost3] := True;
            end;
      DFS := rez1;
    end;
  end;
end;

Function MinCard(const pl, mast : Byte) : Byte;
var
        r : Byte;
begin
  if colcards[pl][mast] = 0 then
    MinCard := 0
  else
  begin
    r := 1;
    While not have[pl][mast][r] do
      Inc(r);
    MinCard := r;
  end;
end;

Function MinMore(const pl, mast, d : Byte) : Byte;
var
        r : Byte;
begin
  r := 1;
  While r <= colcards[pl][mast] do
  begin
    if (cards[pl][mast][r] > d) and (have[pl][mast][r]) then
      Break;
    Inc(r);
  end;
  if r <= colcards[pl][mast] then
    MinMore := r
  else
    MinMore := 0;
end;

{Function CleverDFS(const xod, koz : Byte) : Byte;
var
        mast1, dost1, rez1 : Byte;
begin
  Case xod of
    1 :
    begin
      rez1 := 0;
      for mast1 := 1 to MaxMast do
        if colcards[1][mast1] <> 0 then
          for dost1 := 1 to cards[1][mast1][0] do
            if have[1][mast1][dost1] then
            begin
              rez2 := 0;
              if colcards[2][mast1] <> 0 then
              begin
                mast2 := mast1;
                dost2 := MinCard
              end
              else
              begin
              end;
            end;
      CleverDFS := rez1 + 1;
    end;
    2 :
    begin
    end;
    3 :
    begin
    end;
  end;
end;
}
Procedure Init;
var
        i : LongInt;
begin
  ReadLn(xod);
  for i := 1 to MaxC + 2 do
    ReadCard(c[1][i]);
  Analyse(1, MaxC);
  for i := 1 to MaxC do
    ReadCard(c[2][i]);
  Analyse(2, MaxC);
  for i := 1 to MaxC do
    ReadCard(c[3][i]);
  Analyse(3, MaxC);
end;

Procedure Solve;
var
        i, rez : LongInt;

begin
  if xod = 1 then
    WriteLn(DFS(xod, 1, 0, -1, 100) - 1)
  else
    WriteLn(DFS(xod, 1, 0, -1, 100));
  Case c[1][MaxC + 1].dost of
    1 : Write('7');
    2 : Write('8');
    3 : Write('9');
    4 : Write('T');
    5 : Write('J');
    6 : Write('Q');
    7 : Write('K');
    8 : Write('A');
  end;
  Case c[1][MaxC + 1].mast of
    1 : Write('S');
    2 : Write('C');
    3 : Write('D');
    4 : Write('H');
  end;
  Write(' ');
  Case c[1][MaxC + 2].dost of
    1 : Write('7');
    2 : Write('8');
    3 : Write('9');
    4 : Write('T');
    5 : Write('J');
    6 : Write('Q');
    7 : Write('K');
    8 : Write('A');
  end;
  Case c[1][MaxC + 2].mast of
    1 : Write('S');
    2 : Write('C');
    3 : Write('D');
    4 : Write('H');
  end;
  WriteLn;
  WriteLn('S');
{  rez := 0;
  for i := 0 to 10 do
    Inc(rez, i*i*i*C(10,i)*C(10,i)*C(10,i));
  WriteLn(rez);}
end;

begin
  Assign(input, 'preference.in');
  Reset(input);
  _end := now + 1.7 / 60 / 60 / 24;
  Assign(output, 'preference.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.