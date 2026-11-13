  {$I-,Q-,R-,S-}
const
        MaxN = 200000;
var
        len : LongInt;
        c : Array[1 .. MaxN] of Char;

Function Zn(const l, r : LongInt) : Int64;
var
        i, g, plus : LongInt;
        rez : Int64;
begin
  g := 0;
  plus := 5;
  for i := l to r - 1 do
  begin
    if c[i] = '(' then
      Inc(g);
    if c[i] = ')' then
      Dec(g);
    if plus > g then
      plus := g;
  end;
  if (c[l] = '(') and (c[r] = ')') and (plus <> 0) then
  begin
    Zn := Zn(l + plus, r - plus);
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
    rez := 0;
    g := 0;
    plus := l;
    for i := l to r do
    begin
      if c[i] = '(' then
        Inc(g);
      if c[i] = ')' then
        Dec(g);
      if ((c[i] = '+') or (c[i] = '-')) and (g = 0) then
      begin
        if c[plus - 1] = '-' then
          rez := (rez - Zn(plus, i - 1) + 1 shl 32) mod (1 shl 32)
        else
          rez := (rez + Zn(plus, i - 1) + 1 shl 32) mod (1 shl 32);
        plus := i + 1;
      end;
    end;
    if c[i] = '+' then
      rez := (rez + Zn(plus, r) + 1 shl 32) mod (1 shl 32)
    else
      rez := (rez - Zn(plus, r) + 1 shl 32) mod (1 shl 32);
    Zn := rez;
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