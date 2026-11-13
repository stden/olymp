type
        TT =
        record
          a : LongInt;
          b : LongInt;
        end;
var
        rr : Array[1 .. 200000] of TT;
        n, i, tek, max : LongInt;
        a, b : LongInt;
        x : LongInt;
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
    if a < b then
    begin
      rr[i * 2 - 1].a := a;
      rr[i * 2 - 1].b := 1;
      rr[i * 2].a := b;
      rr[i * 2].b := -1;
    end
    else
    begin
      rr[i * 2 - 1].a := b;
      rr[i * 2 - 1].b := 1;
      rr[i * 2].a := a;
      rr[i * 2].b := -1;
    end;
  end;
  n := n * 2;
  QSort(1, n);
  tek := 0;
  max := -1;
  x := 0;
  for i := 1 to n do
  begin
    Inc(tek, rr[i].b);
    if (tek > max) then
    begin
      max := tek;
      x := rr[i].a;
    end;
  end;
  WriteLn(max, ' ', x);
  Close(output);
  Close(input);
end.
