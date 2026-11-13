const
        MaxN = 10;
        MaxPos = 10000000;
type
        TCar =
        record
          dir : Char;
          i, j : LongInt;
          t : Char;
        end;
        TPos = Array[1 .. MaxN] of LongInt;
var
        n, l, r : LongInt;
        c : Array[1 .. MaxN] of TCar;

        bfs : Array[1 .. MaxPos] of LongInt;
        used : Array[1 .. MaxPos] of LongInt;

Procedure Init;
var
        i : LongInt;
begin
  ReadLn(n);
  for i := 1 to n do
  begin
    Read(c[i].dir, c[i].i, c[i].j);
    Read(c[i].t);
    While c[i].t = ' ' do
      Read(c[i].t);
    ReadLn;
  end;
end;

Procedure GetPos(var p : TPos);
var
        i : LongInt;
begin
  FillChar(p, SizeOf(p), 0);
  for i := 1 to n do
    if c[i].dir = 'h' then
      p[i] := c[i].j
    else
      p[i] := c[i].i;
end;

Function PosToNum(const p : TPos) : LongInt;
var
        rez, i : LongInt;
begin
  rez := 0;
  for i := n downto 1 do
  begin
    if c[i].t = 'c' then
      rez := rez * 5 + p[i] - 1
    else
      rez := rez * 4 + p[i] - 1;
  end;
  PosToNum := rez;
end;

Procedure NumToPos(num : LongInt; var p : TPos);
var
        i : LongInt;
begin
  for i := 1 to n do
    if c[i].t = 'c' then
    begin
      p[i] := num mod 5 + 1;
      num := num div 5;
    end
    else
    begin
      p[i] := num mod 4 + 1;
      num := num div 4;
    end;
end;

Procedure AddToBFS(const n, dist : LongInt);
begin
  if used[n] = 0 then
  begin
    used[n] := dist;
    Inc(r);
    bfs[r] := n;
  end;
end;

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

Function Cool(const pos : TPos; const b : LongInt) : Boolean;
var
        t : LongInt;
        bmini, bminj, bmaxi, bmaxj, tmini, tmaxi, tminj, tmaxj, xmini, xmaxi, xminj, xmaxj : LongInt;
begin
  Case c[b].dir of
    'h' :
    begin
      bmini := c[b].i;
      bmaxi := c[b].i + 1;
      bminj := pos[b];
      bmaxj := pos[b] + 2;
      if c[b].t = 't' then
        Inc(bmaxj);
    end;
    'v' :
    begin
      bminj := c[b].j;
      bmaxj := c[b].j + 1;
      bmini := pos[b];
      bmaxi := pos[b] + 2;
      if c[b].t = 't' then
        Inc(bmaxi);
    end;
  end;
  for t := 1 to n do
  if t <> b then
  begin
    Case c[t].dir of
      'h' :
      begin
        tmini := c[t].i;
        tmaxi := c[t].i + 1;
        tminj := pos[t];
        tmaxj := pos[t] + 2;
        if c[t].t = 't' then
          Inc(tmaxj);
      end;
      'v' :
      begin
        tminj := c[t].j;
        tmaxj := c[t].j + 1;
        tmini := pos[t];
        tmaxi := pos[t] + 2;
        if c[t].t = 't' then
          Inc(tmaxi);
      end;
    end;
    xmini := Max(bmini, tmini);
    xminj := Max(bminj, tminj);
    xmaxi := Min(bmaxi, tmaxi);
    xmaxj := Min(bmaxj, tmaxj);
    if (xmini < xmaxi) and (xminj < xmaxj) then
    begin
      Cool := False;
      Exit;
    end;
  end;
  Cool := True;
end;

Procedure Solve;
var
        pos : TPos;
        i, j, p1, ideal : LongInt;
begin
  GetPos(pos);
  l := 1;
  r := 0;
  AddToBFS(PosToNum(pos), 1);
  While l <= r do
  begin
    NumToPos(bfs[l], pos);
    if pos[1] = 5 then
    begin
      WriteLn(used[bfs[l]] - 1);
      Exit;
    end;
    for i := 1 to n do
    begin
      p1 := pos[i];
      Inc(pos[i]);
      While (((c[i].t = 'c') and (pos[i] <= 5)) or ((c[i].t = 't') and (pos[i] <= 4))) and (Cool(pos, i)) do
      begin
        AddToBFS(PosToNum(pos), used[bfs[l]] + 1);
        Inc(pos[i]);
      end;
      pos[i] := p1 - 1;
      While (pos[i] >= 1) and (Cool(pos, i)) do
      begin
        AddToBFS(PosToNum(pos), used[bfs[l]] + 1);
        Dec(pos[i]);
      end;
      pos[i] := p1;
    end;
    Inc(l);
  end;
  WriteLn(-1);
end;

Procedure Print;
begin
end;

begin
  Assign(input, 'cars.in');
  Assign(output, 'cars.out');
  Reset(input);
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.
