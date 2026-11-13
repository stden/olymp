var
  last, cur, min, max : double;
  i, n : integer;
  s : string;

begin
  reset(input, 'triangle.in');
  rewrite(output, 'triangle.out');
  read(n);
  min := 30;
  max := 4000;
  read(last);
  for i := 1 to n - 1 do begin
    read(cur, s);
    if (' closer' = s) then begin
      if (cur > last) and (min < (last + cur) / 2) then begin
        min := (last + cur) / 2;
      end;
      if (cur < last) and (max > (last + cur) / 2) then begin
        max := (last + cur) / 2;
      end;
    end else begin
      if (cur < last) and (min < (last + cur) / 2) then begin
        min := (last + cur) / 2;
      end;
      if (cur > last) and (max > (last + cur) / 2) then begin
        max := (last + cur) / 2;
      end;
    end;
    last := cur;
  end;
  writeln(min : 0 : 6, ' ', max : 0 : 6);
end.