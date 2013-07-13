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
  assert((1 <= a) and (a <= b) and (b <= 1000));
  assert((1 <= k) and (k <= maxx));
  na := (a - 1) div k;
  nb := (b - 1) div k;
  if (nb - na >= n) then begin
    max := -1;
    for i := 1 to n do begin
      if (x[i] > max) then begin
        max := x[i];
      end;
    end;
    writeln(max);
    halt;
  end;
  na := na mod n;
  nb := nb mod n;
  if (nb < na) then begin
    nb := nb + n;
  end;
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
  while (1 - nb > 1 - na) do begin
    nb := nb - n;
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