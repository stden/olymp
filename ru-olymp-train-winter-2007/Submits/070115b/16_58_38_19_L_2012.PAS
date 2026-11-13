program taskl; 

{$H+}

type
  Integer = Longint;

const
  MAXN = 210000;

var
  s: string;
  p: array [0..MAXN] of Integer;
  ch: char;
  i, k, t, n: Integer;
  f: Boolean;

begin
  Assign(input, 'substr.in');
  Assign(output, 'substr.out');
  Reset(input); Rewrite(output);

  s := '';
  f := true;
  n := 0;
  while not eof do
    begin
      Read(ch);
      if f and (ch = '*') then
        begin
          s := s + '$';
          t := n;
          inc(n);
        end
      else
        if ch in [#33..#126] then
          begin
            inc(n);
            s := s + ch;
          end;
    end;

  p[1] := 0;
  for i := 2 to n do
    begin
      k := p[i-1];
      while (k > 0) and (s[k+1] <> s[i]) do
        k := p[k];
      if s[k+1] = s[i] then
        inc(k);
      p[i] := k;
      if k = t then
        WriteLn(i - 2*t);
    end;

  Close(input);
  Close(output);
end.