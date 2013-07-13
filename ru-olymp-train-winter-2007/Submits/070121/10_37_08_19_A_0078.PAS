program geology;

{$MODE DELPHI}

uses
  Math;

const
  MAXN = 100100;

var
  i, j, n, x, p, l, r: Integer;
  ch: char;
  a: array [0..MAXN] of Int64;
  ans: Int64;

begin
  Assign(input, 'geology.in');
  Assign(output, 'geology.out');
  Reset(input); Rewrite(output);

  ReadLn(n);
  fillchar(a, sizeof(a), 0);
  for i := 1 to n do
    begin
      Read(ch);
      if ch = 'A' then
        begin
          ReadLn(ch, ch, x, p);
          for j := max(x-p+1, 0) to x do
            a[j] := a[j] + (p-x+j)*2 - 1;
          for j := x+1 to min(x+p, n) do
            a[j] := a[j] + (p-j+x+1)*2 - 1;
        end
      else
        begin
          ReadLn(ch, ch, ch, ch, l, r);
          if l > r then
            begin
              x := l; l := r; r := x;
            end;
          ans := 0;
          for j := l+1 to r do
            ans := ans + a[j];
          WriteLn(ans/2:0:3);
        end;
    end;

  Close(input);
  Close(output);
end.