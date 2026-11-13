const
        MaxN = 200000;
var
        len : LongInt;
        c : Array[1 .. MaxN] of Char;

Function Zn(const l, r : LongInt) : Int64;
var
        i, g, plus : LongInt;
begin
  plus := 0;
  for i := l + 1 to r - 1 do
    if (c[i] = '(') or (c[i] = ')') then
      plus := i;
  if (c[l] = '(') and (c[r] = ')') and (plus = 0) then
  begin
    Zn := Zn(l + 1, r - 1);
    Exit;
  end;
  g := 0;
  plus := 0;
  for i := l to r do
  begin
    if c[i] = '(' then
      Inc(g);
    if c[i] = ')' then
      Dec(g);
    if ((c[i] = '+') or (c[i] = '-')) and (g = 0) then
      plus := i;
  end;
  if plus <> 0 then
  begin
    if c[plus] = '+' then
      Zn := (Zn(l, plus - 1) + Zn(plus + 1, r) + 1 shl 32) mod (1 shl 32)
    else
      Zn := (Zn(l, plus - 1) - Zn(plus + 1, r) + 1 shl 32) mod (1 shl 32);
  end
  else
  begin
    for i := l to r do
    begin
      if c[i] = '(' then
        Inc(g);
      if c[i] = ')' then
        Dec(g);
      if (c[i] = '*') and (g = 0) then
        plus := i;
    end;
    if plus <> 0 then
      Zn := (Zn(l, plus - 1) * Zn(plus + 1, r) + 1 shl 32) mod (1 shl 32)
    else
    begin
      plus := 0;
      for i := l to r do
        plus := plus * 10 + Ord(c[i]) - Ord('0');
      Zn := (plus + 1 shl 32) mod (1 shl 32);
    end;
  end;
end;

begin
  Assign(input, 'expr.in');
  Reset(input);
  Assign(output, 'expr.out');
  Rewrite(output);
  While not SeekEoLn do
  begin
    Inc(len);
    Read(c[len]);
  end;
  WriteLn(Zn(1, len));
  Close(output);
  Close(input);
end.
