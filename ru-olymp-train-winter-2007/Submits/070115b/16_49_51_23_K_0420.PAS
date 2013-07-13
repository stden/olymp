var
        l, i, tek, ii : LongInt;
        c : Char;
        a : Array[1 .. 11000] of Char;
        p : Array[1 .. 11000] of Word;
begin
  Assign(input, 'substr.in');
  Reset(input);
  Assign(output, 'substr.out');
  Rewrite(output);
  l := 0;
  Read(c);
  While not (c in [#33 .. #126]) do
    Read(c);
  While c <> '*' do
  begin
    Inc(l);
    a[l] := c;
    Read(c);
    While not (c in [#33 .. #126]) do
      Read(c);
  end;
  p[1] := 0;
  for i := 2 to l do
  begin
    p[i] := p[i - 1];
    While (p[i] <> 0) and (a[p[i] + 1] <> a[i]) do
      p[i] := p[p[i]];
    if a[p[i] + 1] = a[i] then
      Inc(p[i]);
  end;
  tek := 0;
  ii := 1;
  While not EoF do
  begin
    Inc(ii);
    Read(c);
    While not (c in [#33 .. #126]) and (not EoF) do
      Read(c);
    if not (c in [#33 .. #126]) then
      Break;
    While (c <> a[tek + 1]) and (tek <> 0) do
      tek := p[tek];
    if a[tek + 1] = c then
      Inc(tek);
    if tek = l then
    begin
      WriteLn(ii - l);
      tek := p[tek];
    end;
  end;
  Close(output);
  Close(input);
end.
