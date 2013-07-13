  {$I-,Q-,R-,S-}
const
        MaxN = 33;
type
        TMatrix = Array[1 .. MaxN, 1 .. MaxN] of Int64;
var
        n, m, p, s, t : LongInt;
        sm : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
        col : TMatrix;
        rez, tmp : Array[1 .. MaxN] of Int64;
        d : Array[1 .. MaxN] of LongInt;
        res : Int64;

        pred : Array[1 .. MaxN] of TMatrix;

Procedure Calc;
var
        i, c1, c2 : LongInt;
begin
  for i := 1 to n do
    for c1 := 1 to n do
      for c2 := 1 to n do
        if (sm[c1][c2]) and (d[c1] = i) and (d[c2] = i) then
          pred[i][c1][c2] := 1
        else
          pred[i][c1][c2] := 0;
end;

Procedure Init;
var
        i, a, b : LongInt;
begin
  Read(n, m, p);
  for i := 1 to m do
  begin
    Read(a, b);
    sm[a][b] := True;
    sm[b][a] := True;
  end;
  Read(s);
  Read(t);
end;

Procedure GetD;
var
        i, l, r : LongInt;
        bfs : Array[1 .. MaxN] of LongInt;
begin
  d[s] := 1;
  bfs[1] := s;
  l := 1;
  r := 1;
  While l <= r do
  begin
    for i := 1 to n do
      if (sm[bfs[l]][i]) and (d[i] = 0) then
      begin
        Inc(r);
        bfs[r] := i;
        d[i] := d[bfs[l]] + 1;
      end;
    Inc(l);
  end;
  for i := 1 to n do
    Dec(d[i]);
end;

Procedure Mul(const a, b : TMatrix; var c : TMatrix);
var
        i, j, k : LongInt;
begin
  FillChar(c, SizeOf(c), 0);
  for i := 1 to n do
    for j := 1 to n do
      for k := 1 to n do
        c[i][k] := (c[i][k] + a[i][j] * b[j][k]) mod p;
end;

Procedure Step(var c : TMatrix; s : LongInt);
var
        tmp, rez, tt : TMatrix;
        i : LongInt;
begin
  FillChar(rez, SizeOf(rez), 0);
  for i := 1 to n do
    rez[i][i] := 1;
  tmp := c;
  While s <> 0 do
  begin
    if s mod 2 = 1 then
    begin
      Mul(rez, tmp, tt);
      rez := tt;
    end;
    Mul(tmp, tmp, tt);
    tmp := tt;
    s := s div 2;
  end;
  c := rez;
end;

Procedure Solve;
var
        i, a, b, c1, c2 : LongInt;
begin
  GetD;
  Calc;
  for c1 := 1 to n do
    for c2 := c1 + 1 to n do
      if not sm[c1][c2] then
        Exit;
  for i := 1 to t do
  begin
    Read(a, b);
    if i = 1 then
    begin
      for c1 := 1 to n do
        if d[c1] = a then
          rez[c1] := 1 mod p
        else
          rez[c1] := 0;
    end
    else
    begin
      tmp := rez;
      FillChar(rez, SizeOf(rez), 0);
      for c1 := 1 to n do
        for c2 := 1 to n do
          if (sm[c1][c2]) and (d[c2] = a) then
            rez[c2] := (rez[c2] + tmp[c1]) mod p;
    end;
    col := pred[a];
    Step(col, b - 1);
    tmp := rez;
    FillChar(rez, SizeOf(rez), 0);
    for c1 := 1 to n do
      for c2 := 1 to n do
        rez[c2] := (rez[c2] + tmp[c1] * col[c1][c2]) mod p;
  end;
  res := 0;
  for i := 1 to n do
    res := (res + rez[i]) mod p;
  Write(res);
end;

begin
  Assign(input, 'restore.in');
  Reset(input);
  Assign(output, 'restore.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.