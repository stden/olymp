uses
        SysUtils;
const
        MaxW = 1024;
        MaxScore = 6;
        MaxTest = 46;
type
        TString = String[20];
var
        test : LongInt;
        ttt : String;
        k, l : LongInt;
        maxmax, sscore : LongInt;
        score : Array[1 .. MaxTest] of LongInt;
        sm : Array[0 .. MaxW, 0 .. MaxW] of Boolean;
        _end : Real;

Procedure Init;
begin
  Read(k, l);
end;

Function StrToNumber(const s : TString) : LongInt;
var
        i, rez : LongInt;
begin
  rez := 0;
  for i := k downto 1 do
    rez := rez * l + Ord(s[i]) - Ord('A');
  StrToNumber := rez;
end;

Function NumberToStr(a : LongInt) : TString;
var
        rez : TString;
        i : LongInt;
begin
  rez := '';
  for i := 1 to k do
  begin
    rez := rez + Chr(Ord('A') + a mod l);
    a := a div l;
  end;
  NumberToStr := rez;
end;

Function Change(a : TString; const ll, rr : LongInt; const I : Boolean) : TString;
var
        c : LongInt;
begin
  for c := ll to rr do
    if I then
    begin
      if Ord(a[c]) - Ord('A') = l - 1 then
        a[c] := 'A'
      else
        a[c] := Chr(Ord(a[c]) + 1);
    end
    else
    begin
      if a[c] = 'A' then
        a[c] := Chr(Ord('A') + l - 1)
      else
        a[c] := Chr(Ord(a[c]) - 1);
    end;
  Change := a;
end;

Function Good(const a, b : TString) : Boolean;
var
        l1, r1, l2, r2 : LongInt;
        c1, c2 : TString;
begin
  for l1 := 1 to k do
    for r1 := l1 to k do
    begin
      c1 := Change(a, l1, r1, True);
      c2 := Change(a, l1, r1, False);
      if (c1 = b) or (c2 = b) then
      begin
        Good := False;
        Exit;
      end
      else
      begin
        for l2 := l1 to k do
          for r2 := l2 to k do
            if (Change(c1, l2, r2, False) = b) or (Change(c1, l2, r2, True) = b) or (Change(c2, l2, r2, False) = b) or (Change(c2, l2, r2, True) = b) then
            begin
              Good := False;
              Exit;
            end;
      end;
    end;
  Good := True;
end;

var
        nnow, rez : Array[0 .. MaxW] of LongInt;

Function AC(const tek : LongInt; const w : LongInt) : Boolean;
var
        i : LongInt;
begin
  for i := 1 to w do
    if not sm[tek][nnow[i]] then
    begin
      AC := False;
      Exit;
    end;
  AC := True;
end;

Procedure DFS(tek : LongInt; const w : LongInt);
begin
  if w <= 15 then
  begin
    if _end < now then
      Exit;
  end;
  if rez[0] < nnow[0] then
  begin
    rez := nnow;
    WriteLn(rez[0]);
  end;
  if w = 1 then
  begin
    for tek := 0 to 0 do
      if NumberToStr(tek)[1] = 'A' then
      begin
        Inc(nnow[0]);
        nnow[nnow[0]] := tek;
        DFS(tek + 1, w + 1);
        Dec(nnow[0]);
      end;
  end
  else
  begin
    While tek <= MaxMax do
    begin
      if AC(tek, w - 1) then
      begin
        Inc(nnow[0]);
        nnow[nnow[0]] := tek;
        DFS(tek + 1, w + 1);
        Dec(nnow[0]);
      end;
      Inc(tek);
    end;
  end;
end;


Procedure Solve;
var
        i, a, b, j : LongInt;
begin
  i := 1;
  rez[0] := -10;
  for j := 1 to k do
    i := i * l;
  maxmax := i - 1;
  for a := 0 to i - 1 do
    for b := 0 to i - 1 do
      if a < b then
        sm[a][b] := Good(NumberToStr(a), NumberToStr(b))
      else
        sm[a][b] := sm[b][a];

  WriteLn('PREPARING: DONE');
  _end := now + 60 / 60 / 60 / 24;
  DFS(0, 1);

  WriteLn('DONE');
end;

Procedure Print;
var
        i : LongInt;
begin
  WriteLn(rez[0]);
  for i := 1 to rez[0] do
    WriteLn(NumberToStr(rez[i]));
end;

Procedure CheatInit;
var
        i : LongInt;
begin
  Assign(input, 'WORDS/S.TXT');
  Reset(input);
  for i := 1 to MaxTest do
    ReadLn(score[i]);
  Close(input);
end;

begin
  CheatInit;
  for sscore := 6 to MaxScore do
  if sscore <> 5 then
  for test := 1 to 46 do
  if score[test] = sscore then
  begin
    Str(test, ttt);
    if Length(ttt) = 1 then
      ttt := '0' + ttt;

    Assign(output, 'CON');
    Rewrite(output);
    WriteLn;
    WriteLn('TEST No ', test);

    Assign(input, 'WORDS/' + ttt);
    Reset(input);
    Init;
    Solve;
    Close(output);
    Assign(output, 'WORDS/' + ttt + '.out');
    Rewrite(output);
    Print;
    Close(input);
    Close(output);
  end;
end.