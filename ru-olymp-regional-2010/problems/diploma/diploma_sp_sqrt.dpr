uses
  Math;

const
  maxx = 1e9;

var
  a, b, h, w, ans : int64;
  n : integer;


begin
  reset(input, 'diploma.in');
  rewrite(output, 'diploma.out');
  read(w, h, n);
  assert((1 <= w) and (w <= maxx));
  assert((1 <= h) and (h <= maxx));
  assert((1 <= n) and (n <= maxx));
  a := 1;
  ans := (w + h) * n;
  while ((a - 1) * (a - 1) <= n) do begin
    b := (n + (a - 1)) div a;
    if (max(a * w, b * h) < ans) then begin
      ans := max(a * w, b * h);
    end;
    if (max(a * h, b * w) < ans) then begin
      ans := max(a * h, b * w);
    end;
    a := a + 1;
  end;
  writeln(ans);
end.            