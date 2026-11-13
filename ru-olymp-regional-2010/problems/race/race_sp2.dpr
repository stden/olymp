var
  n, m, ans, sum, t, i, j : integer;
  name, ansname : string;

begin
  reset(input, 'race.in');
  rewrite(output, 'race.out');
  readln(n, m);
  ans := 0;
  ansname := '';
  for i := 1 to n do begin
    readln(name);
    sum := 0;
    for j := 1 to m do begin
      read(t);
      sum := sum + t;
    end;
    if (ans = 0) or (sum < ans) then begin
      ans := sum;
      ansname := name;
    end;
    readln;
  end;
  writeln(ansname);
end.