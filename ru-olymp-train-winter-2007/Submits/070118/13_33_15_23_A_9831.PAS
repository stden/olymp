  {$I-,Q-,R-,S-}
const
        MaxN = 15;
        MaxPos = 1 shl MaxN;
type
        Real = Extended;
        TTer = Array[1 .. MaxN] of Boolean;
var
        n : LongInt;
        a : Array[1 .. MaxN, 1 .. MaxN] of LongInt;
        b : Array[1 .. MaxN, 1 .. MaxN] of Real;
        rez : Array[1 .. MaxPos, 1 .. MaxN] of Real;

Procedure Init;
var
        i, j : LongInt;
begin
  ReadLn(n);
  for i := 1 to n do
    for j := 1 to n do
      Read(a[i][j]);
  for i := 1 to n do
    for j := 1 to n do
      Read(b[i][j]);
end;

Function TerToInt(const a : TTer) : LongInt;
var
        i, rez : LongInt;
begin
  rez := 0;
  for i := 1 to n do
    if a[i] then
      rez := rez * 2 + 1
    else
      rez := rez * 2;
  TerToInt := rez;
end;

Function GenNext(var t : TTer) : Boolean;
var
        i : LongInt;
begin
  for i := n downto 1 do
    if t[i] then
      t[i] := False
    else
    begin
      t[i] := True;
      GenNext := True;
      Exit;
    end;
  GenNext := False;
end;

Function GetCol(const t : TTer) : LongInt;
var
        i, rez : LongInt;
begin
  rez := 0;
  for i := 1 to n do
    if t[i] then
      Inc(rez);
  GetCol := rez;
end;

Procedure Solve;
var
        alive, pred, i, j, s : LongInt;
        live : TTer;
        next : Array[1 .. MaxN] of LongInt;
        cpart, vpart : Array[1 .. MaxN] of Real;
        vv, cc : Real;
        qqq : LongInt;
begin
  for alive := 2 to n do
  begin
    FillChar(live, SizeOf(live), False);
    While GenNext(live) do
      if GetCol(live) = alive then
      begin
        pred := n;
        While not live[pred] do
          Dec(pred);
        for i := 1 to n do
          if live[i] then
          begin
            next[pred] := i;
            pred := i;
          end;
        FillChar(cpart, SizeOf(cpart), 0);
        FillChar(vpart, SizeOf(vpart), 0);
        for i := 1 to n do
          if live[i] then
          begin
            cpart[i] := 1;
            s := 0;
            for j := 1 to n do
              if (live[j]) and (i <> j) then
                Inc(s, a[i][j]);
            for j := 1 to n do
              if (live[j]) and (i <> j) then
              begin
                live[j] := False;
                if next[i] <> j then
                  cpart[i] := cpart[i] + rez[TerToInt(live), next[i]] * a[i][j] * b[i][j] / s
                else
                  cpart[i] := cpart[i] + rez[TerToInt(live), next[j]] * a[i][j] * b[i][j] / s;
                live[j] := True;
                vpart[i] := vpart[i] + a[i][j] * (1 - b[i][j]) / s;
              end;
          end;
        pred := 1;
        While not live[pred] do
          Inc(pred);
        for i := n downto 1 do
          if (live[i]) and (next[i] <> pred) then
          begin
            vv := vpart[i] * vpart[next[i]];
            cc := vpart[i] * cpart[next[i]] + cpart[i];
            vpart[i] := vv;
            cpart[i] := cc;
            next[i] := next[next[i]];
          end;
        qqq := TerToInt(live);
        rez[qqq, pred] := cpart[pred] / (1 - vpart[pred]);
        for i := 1 to n do
          if (live[i]) and (i <> pred) then
            rez[qqq, i] := cpart[i] + vpart[i] * rez[qqq, pred];
      end;
  end;
end;

begin
  Assign(input, 'game.in');
  Reset(input);
  Assign(output, 'game.out');
  Rewrite(output);
  Init;
  Solve;
  WriteLn(rez[(1 shl n) - 1][1] : 0 : 5);
  Close(input);
  Close(output);
end.
