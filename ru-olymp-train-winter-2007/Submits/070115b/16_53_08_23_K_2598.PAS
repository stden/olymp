type
        TT =
        record
          a : Real;
          b : LongInt;
        end;
var
        rr : Array[1 .. 100000] of TT;
        a, b, n, i, tek, max : LongInt;
        x : Real;
        tmp : TT;

Function More(const a, b : TT) : Boolean;
begin
  More := (a.a > b.a) or ((a.a = b.a) and (a.b < b.b));
end;

Procedure QSort(const l, r : LongInt);
var
        i, j : LongInt;
        x : TT;
begin
  i := l;
  j := r;
  x := rr[(l + r) div 2];
  repeat
    While More(x, rr[i]) do
      Inc(i);
    While More(rr[j], x) do
      Dec(j);
    if i <= j then
    begin
      tmp := rr[i];
      rr[i] := rr[j];
      rr[j] := tmp;
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
    rr[i * 3 - 2].a := (a + b) / 2;
    rr[i * 3 - 2].b := 0;
    rr[i * 3 - 1].a := a + 0.4;
    rr[i * 3 - 1].b := 1;
    rr[i * 3].a := b - 0.4;
    rr[i * 3].b := -1;
  end;
  n := n * 3;
  QSort(1, n);
  tek := 0;
  max := -1;
  x := 0;
  for i := 1 to n do
  begin
    Inc(tek, rr[i].b);
    if tek > max then
    begin
      max := tek;
      x := rr[i].a;
    end;
  end;
  WriteLn(max, ' ', x : 0 : 1);
  Close(output);
  Close(input);
end.
