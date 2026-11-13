uses
  SysUtils;

var
  a, b, w, h, n : integer;

begin
  a := strtoint(paramstr(1));
  b := strtoint(paramstr(2));
  randseed := strtoint(paramstr(3));
  w := random(a) + 1;
  h := random(a) + 1;
  n := random(b) + 1;
  while (w = h) do begin
    w := random(a) + 1;
    h := random(a) + 1;
  end;
  writeln(w, ' ', h, ' ', n);
end.