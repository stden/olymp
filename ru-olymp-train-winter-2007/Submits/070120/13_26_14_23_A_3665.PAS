{$I-,Q-,R-,S-}
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
        TRez =
        record
          a : Int64;
          s : TStr;
        end;
var
        bor : Array[0 .. MaxL] of TVert;
        bfs : Array[1 .. MaxL] of LongInt;
        rez, tmp : Array[1 .. MaxL] of TRez;
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

Procedure Max(var a : TRez; const b : TRez; const c : Char);
begin
  if (a.a < b.a)  or ((a.a = b.a) and (a.s > b.s + c)) then
  begin
    a.a := b.a;
    a.s := b.s + c;
  end;
end;

Procedure Solve;
var
        i, j : LongInt;
        R : TRez;
        c : Char;
begin
  CalcPref;
  CalcPer;
  for j := 1 to col do
  begin
    rez[j].a := -Inf;
    rez[j].s := '';
  end;
  rez[1].a := 0;
  rez[1].s := '';
  for i := 0 to n - 1 do
  begin
    tmp := rez;
    for j := 1 to col do
      rez[j].a := -Inf;

    for j := 1 to col do
      if tmp[j].a <> -Inf then
         tmp[j].a := tmp[j].a + bor[j].bonus;
    for j := 1 to col do
      if tmp[j].a <> -Inf then
        for c := 'a' to 'z' do
          Max(rez[bor[j].a[c]], tmp[j], c);
  end;
  for j := 1 to col do
    if rez[j].a <> -Inf then
      rez[j].a := rez[j].a + bor[j].bonus;
  r := rez[1];
  for i := 1 to col do
    if (r.a < rez[i].a) or ((r.a = rez[i].a) and (r.s > rez[i].s)) then
      r := rez[i];
  WriteLn(r.a);
  Write(r.s);
end;

begin
  Assign(input, 'beatuty.in');
  Reset(input);
  Assign(output, 'beatuty.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.