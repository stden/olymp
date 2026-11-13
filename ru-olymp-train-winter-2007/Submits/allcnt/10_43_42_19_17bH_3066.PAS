program taskh;

{$MODE DELPHI}

const
  MAXN = 50;

var
  s: string;
  i, j, d, k, n: Integer;
  f: array [0..MAXN, 0..MAXN] of Integer;
  b: Boolean;

begin
  Assign(input, 'repeat.in');
  Assign(output, 'repeat.out');
  Reset(input); Rewrite(output);

  ReadLn(s);
  n := Length(s);
  if n = 0 then
    begin
      Write(0);
      Close(input); Close(output);
      halt(0);
    end;

  fillchar(f, sizeof(f), $0F);
  f[1,0] := 1;
  f[1,1] := 2;
  for i := 2 to n do
    begin
      for j := 0 to i-1 do
        begin
          f[i,j] := f[i-1,j] + 1;
          if not odd(i-j) then
            begin
              b := true;
              d := (i-j) div 2;
              for k := j+1 to j+d do
                b := b and (s[k] = s[k+d]);
              if b and (f[i,j] > f[j+d,j] + 1) then
                f[i,j] := f[j+d,j] + 1;
            end;
        end;
      k := 0;
      for j := 1 to i-1 do
        if f[i,j] < f[i,k] then
          k := j;
      f[i,i] := f[i,k] + 1;
    end;

  k := 0;
  for j := 1 to i do
    if f[n,j] < f[n,k] then
      k := j;
  Write(f[n,k]);

  Close(input);
  Close(output);
end.
