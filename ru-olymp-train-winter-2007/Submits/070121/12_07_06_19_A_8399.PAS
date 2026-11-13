program geology;

{$MODE DELPHI}

uses
  Math;

const
  MAXN = 100100;

var
  i, j, n, l, r, ll, rr, m: Integer;
  ch: char;
  x, p: array [0..MAXN] of Integer;
  ans: Extended;

begin
  Assign(input, 'geology.in');
  Assign(output, 'geology.out');
  Reset(input); Rewrite(output);

  ReadLn(n);
  m := 0;
  for i := 1 to n do
    begin
      Read(ch);
      if ch = 'A' then
        begin
          inc(m);
          ReadLn(ch, ch, x[m], p[m]);
        end
      else
        begin
          ReadLn(ch, ch, ch, ch, l, r);
          if l > r then
            begin
              j := l; l := r; r := j;
            end;
          ans := 0;
          for j := 1 to m do
            begin 
              ll := max(l, x[j]);
              rr := min(r, x[j]+p[j]);
              if ll < rr then
                ans := ans + p[j] + x[j] - 0.5*(ll + rr);

              ll := max(l, x[j]-p[j]);
              rr := min(r, x[j]);
              if ll < rr then
                ans := ans + p[j] - x[j] + 0.5*(ll + rr);
            end;
          WriteLn(ans:0:3);
        end;
    end;

  Close(input);
  Close(output);
end.