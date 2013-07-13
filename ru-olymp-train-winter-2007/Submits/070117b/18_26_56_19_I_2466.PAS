program taski;

{$MODE DELPHI}

const
  MAXN = 250000;

type
  TArr = array [0..MAXN] of Integer;

var
  n, i, l, r, x, imax, ansn, tmp: Integer;
  a, b, f, ans: TArr;

begin
  Assign(input, 'subseq.in');
  Assign(output, 'subseq.out');
  Reset(input); Rewrite(output);

  Read(n);
  for i := 1 to n do
    Read(a[n-i+1]);

  ansn := 1;
  f[1] := 1;
  b[1] := a[1];
  for i := 2 to n do
    begin
      if a[i] >= b[ansn] then
        begin
          inc(ansn);
          b[ansn] := a[i];
          f[i] := ansn;
          continue;
        end;
      l := 1; r := ansn;
      while l < r do
        begin
          x := (l + r) div 2;
          if b[x] < a[i] then
            l := x+1
          else
            r := x;
        end;
      if a[i] = b[l] then
        inc(l);
      f[i] := l;
      b[l] := a[i];
    end;

  imax := 1;
  for i := 2 to n do
    if f[i] > f[imax] then
      imax := i;

  f[0] := 0;
  for i := ansn downto 1 do
    begin
      ans[i] := imax;
      tmp := f[imax]-1;
      repeat
        dec(imax)
      until f[imax] = tmp;
    end;

  WriteLn(ansn);
  for i := ansn downto 1 do
    WriteLn(n-ans[i]+1);

  Close(input);
  Close(output);
end.
