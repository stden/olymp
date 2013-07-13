const
  maxn = 100;
  maxx = 1000000000;

var
  n, i, a, b, k, na, nb, max, j : integer;
  x : array[1..maxn] of integer;

begin
  reset(input, 'wheel.in');
  rewrite(output, 'wheel.out');
  read(n);
  assert((3 <= n) and (n <= maxn));
  for i := 1 to n do begin
    read(x[i]);
    assert((0 < x[i]) and (x[i] <= 1000));
  end;
  read(a, b, k);
  assert((1 <= a) and (a <= b) and (b <= maxx));
  assert((1 <= k) and (k <= maxx));
  na := (a - 1) div k;
  nb := (b - 1) div k;
  max := -1;
  for i := na + 1 to nb + 1 do begin
    j := i mod n;
    if (j <= 0) then begin
      j := j + n;
    end;
    if (x[j] > max) then begin
      max := x[j];
    end;
  end;
  for i := 1 - na downto 1 - nb do begin
    j := i mod n;
    if (j <= 0) then begin
      j := j + n;
    end;
    if (x[j] > max) then begin
      max := x[j];
    end;
  end;
  writeln(max);
end.