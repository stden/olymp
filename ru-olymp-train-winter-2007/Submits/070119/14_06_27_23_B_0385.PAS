const
        MaxN = 200;
        MaxM = 10000;
type
        TReb =
        record
          a, b : LongInt;
          i : Boolean;
        end;
var
        n, m, prime, rez : LongInt;
        sm : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
        sm2 : Array[1 .. 25, 1 .. 25] of Boolean;
        pred : Array[1 .. MaxN] of LongInt;
        getpred : Array[1 .. MaxN, 1 .. MaxN] of LongInt;
        r : Array[1 .. MaxM] of TReb;

Procedure Init;
var
        a, b, i : LongInt;
begin
  ReadLn(n, m, prime);
  rez := 1;
  for a := 1 to n do
    for b := 1 to n do
      getpred[a][b] := -1;
  for i := 1 to m do
  begin
    ReadLn(r[i].a, r[i].b);
    sm[r[i].a][r[i].b] := True;
    sm[r[i].b][r[i].a] := True;
  end;
end;

Function GetCol(const a, b : LongInt) : LongInt;
begin
  if a = b then
    GetCol := 0
  else
  begin
    if getpred[a][b] = -1 then
      getpred[a][b] := GetCol(pred[a], b) + 1;
    GetCol := getpred[a][b];
  end;
end;

Procedure DFS(const a, p : LongInt);
var
        i : LongInt;
begin
  pred[a] := p;
  for i := 1 to n do
    if sm[a][i] then
    begin
      sm[a][i] := False;
      sm[i][a] := False;
      if pred[i] = 0 then
        DFS(i, a)
      else
      begin
        rez := rez * (GetCol(a, i) + 1);
        if rez >= prime then
          rez := rez mod prime;
      end;
    end;
end;

Procedure Solve;
var
        i, j, k : LongInt;
begin
  for i := 1 to n do
    for j := 1 to n do
      sm2[i][j] := sm[i][j];
  for k := 1 to n do
    for i := 1 to n do
      for j := 1 to n do
        if (sm2[i][k]) and (sm2[k][j]) then
          sm2[i][j] := True;
  for i := 1 to n do
    for j := 1 to n do
      if i <> j then
        if not sm2[i][j] then
          Exit;
  Inc(rez);
  if rez >= prime then
    rez := rez mod prime;
end;

Procedure PDFS(const g, k : LongInt);
begin
  if k >= n then
    Exit;
  if g > m then
  begin
    if k <> n - 1 then
      Exit;
    Solve;
  end
  else
  begin
    sm[r[g].a, r[g].b] := True;
    sm[r[g].b, r[g].a] := True;
    r[g].i := True;
    PDFS(g + 1, k + 1);
    sm[r[g].a, r[g].b] := False;
    sm[r[g].b, r[g].a] := False;
    r[g].i := False;
    PDFS(g + 1, k);
  end;
end;

begin
  Assign(input, 'optimum.in');
  Reset(input);
  Assign(output, 'optimum.out');
  Rewrite(output);
  Init;
  if m > 19 then
  begin
    DFS(1, -1);
    for prime := 1 to n do
      if pred[prime] = 0 then
        rez := 0;
  end
  else
  begin
    rez := 0;
    PDFS(1, 0);
  end;
  WriteLn(rez);
  Close(input);
  Close(output);
end.
