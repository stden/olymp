program taski; 

uses
  Math;

type
  Integer = Longint;

const
  MAXN = 100;

var
  i, j, n, k: Integer;
  f: array [0..MAXN, 0..MAXN] of Int64;
  num: Int64;

begin
  Assign(input, 'part.in');
  Assign(output, 'part.out');
  Reset(input); Rewrite(output);

  fillchar(f, sizeof(f), 0);
  for i := 1 to MAXN do
    begin
      for j := 1 to i-1 do
        begin
          f[i,j] := 0;
          for k := 1 to min(j, i-j) do
            f[i,j] := f[i,j] + f[i-j,k];
        end;
      f[i,i] := 1;
    end;

  Read(n, num);
  while n + num > 0 do
    begin

      num := num + 1;
      j := n;
      while n > 0 do 
        if num > f[n,j] then
          begin
            num := num - f[n,j];
            dec(j);
          end
        else
          begin
            Write(j, ' ');
            dec(n, j);
          end;

      WriteLn;
      Read(n, num);
    end;

  Close(input);
  Close(output);
end.