{$I-,Q-,R-,S-}
{uses
        SysUtils;}
const
        MaxL = 10030;
        MaxN = 103;
        Inf = 300000000000;
type
        TStr = String[MaxN];
        TVert =
        record
          pred, pref : Word;
          bonus : Int64;
          ch : Char;
          a : Array['a' .. 'z'] of Word;
        end;
        TRez = Int64;
var
        bor : Array[0 .. MaxL] of TVert;
        bfs : Array[1 .. MaxL] of LongInt;
        rez : Array[0 .. MaxN, 1 .. MaxL] of TRez;
        good : Array[0 .. MaxN, 1 .. MaxL] of Boolean;
        k, n, col : LongInt;

        qqq : Real;

Procedure Init;
var
        i, now : LongInt;
        c : Char;
begin
  ReadLn(k);
  col := 1;
  FillChar(bor, SizeOf(bor), False);
  bor[1].pred := 0;
  bor[1].pref := 0;
  for c := 'a' to 'z' do
    bor[0].a[c] := 1;
  for i := 1 to k do
  begin
    now := 1;
    Read(c);
    While c in ['a' .. 'z'] do
    begin
      if bor[now].a[c] = 0 then
      begin
        Inc(col);
        bor[now].a[c] := col;
        bor[col].pred := now;
        bor[col].ch := c;
      end;
      now := bor[now].a[c];
      Read(c);
    end;
    ReadLn(bor[now].bonus);
  end;
  ReadLn(n);
end;

Procedure CalcPref;
var
        l, r, tek : LongInt;
        c : Char;
begin
  l := 1;
  r := 1;
  bfs[l] := 1;
  While l <= r do
  begin
    if l <> 1 then
    begin
      tek := bor[bor[bfs[l]].pred].pref;
      While bor[tek].a[bor[bfs[l]].ch] = 0 do
        tek := bor[tek].pref;
      tek := bor[tek].a[bor[bfs[l]].ch];
      bor[bfs[l]].pref := tek;
    end;
    for c := 'a' to 'z' do
      if bor[bfs[l]].a[c] <> 0 then
      begin
        Inc(r);
        bfs[r] := bor[bfs[l]].a[c];
      end;
    Inc(l);
  end;
end;

Procedure CalcPer;
var
        l, r, tek : LongInt;
        c : Char;
begin
  l := 1;
  r := 1;
  bfs[l] := 1;
  While l <= r do
  begin
    Inc(bor[bfs[l]].bonus, bor[bor[bfs[l]].pref].bonus);
    for c := 'a' to 'z' do
      if bor[bfs[l]].a[c] = 0 then
      begin
        tek := bfs[l];
        While bor[tek].a[c] = 0 do
          tek := bor[tek].pref;
        bor[bfs[l]].a[c] := bor[tek].a[c];
      end
      else
      begin
        Inc(r);
        bfs[r] := bor[bfs[l]].a[c];
      end;
    Inc(l);
  end;
end;

Procedure Max(var a : TRez; const b : TRez);
begin
  if (a < b){  or ((a.a = b.a) and (a.hesh > b.hesh)) or ((a.a = b.a) and (a.hesh = b.hesh) and (a.s > b.s + c))} then
    a := b;
end;

Procedure Solve;
var
        i, j, tek : LongInt;
        R : TRez;
        c : Char;
begin
  CalcPref;
  CalcPer;
  for i := 0 to n do
    for j := 1 to col do
      rez[i][j] := -Inf;
  rez[0][1] := 0;
  for i := 0 to n - 1 do
  begin
    for j := 1 to col do
      if rez[i][j] <> -Inf then
         rez[i][j] := rez[i][j] + bor[j].bonus;
    for j := 1 to col do
      if rez[i][j] <> -Inf then
        for c := 'a' to 'z' do
          Max(rez[i + 1][bor[j].a[c]], rez[i][j]);
  end;
  for j := 1 to col do
    if rez[n][j] <> -Inf then
      rez[n][j] := rez[n][j] + bor[j].bonus;
  r := rez[n][1];
  for i := 1 to col do
    if (r < rez[n][i]) then
      r := rez[n][i];
  WriteLn(r);
  for i := 1 to col do
    if r = rez[n][i] then
      good[n][i] := True
    else
      good[n][i] := False;
  for i := n - 1 downto 0 do
    for j := 1 to col do
    begin
      good[i][j] := False;
      for c := 'a' to 'z' do
        if (good[i + 1][bor[j].a[c]]) and (rez[i + 1][bor[j].a[c]] = rez[i][j] + bor[bor[j].a[c]].bonus) then
        begin
          good[i][j] := True;
          Break;
        end;
    end;
  tek := 1;
  for i := 0 to n - 1 do
  begin
    for c := 'a' to 'z' do
      if (good[i + 1][bor[tek].a[c]]) and (rez[i + 1][bor[tek].a[c]] = rez[i][tek] + bor[bor[tek].a[c]].bonus) then
      begin
        Write(c);
        tek := bor[tek].a[c];
        Break;
      end;
  end;
end;

begin
{  qqq := now;}
  Assign(input, 'beauty.in');
  Reset(input);
  Assign(output, 'beauty.out');
  Rewrite(output);
  Init;
  Solve;
{  WriteLn;
  WriteLn((now - qqq) * 3600 * 24 : 0 : 3);}
  Close(input);
  Close(output);
end.