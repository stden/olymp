program parenth;

{$MODE DELPHI}

const
  MAXN = 41;

var
  n, i, j: Integer;
  k: Int64;
  f: array [0..MAXN, -1..MAXN] of Int64;
  st: array [0..MAXN] of Integer;

begin
  Assign(input, 'parenth.in');
  Assign(output, 'parenth.out');
  Reset(input); Rewrite(output);

//  while not seekeof do begin
  Read(n, k);
  n := 2*n;
  fillchar(f, sizeof(f), 0);
  f[n+1,0] := 1;
  for i := n downto 1 do
    for j := 0 to n do
      f[i,j] := 2*f[i+1,j+1] + f[i+1,j-1];

  j := 0;
  for i := 1 to n do
    if k <= f[i+1,j+1] then
      begin
        Write('(');
        inc(j);
        st[j] := 0;
      end
    else
      if (j > 0) and (st[j] = 0) then
        if k <= f[i+1,j+1] + f[i+1,j-1] then
          begin
            Write(')');
            k := k - f[i+1,j+1];
            dec(j);
          end
        else
          begin
            Write('[');
            k := k - f[i+1,j+1] - f[i+1,j-1];
            inc(j);
            st[j] := 1;
          end
      else
        if k <= 2*f[i+1,j+1] then
          begin
            Write('[');
            k := k - f[i+1,j+1];
            inc(j);
            st[j] := 1;
          end
        else
          begin
            Write(']');
            k := k - 2*f[i+1,j+1];
            dec(j);
          end;

//     writeln;
//  end;
  Close(input);
  Close(output);
end.
