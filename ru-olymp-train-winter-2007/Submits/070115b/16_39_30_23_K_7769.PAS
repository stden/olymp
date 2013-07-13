var
        rr : Array[1 .. 100000] of Extended;
        sob : Array[1 .. 100000] of LongInt;
        a, b, n, i, tek, max : LongInt;
        tmp, x : Extended;

Procedure QSort(const l, r : LongInt);
var
        i, j : LongInt;
        x : Extended;
begin
  i := l;
  j := r;
  x := rr[(l + r) div 2];
  repeat
    While rr[i] < x do
      Inc(i);
    While rr[j] > x do
      Dec(j);
    if i <= j then
    begin
      tmp := rr[i];
      rr[i] := rr[j];
      rr[j] := tmp;
      tmp := sob[i];
      sob[i] := sob[j];
      sob[j] := Round(tmp);
      Inc(i);
      Dec(j);
    end;
  until i > j;
  if l < j then
    QSort(l, j);
  if i < r then
    QSort(i, r);
end;

begin
  Assign(input, 'segments.in');
  Reset(input);
  Assign(output, 'segments.out');
  Rewrite(output);
  ReadLn(n);
  for i := 1 to n do
  begin
    Read(a, b);
    rr[i * 2 - 1] := a - 0.001;
    sob[i * 2 - 1] := 1;
    rr[i * 2] := b + 0.001;
    sob[i * 2] := -1;
  end;
  QSort(1, 2 * n);
  tek := 0;
  max := -1;
  x := 0;
  for i := 1 to 2 * n do
  begin
    Inc(tek, sob[i]);
    if tek > max then
    begin
      max := tek;
      x := rr[i];
    end;
  end;
  WriteLn(max, ' ', x : 0 : 0);
  Close(output);
  Close(input);
end.
