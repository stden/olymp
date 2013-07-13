var
        a, b : Array[1 .. 10000] of Char;
        la, lb : LongInt;
        can, used : Array[1 .. 10001, 1 .. 10001] of Boolean;

Procedure Rez(const x, y : Word);
begin
  if not used[x][y] then
  begin
    used[x][y] := True;
    if (x > la) and (y > lb) then
    begin
      can[x][y] := True;
      Exit;
    end;
    if (x > la) or (y > lb) then
    begin
      can[x][y] := False;
      Exit;
    end;
    if a[x] = '?' then
    begin
      Rez(x + 1, y + 1);
      can[x][y] := can[x + 1][y + 1];
    end
    else
    begin
      if a[x] = '*' then
      begin
        Rez(x + 1, y);
        Rez(x, y + 1);
        can[x][y] := can[x][y + 1] or can[x + 1][y];
      end
      else
      begin
        if a[x] <> b[y] then
          can[x][y] := False
        else
        begin
          Rez(x + 1, y + 1);
          can[x][y] := can[x + 1][y + 1];
        end;
      end;
    end;
  end;
end;

begin
  Assign(input, 'patterns.in');
  Reset(input);
  Assign(output, 'patterns.out');
  Rewrite(output);
  la := 0;
  While not SeekEoLn do
  begin
    Inc(la);
    Read(a[la]);
  end;
  ReadLn;
  lb := 0;
  While not SeekEoLn do
  begin
    Inc(lb);
    Read(b[lb]);
  end;
  Rez(1, 1);
  if can[1][1] then
    Write('YES')
  else
    Write('NO');
  Close(input);
  Close(output);
end.
