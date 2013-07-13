uses
        SysUtils;
var
        n, m : LongInt;

Function Max(const a, b : LongInt) : LongInt;
begin
  if a > b then
    Max := a
  else
    Max := b;
end;

Function Min(const a, b : LongInt) : LongInt;
begin
  if a < b then
    Min := a
  else
    Min := b;
end;

Function Intersect(const x1, y1, x2, y2, x3, y3, x4, y4 : LongInt) : Boolean;
begin
  Intersect := (Max(x1, x3) <= Min(x2, x4)) and (Max(y1, y3) <= Min(y2, y4));
end;

var
        x, y : Array[1 .. 8] of LongInt;

Procedure GenNext(var x, y : LongInt);
begin
  if x = n then
  begin
    x := 0;
    Inc(y);
  end
  else
    Inc(x);
end;

Function IsIn(const g : LongInt) : Boolean;
var
        i : LongInt;
begin
  i := 1;
  While i < g do
  begin
    if (x[g] >= x[i]) and (x[g] <= x[i + 1]) and (y[g] >= y[i]) and (y[g] <= y[i + 1]) then
    begin
      IsIn := True;
      Exit;
    end;
    Inc(i, 2);
  end;
  IsIn := False;
end;

Function Cool(const g : LongInt) : Boolean;
var
        i : LongInt;
begin
  i := 1;
  While i < g do
  begin
    if Intersect(x[i], y[i], x[i + 1], y[i + 1], x[g], y[g], x[g + 1], y[g + 1]) then
    begin
      Cool := False;
      Exit;
    end;
    Inc(i, 2);
  end;
  Cool := True;
end;

var
        col : Int64;
        q, a : LongInt;

Procedure DFS(const g : LongInt);
var
        i, j : LongInt;
begin
  GenNext(x[g], y[g]);
  While y[g] <= m do
  begin
    if not IsIn(g) then
    begin
      for i := x[g] to n do
        for j := y[g] to m do
        begin
          x[g + 1] := i;
          y[g + 1] := j;
          if Cool(g) then
            if g <> 7 then
            begin
            x[g + 2] := x[g];
            y[g + 2] := y[g];
            DFS(g + 2);
            end
            else
            begin
              q := 1;
              for a := 1 to 4 do
              begin
                if (x[a * 2 - 1] <> x[a * 2])  then
                  q := q * 2;
                if (y[a * 2 - 1] <> y[a * 2]) then
                  q := q * 2;
              end;
              Inc(col, q);
            end;
        end;
    end;
    GenNext(x[g], y[g]);
  end;
end;

Procedure Swap(var a, b : LongInt);
var
        c : LongInt;
begin
  c := a;
  a := b;
  b := c;
end;


Function Rand : Boolean;
var
        i, j : LongInt;
begin
  for i := 1 to 8 do
  begin
    x[i] := Random(n + 1);
    y[i] := Random(m + 1);
  end;
  if x[1] > x[2] then
    Swap(x[1], x[2]);
  if y[1] > y[2] then
    Swap(y[1], y[2]);
  if x[3] > x[4] then
    Swap(x[3], x[4]);
  if y[3] > y[4] then
    Swap(y[3], y[4]);
  if x[5] > x[6] then
    Swap(x[5], x[6]);
  if y[5] > y[6] then
    Swap(y[5], y[6]);
  if x[7] > x[8] then
    Swap(x[7], x[8]);
  if y[7] > y[8] then
    Swap(y[7], y[8]);
  for i := 1 to 4 do
    for j := i + 1 to 4 do
      if Intersect(x[i * 2 - 1], y[i * 2 - 1], x[i * 2], y[i * 2], x[j * 2 - 1], y[j * 2 - 1], x[j * 2], y[j * 2]) then
      begin
        Rand := False;
        Exit;
      end;
  Rand := True;
end;

Procedure RandSolve;
var
        all, good, i : LongInt;
        _end : Real;
begin
  all := 0;
  good := 0;
  _end := now + 1.9 / 60 / 60 / 24;
  While _end > now do
  begin
    Inc(all);
    if Rand then
      Inc(good);
  end;
  WriteLn(good / all : 0 : 8);
end;

begin
  Assign(input, 'heritage.in');
  Reset(input);
  Assign(output, 'heritage.out');
  Rewrite(output);
  Read(n, m);
  x[1] := -1;
  y[1] := 0;
  if (n + 1) * (m + 1) < 20 then
  begin
    DFS(1);
    WriteLn(col * 1 * 2 * 3 * 4 / (n + 1) / (m + 1) / (n + 1) / (m + 1) / (n + 1) / (m + 1) / (n + 1) / (m + 1) / (n + 1) / (m + 1) / (n + 1) / (m + 1) / (n + 1) / (m + 1) / (n + 1) / (m + 1) : 0 : 8);
  end
  else
  RandSolve;
  Close(input);
  Close(output);
end.
