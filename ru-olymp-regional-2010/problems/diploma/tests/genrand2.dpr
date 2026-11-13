uses
  SysUtils;

var
  a, b, w, h, n : integer;
  ans : int64;

function getans(w, h, n : int64) : int64;
var
  l, r, x : int64;
begin
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
  result := r;
end;

begin
  a := strtoint(paramstr(1));
  b := strtoint(paramstr(2));
  randseed := strtoint(paramstr(3));
  w := random(a) + 1;
  h := random(a) + 1;
  n := random(b) + 1;
  ans := getans(w, h, n);
  while (w = h) or (ans > 1e9) do begin
    writeln(erroutput, ans);
    w := random(a) + 1;
    h := random(a) + 1;
    n := random(b) + 1;
    ans := getans(w, h, n);
  end;
  writeln(w, ' ', h, ' ', n);
end.