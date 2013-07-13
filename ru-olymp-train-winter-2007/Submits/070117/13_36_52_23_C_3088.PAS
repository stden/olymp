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

        pred : Array[0 .. MaxN, 1 .. MaxN] of TMatrix;

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

Procedure Calc;
var
        i, c1, c2 : LongInt;
begin
  for i := 0 to n do
    for c1 := 1 to n do
      for c2 := 1 to n do
        if (sm[c1][c2]) and (d[c1] = i) and (d[c2] = i) then
          pred[i][1][c1][c2] := 1
        else
          pred[i][1][c1][c2] := 0;
  for i := 1 to n do
  begin
    c1 := 2;
    c2 := 2;
    While c1 < 1000000000 do
    begin
      Mul(pred[i][c2 - 1], pred[i][c2 - 1], pred[i][c2]);
      c1 := c1 * 2;
      Inc(c2);
    end;
  end;
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


Procedure Step(const e : LongInt; s : LongInt; var Myrez : TMatrix);
var
        tmp, rez, tt : TMatrix;
        i, qq : LongInt;
begin
  FillChar(rez, SizeOf(rez), 0);
  for i := 1 to n do
    rez[i][i] := 1;
  qq := 1;
  While s <> 0 do
  begin
    if s mod 2 = 1 then
    begin
      Mul(rez, pred[e][qq], tt);
      rez := tt;
    end;
    Inc(qq);
    s := s div 2;
  end;
  MyRez := rez;
end;

Procedure Solve;
var
        i, a, b, c1, c2 : LongInt;
begin
  GetD;
  Calc;
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
    Step(a, b - 1, col);
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
