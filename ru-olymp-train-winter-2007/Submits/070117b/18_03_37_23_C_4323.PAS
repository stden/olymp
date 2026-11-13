var
        n, i : LongInt;
        a, b, c, rez : array[-10 .. 11000] of LongInt;

Procedure Min(var a : LongInt; const b : LongInt);
begin
  if a > b then
    a := b;
end;

begin
  Assign(input, 'linguae.in');
  Reset(input);
  Assign(output, 'linguae.out');
  Rewrite(output);
  ReadLn(n);
  for i := 0 to n - 1 do
    ReadLn(a[i], b[i], c[i]);
  for i := -10 to n + 5 do
    rez[i] := 1000000000;
  rez[0] := 0;
  for i := 0 to n + 2 do
  begin
    Min(rez[i + 1], rez[i] + a[i]);
    Min(rez[i + 1], rez[i - 1] + b[i - 1]);
    Min(rez[i + 1], rez[i - 2] + c[i - 2]);
    Min(rez[i + 2], rez[i] + b[i]);
    Min(rez[i + 2], rez[i - 1] + c[i - 1]);
    Min(rez[i + 3], rez[i] + c[i]);
  end;
  Min(rez[n], rez[n + 1]);
  Min(rez[n], rez[n + 2]);
  WriteLn(rez[n]);
  Close(input);
  Close(output);
end.
