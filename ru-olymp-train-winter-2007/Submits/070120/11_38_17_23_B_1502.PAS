  {$I-,Q-,R-,S-}
const
        Inf = 1000000000000000000;
        MaxN = 20;
var
        n, m : LongInt;
        k : Int64;
        sm : Array[1 .. MaxN, 1 .. MaxN] of Int64;
        rez : Array[1 .. MaxN, 1 .. MaxN, 0 .. MaxN * MaxN] of Int64;
        rez2 : Array[1 .. MaxN, 0 .. MaxN * MaxN] of Int64;
        c : Array[1 .. MaxN] of LongInt;

Procedure Relax(var a : Int64; const b : Int64);
begin
  if a < b then
    a := b;
end;

Procedure Init;
var
        i, j, x, a, b, v, before, after, len : LongInt;
        result : Int64;
begin
  ReadLn(n, m, k);
{  for i := 1 to n do
    Read(c[i]);
  for i := 1 to n do
    for j := 1 to n do
      sm[i][j] := -Inf;
  for i := 1 to m do
  begin
    ReadLn(a, b);
    sm[a][b] := c[b];
  end;}
  n := 20;
  k := 100000000000000;
  for i := 1 to n do
    for j := 1 to n do
      sm[i][j] := Random(100);
  for x := 0 to MaxN * MaxN do
    for i := 1 to n do
      for j := 1 to n do
        if (i = j) and (x = 0) then
          rez[i][j][x] := 0
        else
          rez[i][j][x] := -Inf;
  result := 0;
  for x := 1 to MaxN * MaxN do
    for i := 1 to n do
      for j := 1 to n do
        for a := 1 to n do
          if (rez[i][j][x - 1] <> -Inf) and (sm[j][a] <> -Inf) then
            if rez[i][j][x - 1] + sm[j][a] > rez[i][a][x] then
              rez[i][a][x] := rez[i][j][x - 1] + sm[j][a];
  for a := 0 to MaxN * MaxN do
    for v := 1 to n do
    begin
      rez2[v][a] := -Inf;
      for b := 1 to n do
        Relax(rez2[v][a], rez[v][b][a]);
    end;
  for before := 0 to MaxN * MaxN do
    for after := 0 to MaxN * MaxN do
      if before + after <= k then
      for len := 1 to MaxN do
        if (k - before - after) mod len = 0 then
          for v := 1 to n do
            if (rez[1][v][before] <> -Inf) and (rez2[v][after] <> -Inf) and (rez[v][v][len] <> -Inf) then
              Relax(result, rez[1][v][before] + rez2[v][after] + (k - before - after) div len * rez[v][v][len]);
  WriteLn(result + c[1]);
end;

begin
  Assign(input, 'maxsum.in');
  Reset(input);
  Assign(output, 'maxsum.out');
  Rewrite(output);
  Init;
  Close(input);
  Close(output);
end.