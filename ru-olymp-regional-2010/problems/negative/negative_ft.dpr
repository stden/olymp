{$apptype console}
uses
  SysUtils, Math;

const
  MAXH = 100;
  MAXW = 100;

var
  h, w : longint;
  p1, p2 : array[1..100] of string;
  i, j : longint;
  diff : longint;

begin
  reset(input, 'negative.in');
  rewrite(output, 'negative.out');
  readln(h, w);
  assert ((1 <= h) and (h <= MAXH));
  assert ((1 <= w) and (w <= MAXW));
  for i := 1 to h do begin
    readln(p1[i]);
    assert (length(p1[i]) = w);
    for j := 1 to w do begin
      assert((p1[i][j] = 'B') or (p1[i][j] = 'W'));
    end;
  end;
  readln;
  for i := 1 to h do begin
    readln(p2[i]);
    assert (length(p2[i]) = w);
    for j := 1 to w do begin
      assert((p2[i][j] = 'B') or (p2[i][j] = 'W'));
    end;
  end;
  diff := 0;
  for i := 1 to h do begin
    for j := 1 to w do begin
      if (p1[i][j] = p2[i][j]) then begin
        inc(diff);
      end;
    end;
  end;
  writeln(diff);
end.
