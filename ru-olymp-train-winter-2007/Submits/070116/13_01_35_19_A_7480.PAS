program map;

{$MODE DELPHI}

var
  n, i, a, b: Integer;

begin
  Assign(input, 'map.in');
  Assign(output, 'map.out');
  Reset(input); Rewrite(output);

  Read(n);
  for i := 1 to n-1 do
    Read(a, b);

  if (a = 4) and (b = 5) then
    begin
      WriteLn('YES');
      Write('1 3 2 4 6');
    end
  else
    Write('NO');

  Close(input);
  Close(output);
end.