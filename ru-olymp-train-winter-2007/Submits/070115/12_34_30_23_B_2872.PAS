const
        MaxC = 11000;
var
        a, b : Array[0 .. MaxC] of LongInt;

Procedure LDec(f : LongInt);
begin
  While a[f] = 0 do
  begin
    a[f] := 9;
    Dec(f);
  end;
  Dec(a[f]);
end;

Function Can(const f : LongInt) : Boolean;
var
        i, j, k, t : LongInt;
begin
  i := f;
  j := a[0];
  b := a;
  While i <= j do
  begin
    if i <> 1 then
      t := a[i - 1] * 10 + a[i]
    else
      t := a[i];
    if (a[j] = t mod 10) or (a[j] = (t - 1) mod 10) then
    begin
      if a[j] = (t - 1) mod 10 then
        Dec(t);
      if ((i = 1) and (t = 0)) or ((i = j) and (t mod 2 = 1)) or (t > 18) then
      begin
        a := b;
        Can := False;
        Exit;
      end;
      for k := 1 to t do
      begin
        LDec(i);
        if i <> j then
          LDec(j);
      end;
    end
    else
    begin
      a := b;
      Can := False;
      Exit;
    end;
    Inc(i);
    Dec(j);
  end;
  for i := 1 to a[0] do
    if a[i] <> 0 then
    begin
      a := b;
      Can := False;
      Exit;
    end;
  Can := True;
  a := b;
end;

Function Solve : Boolean;
var
        c : Char;
        i, j : LongInt;
        bo : Boolean;
begin
  a[0] := 0;
  bo := True;
  While not SeekEoLn do
  begin
    Read(c);
    if c <> '0' then
      bo := False;
    if not bo then
    begin
      Inc(a[0]);
      a[a[0]] := Ord(c) - Ord('0');
    end;
  end;
  ReadLn;
  if a[0] = 0 then
  begin
    Close(input);
    Close(output);
    Halt;
  end;
  Solve := Can(1) or Can(2);
end;

begin
  Assign(input, 'reverse.in');
  Assign(output, 'reverse.out');
  Reset(input);
  Rewrite(output);
  While True do
    if Solve then
      WriteLn('YES')
    else
      WriteLn('NO');
  Close(input);
  Close(output);
end.
