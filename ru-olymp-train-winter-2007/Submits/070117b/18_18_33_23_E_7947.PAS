var
        a, b : Array[1 .. 10000] of Char;
        la, lb : LongInt;
        i, j : LongInt;
        can : Array[0 .. 10001] of Boolean;

begin
  Assign(input, 'patterns.in');
  Reset(input);
  Assign(output, 'patterns.out');
  Rewrite(output);
  la := 0;
  While not EoLn do
  begin
    Inc(la);
    Read(a[la]);
  end;
  ReadLn;
  lb := 0;
  While not EoLn do
  begin
    Inc(lb);
    Read(b[lb]);
  end;
  FillChar(can, SizeOf(can), False);
  can[0] := True;
  for i := 1 to la do
  begin
    if a[i] = '*' then
    begin
      for j := 0 to lb do
        if can[j] then
          can[j + 1] := True;
    end
    else
    begin
      if a[i] = '?' then
      begin
        for j := lb downto 1 do
          can[j] := can[j - 1];
        can[0] := False;
      end
      else
      begin
        for j := lb downto 1 do
          can[j] := (can[j - 1]) and (a[i] = b[j]);
        can[0] := False;
      end;
    end;
  end;
  if can[lb] then
    Write('YES')
  else
    Write('NO');
  Close(input);
  Close(output);
end.