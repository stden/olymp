program taske; 

{$MODE DELPHI}

const
  MAXN = 10001;

var
  i, j, n, m: Integer;
  s1, s2: string;
  f: array [0..1, 0..MAXN] of Boolean;

begin
  Assign(input, 'patterns.in');
  Assign(output, 'patterns.out');
  Reset(input); Rewrite(output);

  ReadLn(s1); n := Length(s1);
  ReadLn(s2); m := Length(s2);

  fillchar(f, sizeof(f), 0);
  f[0,0] := true;
  for i := 1 to n do
    begin
      fillchar(f[i and 1], sizeof(f[0]), 0);
      for j := 1 to m do
        if s1[i] = '*' then
          f[i and 1,j] := f[1 - i and 1,j-1] or f[i and 1,j-1]
        else
          f[i and 1,j] := ((s1[i] = '?') or (s1[i] = s2[j])) and f[1 - i and 1,j-1];
    end;

  if f[n and 1,m] then
    WriteLn('YES')
  else
    WriteLn('NO');

  Close(input);
  Close(output);
end.