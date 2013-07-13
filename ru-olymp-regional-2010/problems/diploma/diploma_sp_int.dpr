const
  max = 1000000000;

var
  w, h, l, r, x : integer;
  n : integer;

begin
  reset(input, 'diploma.in');
  rewrite(output, 'diploma.out');
  read(w, h, n);
  assert((1 <= w) and (w <= max));
  assert((1 <= h) and (h <= max));
  assert((1 <= n) and (n <= max));
  l := 0;
  r := 1;
  while ((r div w) * (r div h) < n) do begin
    r := r * 2;
  end;
  while (r - l > 1) do begin
//    writeln(r, ' ', l, ' ', x);
    x := (r + l) div 2;
    if ((x div w) * (x div h) >= n) then begin
      r := x;
    end else begin
      l := x;
    end;
  end;
  writeln(r);
end.            