const
  max = 1e3;

var
  w, h, l, r, x : int64;
  n : integer;

begin
  reset(input, 'diploma.in');
  rewrite(output, 'diploma.out');
  read(w, h, n);
  assert((1 <= w) and (w <= max));
  assert((1 <= h) and (h <= max));
  assert((1 <= n) and (n <= max));
  l := 0;
  r := (w + h) * n + 1;
  while (r - l > 1) do begin
    x := (r + l) div 2;
    if ((x div w) * (x div h) >= n) then begin
      r := x;
    end else begin
      l := x;
    end;
  end;
  writeln(r);
end.            