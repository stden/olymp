program parenth;

{$MODE DELPHI}

const
  MAXN = 41;

var
  n, i, j: Integer;
  k: Int64;
  f: array [0..MAXN, -1..MAXN] of Int64;
  ans, st: array [0..MAXN] of Integer;

begin
  Assign(input, 'parenth.in');
  Assign(output, 'parenth.out');
  Reset(input); Rewrite(output);

  Read(n, k);
  n := 2*n;
  fillchar(f, sizeof(f), 0);
  f[0,0] := 1;
  for i := 1 to n do
    for j := 0 to n do
      f[i,j] := 2*f[i-1,j-1] + f[i-1,j+1];

  j := 0;
  for i := n downto 1 do
    if k <= f[i-1,j-1] then
      begin
        ans[i] := 0;
        dec(j);
      end
    else
      if k <= 2*f[i-1,j-1] then
        begin
          ans[i] := 1;
          k := k - f[i-1,j-1];
          dec(j);
        end
      else
        begin
          ans[i] := -1;
          k := k - 2*f[i-1,j-1];
          inc(j);
        end;

  j := 0;
  for i := 1 to n do
    if ans[i] = 0 then
      begin
        Write('(');
        inc(j);
        st[j] := 0;
      end
    else
      if ans[i] = 1 then
        begin
          Write('[');
          inc(j);
          st[j] := 1;
        end
      else
        begin
          if st[j] = 0 then
            Write(')')
          else
            Write(']');
          dec(j);
        end;

  Close(input);
  Close(output);
end.
