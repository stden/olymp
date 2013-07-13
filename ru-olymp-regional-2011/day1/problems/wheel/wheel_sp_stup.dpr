var
  n, i, max, t : integer;

begin
  reset(input, 'wheel.in');
  rewrite(output, 'wheel.out');
  read(n);
  max := -1;
  for i := 1 to n do begin
    read(t);
    if (t > max) then begin
      max := t;
    end;
  end;
  writeln(max);
end.