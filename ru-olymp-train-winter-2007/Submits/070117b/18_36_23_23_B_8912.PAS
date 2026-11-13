const
        MaxN = 210;
var
        c : Array[1 .. MaxN] of LongInt;
        can : Array[0 .. MaxN, 0 .. MaxN, 0 .. MaxN] of Boolean;
        s : LongInt;
        n, a, b, i, rmin, ai, bi, ci : LongInt;
        rez : Array[1 .. MaxN] of LongInt;

Procedure Get(const a, b, n : LongInt);
begin
  if n = 0 then
    Exit;
  if (a >= c[n]) and (can[n - 1][a - c[n]][b]) then
  begin
    rez[n] := 1;
    Get(a - c[n], b, n - 1);
  end
  else
  begin
    if (b >= c[n]) and (can[n - 1][a][b - c[n]]) then
    begin
      rez[n] := 2;
      Get(a, b - c[n], n - 1);
    end
    else
    begin
      rez[n] := 3;
      Get(a, b, n - 1);
    end;
  end;
end;

begin
  Assign(input, 'change.in');
  Reset(input);
  Assign(output, 'change.out');
  Rewrite(output);
  ReadLn(n);
  FillChar(can, SizeOf(can), False);
  can[0][0][0] := True;
  for i := 1 to n do
  begin
    Read(c[i]);
    Inc(s, c[i]);
    for a := 0 to MaxN do
      for b := 0 to MaxN do
        if can[i - 1][a][b] then
        begin
          can[i][a + c[i]][b] := True;
          can[i][a][b + c[i]] := True;
          can[i][a][b] := True;
        end;
  end;
  rmin := 1000000000;
  ai := 0;
  bi := 0;
  ci := 0;
  for a := 0 to MaxN do
    for b := 0 to MaxN do
      if can[n][a][b] then
      begin
        if Sqr(3 * a - s) + Sqr(3 * b - s) + Sqr(3 * (s - a - b) - s) < rmin then
        begin
          rmin := Sqr(3 * a - s) + Sqr(3 * b - s) + Sqr(3 * (s - a - b) - s);
          ai := a;
          bi := b;
        end;
      end;
  Get(ai, bi, n);
  for a := 1 to 3 do
  begin
    b := 0;
    for i := 1 to n do
      if rez[i] = a then
        Inc(b);
    Write(b);
    for i := 1 to n do
      if rez[i] = a then
        Write(' ', c[i]);
    WriteLn;
  end;
  Close(input);
  Close(output);
end.