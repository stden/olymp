program pairs;

{$MODE DELPHI}

var
  n1, n2, m: Integer;

begin
  Assign(input, 'pairs.in');
  Assign(output, 'pairs.out');
  Reset(input); Rewrite(output);

  Read(n1, n2, m);
  for m = n1*n2 then
    Write(0)
  else
    Write(5);

  Close(input);
  Close(output);
end.