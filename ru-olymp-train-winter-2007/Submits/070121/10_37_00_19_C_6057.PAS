program tri;

{$MODE DELPHI}

const
  MAXN = 270000;

var
  n, i, k, newk: Integer;
  x, y, next, prev: array [0..MAXN] of Integer;

begin
  Assign(input, 'tri.in');
  Assign(output, 'tri.out');
  Reset(input); Rewrite(output);

  Read(n);
  for i := 1 to n do
    Read(x[i], y[i]);

  for i := 1 to n-1 do
    next[i] := i+1;
  next[n] := 1;
  prev[1] := n;
  for i := 2 to n do
    prev[i] := i-1;

  k := 1;
  for i := 2 to n do
    if x[i] < x[k] then
      k := i;

  for i := 1 to n-2 do
    begin
      WriteLn(prev[k], ' ', k, ' ', next[k]);
      if x[prev[k]] < x[next[k]] then
        newk := prev[k]
      else
        newk := next[k];
      next[prev[k]] := next[k];
      prev[next[k]] := prev[k];
      k := newk;
    end;

  Close(input);
  Close(output);
end.