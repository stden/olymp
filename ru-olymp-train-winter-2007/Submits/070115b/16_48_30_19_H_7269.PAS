program taskh;

type
  Integer = Longint;

var
  i, n, j, k, tmp: Integer;
  p: array [0..50000] of Integer;

procedure sort(l, r: Integer);
var
  i, j, x, tmp: Integer;
begin
  i := l; j := r;
  x := p[l + Random(r-l+1)];
  while i <= j do
    begin
      while p[i] < x do inc(i);
      while x < p[j] do dec(j);
      if i <= j then
        begin
          tmp := p[i]; p[i] := p[j]; p[j] := tmp;
          inc(i); dec(j);
        end;
    end;
  if l < j then sort(l, j);
  if i < r then sort(i, r);
end;

begin
  Assign(input, 'nextperm.in');
  Assign(output, 'nextperm.out');
  Reset(input); Rewrite(output);
  RandSeed := 158308;

  Read(n);
  for i := 1 to n do
    Read(p[i]);

  i := n-1;
  while (i > 0) and (p[i] > p[i+1]) do
    dec(i);

  if i = 0 then
    WriteLn('IMPOSSIBLE')
  else
    begin
      k := 0;
      for j := i+1 to n do
        if (p[j] > p[i]) and ((k = 0) or (p[j] < p[k])) then
          k := j;
      tmp := p[i]; p[i] := p[k]; p[k] := tmp;
      sort(i+1, n);
      for i := 1 to n do
        Write(p[i], ' ');
    end;

  Close(input);
  Close(output);
end.
