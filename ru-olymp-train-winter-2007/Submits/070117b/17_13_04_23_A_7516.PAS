const
        MaxN = 44;
var
        a, b, c : Array[0 .. MaxN] of Int64;
        n, i : LongInt;
begin
  Assign(input, 'badsubstr.in');
  Reset(input);
  Assign(output, 'badsubstr.out');
  Rewrite(output);
  a[1] := 1;
  b[1] := 1;
  c[1] := 1;
  a[0] := 1;
  b[0] := 0;
  c[0] := 0;
  ReadLn(n);
  for i := 2 to n do
  begin
    a[i] := a[i - 1] + b[i - 1] + c[i - 1];
    b[i] := b[i - 1] + c[i - 1];
    c[i] := a[i - 1] + b[i - 1] + c[i - 1];
  end;
  WriteLn(a[n] + b[n] + c[n]);
  Close(input);
  Close(output);
end.