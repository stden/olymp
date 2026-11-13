program taskc; 

{$MODE DELPHI}

uses
  Math;

const
  MAXN = 10000;

var
  n, i, j: Integer;
  a, b, c, f: array [0..MAXN+5] of Integer;

begin
  Assign(input, 'linguae.in');
  Assign(output, 'linguae.out');
  Reset(input); Rewrite(output);

  Read(n);
  for i := 0 to n-1 do
    begin
      Read(a[i], b[i], c[i]);
      b[i] := min(b[i], c[i]);
      a[i] := min(b[i], a[i]);
    end;

  fillchar(f, sizeof(f), $0F);
  f[0] := 0;
  f[1] := a[0];
  if n > 1 then
    f[2] := min(f[1] + a[1], b[0]);
  for i := 3 to n+2 do
    f[i] := min(min(f[i-1] + a[i-1], f[i-2] + b[i-2]), f[i-3] + b[i-3]);

  WriteLn(min(min(f[n],f[n+1]),f[n+2]));

  Close(input);
  Close(output);
end.