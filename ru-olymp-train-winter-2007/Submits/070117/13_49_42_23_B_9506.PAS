const
        MaxN = 500;
var
        n, m, u : LongInt;
        a : Array[1 .. MaxN, 1 .. MaxN] of LongInt;
        b : Array[1 .. MaxN] of LongInt;
        x : Array[1 .. MaxN] of LongInt;

Procedure Init;
var
        i, j : LongInt;
begin
  ReadLn(m, n);
  for i := 1 to m do
    for j := 1 to n do
      Read(a[i][j]);
  for i := 1 to m do
    Read(b[i]);
end;

Procedure Sub(const f, w, c1, c2 : LongInt);
var
        i : LongInt;
begin
  for i := 1 to n do
    a[f][i] := a[f][i] * c1 - a[w][i] * c2;
  b[f] := b[f] * c1 - b[w] * c2;
end;

Procedure Solve;
var
        i, j : LongInt;
        ccc : Boolean;
begin
  for i := 1 to n do
  begin
    if a[i][i] = 0 then
    begin
      ccc := False;
      for j := i + 1 to n do
        if a[j][i] <> 0 then
        begin
          Sub(i, j, 1, 1);
          ccc := True;
          Break;
        end;
    end
    else
      ccc := True;
    if ccc then
    begin
      for j := i + 1 to n do
        if a[j][i] <> 0 then
          Sub(j, i, a[i][i], a[j][i]);
    end;
  end;
  for i := n downto 1 do
    if a[i][i] <> 0 then
      for j := i - 1 downto 1 do
        if a[j][i] <> 0 then
          Sub(j, i, a[i][i], a[j][i]);

end;

Procedure No;
begin
  WriteLn(-1);
  Close(output);
  Close(input);
  Halt;
end;

Procedure Print;
var
        i, j, r : LongInt;
begin
  for i := 1 to n do
    if i > m then
      x[i] := 0
    else
    begin
      if a[i][i] = 0 then
      begin
        if b[i] = 0 then
          x[i] := 0
        else
          No;
      end
      else
        x[i] := b[i] div a[i][i];
    end;
  for i := 1 to m do
  begin
    r := 0;
    for j := 1 to n do
      Inc(r, a[i][j] * x[j]);
    if r <> b[i] then
      No;
  end;
  r := 0;
  for j := 1 to n do
  begin
    Read(i);
    Inc(r, x[j] * i);
  end;
  for i := 1 to n do
    if x[i] < 0 then
      No;
  WriteLn(r);
  for i := 1 to n do
    Write(x[i], ' ');
end;

begin
  Assign(input, 'radio.in');
  Reset(input);
  Assign(output, 'radio.out');
  Rewrite(output);
  Init;
  Solve;
  Print;
  Close(input);
  Close(output);
end.
