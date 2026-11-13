const
  MaxN = 4001;
var
  a : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
  rez : Array[1 .. MaxN, 1 .. MaxN] of LongInt;
  used : Array[1 .. MaxN] of Boolean;
  n : LongInt;

Procedure Get3;
var
  i, j : LongInt;
begin
  rez[3][1] := 1;
  for i := 2 to n do
    for j := 2 to n do
      if (i <> j) and (a[1][i]) and (a[i][j]) and (a[j][1]) then
      begin
        rez[3][2] := i;
        rez[3][3] := j;
        used[1] := True;
        used[i] := True;
        used[j] := True;
        Exit;
      end;

end;

Procedure Add(const m : LongInt);
var
  i, j, v : LongInt;
begin
  While True do
  begin
    repeat
      v := Random(n) + 1;
    until not used[v];
    for i := 1 to m do
      if (a[rez[m][i]][v]) and (a[v][rez[m][i mod m + 1]]) then
      begin
        for j := 1 to i do
          rez[m + 1][j] := rez[m][j];
        rez[m + 1][i + 1] := v;
        for j := i + 1 to m do
          rez[m + 1][j + 1] := rez[m][j];
        Exit;
      end;
  end;
end;

Procedure Solve;
var
  i, j : LongInt;
begin
  for i := 1 to n do
  begin
    for j := 1 to n do
      Write(Ord(a[i][j]), ' ');
    WriteLn;
  end;
  Get3;
  for i := 3 to n - 1 do
    Add(i);
end;

var
  mas : Array[1 .. MaxN * MaxN] of Byte;
  col : LongInt;

Procedure Init;
label
    1;
var
  c : Char;
  teki, tekj, i, j : LongInt;
begin
  Assign(input, 'tourism.in');
  Reset(input);
  ReadLn(n);
  While not EoLn do
  begin
    Read(c);
    Inc(col);
    Case c of
      '0' .. '9' : mas[col] := Ord(c) - Ord('0');
      'A' .. 'Z' : mas[col] := 10 + Ord(c) - Ord('A');
      'a' .. 'z' : mas[col] := 36 + Ord(c) - Ord('a');
      '!' : mas[col] := 62;
      '?' : mas[col] := 63;
    end;
  end;
  teki := 1;
  tekj := 2;
  for i := 1 to col do
  for j := 1 to 6 do
  begin
    if mas[i] mod 2 = 1 then
      a[teki][tekj] := True
    else
      a[tekj][teki] := True;
    mas[i] := mas[i] div 2;
    Inc(tekj);
    if tekj > n then
    begin
      Inc(teki);
      tekj := teki + 1;
      if teki > n then
        GoTo 1;
    end;
  end;
  1:
end;

Procedure Print;
var
  i, j, k, t : LongInt;
begin
  ReadLn(k);
  Assign(output, 'tourism.out');
  Rewrite(output);
  for i := 1 to k do
  begin
    Read(t);
    for j := 1 to t do
      Write(rez[t][j] - 1, ' ');
    WriteLn;
  end;
  Close(output);
end;

begin
  Init;
  Solve;
  Print;
  Close(input);
end.
