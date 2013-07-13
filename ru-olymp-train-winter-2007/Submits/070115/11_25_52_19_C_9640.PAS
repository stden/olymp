program bit; 

{$H+}

type
  Integer = Longint;

const
  MAXN = 100100;
  u = 0;
  a = 1;
  b = 2;
  c = 3;

var
  T, tt, n, i, k, q: Integer;
  s: String;
  f, g: array [-5..MAXN, 0..3] of Boolean;
  ans: Boolean;

function num(ch: char): Integer;
begin
  case ch of
    'a': num := a;
    'b': num := b;
    'c': num := c;
    else num := u;
  end;
end;

begin
  Assign(input, 'bit.in');
  Assign(output, 'bit.out');
  Reset(input); Rewrite(output);

  ReadLn(T);
  for tt := 1 to T do
    begin
      ReadLn(n);
      ReadLn(s);

      fillchar(f, sizeof(f), 0);
      f[1,u] := true;
      for i := 1 to n do
        begin
          f[i+1,u] := f[i+1,u] or f[i,num(s[i])];
          if f[i,u] then
            for k := 1 to 3 do
              if k <> num(s[i]) then
                f[i+1,k] := true;
          for k := 1 to 3 do
            for q := 1 to 3 do
              if (k <> num(s[i])) and (q <> num(s[i])) and (k <> q) then
                f[i+1,k] := f[i+1,k] or f[i,q];
        end;

      fillchar(g, sizeof(g), 0);
      g[n,u] := true;
      for i := n downto 1 do
        begin
          g[i-1,u] := g[i-1,u] or g[i,num(s[i])];
          if g[i,u] then
            for k := 1 to 3 do
              if k <> num(s[i]) then
                g[i-1,k] := true;
          for k := 1 to 3 do
            for q := 1 to 3 do
              if (k <> num(s[i])) and (q <> num(s[i])) and (k <> q) then
                g[i-1,k] := g[i-1,k] or g[i,q];
        end;

      ans := false;
      for i := 0 to n do
        if f[i+1,u] and g[i,u] then
          ans := true;
      if ans then
        WriteLn('YES')
      else
        WriteLn('NO');
    end;

  Close(input);
  Close(output);
end.