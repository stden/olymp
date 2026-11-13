const
        MaxN = 2000;
var
        r, c, a, w : Array[1 .. MaxN] of LongInt;
        ans : Array[0 .. 50000] of LongInt;
        n : LongInt;

Procedure Init;
var
        i, j, rez : LongInt;
begin
  ReadLn(n);
  for i := 1 to 10000 do
    ans[i] := 1000000000;
  ans[0] := 0;
  for i := 1 to n do
  begin
    ReadLn(r[i], c[i], a[i], w[i]);
    if r[i] = 1 then
    begin
      for j := 10000 downto 0 do
        if ans[j + a[i]] > ans[j] + w[i] then
          ans[j + a[i]] := ans[j] + w[i];
    end;
  end;
  rez := w[1];
  for i := c[1] to 10000 do
    if ans[i] < rez then
      rez := ans[i];
  WriteLn(rez);
end;

begin
  Assign(input, 'system.in');
  Reset(input);
  Assign(output, 'system.out');
  Rewrite(output);
  Init;
  Close(input);
  Close(output);
end.