{$M $1000000000}
const
        MaxN = 210;
        MaxF = 6;
var
        i, t : LongInt;
        n, k : LongInt;
        f : Array[1 .. MaxF, 1.. MaxN] of LongInt;
        now : Array[1 .. MaxN] of LongInt;
        used : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
        list : Array[0 .. MaxN * MaxN] of LongInt;

        bfs : Array[1 .. MaxN * 4] of LongInt;
        u : Array[1 .. MaxN * 4] of Boolean;

Procedure Init;
var
        i, j : LongInt;
begin
  ReadLn(n, k);
  for i := 1 to k do
    for j := 1 to n do
    begin
      Read(f[i][j]);
      Inc(f[i][j]);
    end;
end;

Procedure Prim(const a : LongInt);
var
        i : LongInt;
begin
  for i := 1 to n do
    now[i] := f[a][now[i]];
end;

Function DFS(const a, b : LongInt) : Boolean;
var
        i : LongInt;
begin
  if a = b then
  begin
    DFS := True;
    Exit;
  end;
  if used[a][b] then
  begin
    DFS := False;
    Exit;
  end;
  used[a][b] := True;
  for i := 1 to k do
    if DFS(f[i][a], f[i][b]) then
    begin
      DFS := True;
      Inc(list[0]);
      list[list[0]] := i;
      Exit;
    end;
  DFS := False;
end;

Function Dost : Boolean;
var
        l, r, i, j : LongInt;
begin
  l := 1;
  r := 1;
  bfs[1] := 1;
  FillChar(u, SizeOf(u), False);
  u[1] := True;
  While l <= r do
  begin
    for i := 1 to n do
      for j := 1 to k do
        if f[j][i] = bfs[l] then
          if not u[i] then
          begin
            u[i] := True;
            Inc(r);
            bfs[r] := i;
          end;
    Inc(l);
  end;
  Dost := False;
  for i := 1 to n do
    if not u[i] then
      Exit;
  Dost := True;
end;

Function Merge(const a, b : LongInt) : Boolean;
var
        i : LongInt;
begin
  FillChar(used, SizeOf(used), False);
  list[0] := 0;
  Merge := DFS(now[a], now[b]);
  for i := list[0] downto 1 do
    Prim(list[i]);
end;

Procedure Solve;
var
        i, j : LongInt;
        work : Boolean;
begin
  for i := 1 to n do
    now[i] := i;
  work := True;
  While work do
  begin
    work := False;
    for j := 1 to n do
      if now[1] <> now[j] then
      begin
        work := True;
        if not Merge(1, j) then
        begin
          WriteLn('NO');
          Exit;
        end;
      end;
  end;
  if not Dost then
    WriteLn('NO')
  else
    WriteLn('YES');
end;

begin
  Assign(input, 'bit2.in');
  Assign(output, 'bit2.out');
  Reset(input);
  Rewrite(output);
  ReadLn(t);
  for i := 1 to t do
  begin
    Init;
    Solve;
  end;
  Close(input);
  Close(output);
end.
