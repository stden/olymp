const
        MaxN = 200;
var
        n, m, prime, rez : LongInt;
        sm : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
        pred : Array[1 .. MaxN] of LongInt;
        getpred : Array[1 .. MaxN, 1 .. MaxN] of LongInt;

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
    ReadLn(a, b);
    sm[a][b] := True;
    sm[b][a] := True;
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

begin
  Assign(input, 'optimum.in');
  Reset(input);
  Assign(output, 'optimum.out');
  Rewrite(output);
  Init;
  DFS(1, -1);
  for prime := 1 to n do
    if pred[prime] = 0 then
      rez := 0;
  WriteLn(rez);
  Close(input);
  Close(output);
end.
