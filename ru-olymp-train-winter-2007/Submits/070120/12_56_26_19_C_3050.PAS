program rle;

{$MODE DELPHI}

uses
  Math;

const
  MAXN = 50000;

var
  sc: String;
  i, k, n, m, l, r, xx, gl: Integer;
  s: array [0..MAXN] of Char;
  x, xsum: array [-1..MAXN] of Int64;
  f, g: array [0..MAXN] of Integer;
  q, ans, tmp: Int64;

begin
  Assign(input, 'rle.in');
  Assign(output, 'rle.out');
  Reset(input); Rewrite(output);

  ReadLn(sc);
  i := 1; n := 0;
  while i <= Length(sc) do
    if sc[i] in ['0'..'9'] then
      begin
        k := 0;
        while sc[i] in ['0'..'9'] do
          begin
            k := 10*k + ord(sc[i]) - ord('0');
            inc(i);
          end;
        inc(n);
        s[n] := sc[i];
        x[n] := k;
        inc(i);
      end
    else
      begin
        inc(n);
        s[n] := sc[i];
        x[n] := 1;
        inc(i);
      end;

  m := 1;
  for i := 2 to n do
    if s[i] = s[m] then
      x[m] := x[m] + x[i]
    else
      begin
        inc(m);
        x[m] := x[i];
        s[m] := s[i];
      end;
  n := m;

  f[1] := 0;
  for i := 2 to n do
    begin
      k := f[i-1];
      while (k > 0) and (s[k+1] <> s[i]) do
        k := f[k];
      if (s[k+1] = s[i]) then
        inc(k);
      g[i] := k;

      k := f[i-1];
      while (k > 0) and ((s[k+1] <> s[i]) or (x[k+1] <> x[i])) do
        k := f[k];
      if (s[k+1] = s[i]) and (x[k+1] = x[i]) then
        inc(k);
      f[i] := k;
    end;

  xsum[-1] := 0;
  xsum[0] := 0;
  for i := 1 to n do
    xsum[i] := xsum[i-1] + x[i];

  Read(m);
  for i := 1 to m do
    begin
      Read(q);
      if q <= x[1] then
        begin
          WriteLn(q-1);
          continue;
        end;

      l := 1; r := n;
      while l < r do
        begin
          xx := (l + r) div 2;
          if q <= xsum[xx] then
            r := xx
          else
            l := xx+1;
        end;

      if q = 153 then
        q := q;

      q := q - xsum[l-1];
      tmp := xsum[g[l]-1];
      gl := g[l];
      if (x[1] > tmp) and (l > 2) and (s[1] = s[l-1]) and (s[2] = s[l]) and (x[1] <= x[l-1]) then
        begin
          tmp := x[1];
          gl := 2;
        end;

      if q > x[gl] then
        if s[l] = s[1] then
          ans := x[1]
        else
          ans := 0
      else
        ans := tmp + q;
      WriteLn(ans);
    end;

  Close(input);
  Close(output);
end.
