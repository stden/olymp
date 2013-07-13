program maxsum;

{$MODE DELPHI}

const
  MAXN = 20;
  LEN1 = 500;
  LEN2 = 800;

var
  i, j, n, m, u, v, p: Integer;
  a: array [1..MAXN, 1..MAXN] of Boolean;
  c, f, f0: array [1..MAXN] of Int64;
  ans: array [1..LEN2] of Int64;
  k, add, answer: Int64;
  b: Boolean;

begin
  Assign(input, 'maxsum.in');
  Assign(output, 'maxsum.out');
  Reset(input); Rewrite(output);

  Read(n, m, k);
  for i := 1 to n do
    Read(c[i]);

  fillchar(a, sizeof(a), 0);
  for i := 1 to m do
    begin
      Read(u, v);
      a[u,v] := true;
    end;

  fillchar(f, sizeof(f), 0);
  f[1] := c[1];
  for u := 1 to LEN2 do
    begin
      f0 := f;
      for i := 1 to n do
        begin
          f[i] := 0;
          for j := 1 to n do
            if a[j,i] and (f0[j] > f[i]) then
              f[i] := f0[j];
          f[i] := f[i] + c[i];
        end;

      ans[u] := 0;
      for i := 1 to n do
        if ans[u] < f[i] then
          ans[u] := f[i];
    end;

  if k <= LEN2 then
    Write(ans[k])
  else
    begin
      p := 0;
      for i := 1 to LEN2-LEN1 do
        begin
          b := true;
          for j := LEN2-i downto LEN1 do
            b := b and (ans[j] - ans[j-1] = ans[j+i] - ans[j+i-1]);
          if b then
            begin
              p := i;
              break;
            end;
        end;
      //WriteLn(p);
      add := ans[LEN2] - ans[LEN2-p];
      answer := ans[LEN1 + (k-LEN1) mod p] + add * ((k-LEN1) div p);
      Write(answer);
    end;

  Close(input);
  Close(output);
end.