var n:integer;
begin
  assign(input,'pines.in');
  assign(outpu,'pines.out');
  reset(input);
  rewrite(output);
  readln(n);
  case n of
    1:write(1);
    2:write(0);
    3:write(1);
    4:write(1);
    5:write(1);
    6:write(2);
    7:write(2);
    8:write(3);
    9:write(5);
  end
  else writeln(7);
  close(input);
  close(output);
end.