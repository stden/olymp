{$M $1000000000}
const
        MaxL = 310;
        MaxDop = 1e10;
type
        Real = Extended;
var
        k, n, l : LongInt;
        s : Array[1 .. MaxL] of Char;
        p : Array[1 .. MaxL, 0 .. MaxL] of Real;
        pi : Array[1 .. MaxL] of LongInt;

Procedure Init;
begin
  ReadLn(k, n);
  l := 0;
  While not EoLn do
  begin
    Inc(l);
    Read(s[l]);
  end;
end;

Procedure GetP;
var
        i : LongInt;
begin
  pi[1] := 0;
  for i := 2 to l do
  begin
    pi[i] := pi[i - 1];
    While (pi[i] <> 0) and (s[pi[i] + 1] <> s[i]) do
      pi[i] := pi[pi[i]];
    if s[pi[i] + 1] = s[i] then
      Inc(pi[i]);
  end;
end;

Function NOD(a, b : Int64) : Int64;
begin
  While (a <> 0) and (b <> 0) do
    if a > b then
      a := a mod b
    else
      b := b mod a;
  NOD := a + b;
end;

Procedure Sokr(const a : LongInt);
var
        i : LongInt;
        gcd : Real;
begin
{  gcd := Abs(p[a][0]);
  for i := 1 to l + 1 do
    gcd := Nod(gcd, Abs(p[a][i]));
  if gcd = 1 then
    Exit;
  for i := 0 to l + 1 do
    p[a][i] := p[a][i] div gcd;}
  gcd := p[a][a];
  for i := 0 to l + 1 do
    p[a][i] := p[a][i] / gcd;
end;

Procedure Add(const a, b : LongInt; const c1, c2 : Real);
var
        i : LongInt;
        bo : Boolean;
begin
  bo := False;
  for i := 0 to l + 1 do
  begin
    p[a][i] := p[a][i] * c1 - p[b][i] * c2;
    if p[a][i] > MaxDop then
      bo := True;
  end;
  if bo then
    Sokr(a);
end;

Function GetNew(a : LongInt; const c : Char) : LongInt;
begin
  While (a <> 0) and (s[a + 1] <> c) do
    a := pi[a];
  if s[a + 1] = c then
    Inc(a);
  GetNew := a;
end;

Procedure Solve;
var
        i, j, e : LongInt;
        x : Real;
        ch : Char;
        bo : Boolean;
begin
  GetP;
  for i := 1 to l do
  begin
    p[i][i] := p[i][i] + k;
    p[i][0] := p[i][0] - k;
    for j := 1 to k do
    begin
      ch := Char(Ord('a') + j - 1);
      p[i][GetNew(i - 1, ch) + 1] := p[i][GetNew(i - 1, ch) + 1] - 1;
    end;
  end;
  for i := 1 to l do
  begin
    if p[i][i] = 0 then
    begin
      bo := False;
      for j := i + 1 to l do
        if p[j][i] <> 0 then
        begin
          Add(i, j, 1, 1);
          bo := True;
          Break;
        end;
    end;
    if not bo then
      While True do;
    for j := i + 1 to l do
      if p[j][i] <> 0 then
        Add(j, i, p[i][i], p[j][i]);
  end;
  for i := l downto 1 do
    if p[i][i] = 0 then
      While True do
    else
    begin
      for j := i - 1 downto 1 do
        if p[j][i] <> 0 then
          Add(j, i, p[i][i], p[j][i]);
    end;
  x := 0;
  e := pi[l] + 1;
//  Sokr(e);
  Sokr(1);
{  for i := 1 to n - 1 do
    x := -(x * p[e][l + 1] + p[e][0]) / p[e][e];}
  if p[e][e] <> 1 then
    While True do;
  x := -(n - 1) * p[e][0] / p[e][e];
  x := -(x * p[1][l + 1] + p[1][0]) / p[1][1];
  WriteLn(x : 0 : 6);
end;

Function DFS(const g, w, n : LongInt) : Real;
begin
  if g > 30 then
  begin
    DFS := 0;
    Exit;
  end;
  if w = 0 then
    DFS := (DFS(g + 1, 1, n) + DFS(g + 1, 0, n)) / 2 + 1
  else
    if w = 1 then
      DFS := (DFS(g + 1, 2, n) + DFS(g + 1, 0, n)) / 2 + 1
    else
    begin
      if n = 1 then
        DFS := 0
      else
        DFS := DFS(g, 1, n - 1);
    end;
end;

begin
//  WriteLn(DFS(0, 0, 3) : 0 : 6);
  Assign(input, 'wordgame.in');
  Reset(input);
  Assign(output, 'wordgame.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.
