var
        t, i, n, j, mmax, tmp : LongInt;
        a : Array[0 .. 50000] of LongInt;

Procedure QSort(const l, r : LongInt);
var
        i, j, x : LongInt;
begin
  i := l;
  j := r;
  x := a[(l + r) div 2];
  repeat
    While a[i] < x do
      Inc(i);
    While a[j] > x do
      Dec(j);
    if i <= j then
    begin
      tmp := a[i];
      a[i] := a[j];
      a[j] := tmp;
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
  a[0] := 0;
  Assign(input, 'nextperm.in');
  Reset(input);
  Assign(output, 'nextperm.out');
  Rewrite(output);
  Read(n);
  for i := 1 to n do
    Read(a[i]);
  i := n;
  While a[i - 1] > a[i] do
    Dec(i);
  if i = 1 then
    Write('IMPOSSIBLE')
  else
  begin
    mmax := i;
    for j := i to n do
      if a[j] > a[i - 1] then
        if a[mmax] > a[j] then
          mmax := j;
    t := a[mmax];
    a[mmax] := a[i - 1];
    a[i - 1] := t;
    QSort(i, n);
    for i := 1 to n do
      Write(a[i], ' ');
  end;
  Close(output);
  Close(input);
end.
