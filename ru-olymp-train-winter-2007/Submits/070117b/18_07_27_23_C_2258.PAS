var
        n, i : LongInt;
        a, b, c : LongInt;
        rez : array[0 .. 11000] of LongInt;

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
  for i := 1 to n do
    rez[i] := 1000000000;
  rez[0] := 0;
  for i := 0 to n - 1 do
  begin
    Read(a, b, c);
    Min(rez[i + 1], rez[i] + a);
    Min(rez[i + 1], rez[i] + b);
    Min(rez[i + 1], rez[i] + c);
    Min(rez[i + 2], rez[i] + b);
    Min(rez[i + 2], rez[i] + c);
    Min(rez[i + 3], rez[i] + c);
  end;
  WriteLn(rez[n]);
  Close(input);
  Close(output);
end.
