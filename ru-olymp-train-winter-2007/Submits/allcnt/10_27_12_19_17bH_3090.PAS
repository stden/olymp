program taskh;

{$MODE DELPHI}

const
  MAXN = 50;

var
  s: string;
  i, j, d, n: Integer;
  f: array [0..MAXN, #96..'z'] of Integer;
  ch, c: char;
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
  f[1,#96] := 1;
  f[1,s[1]] := 2;
  for i := 2 to n do
    begin
      for ch := #96 to 'z' do
        begin
          f[i,ch] := f[i-1,ch] + 1;
          j := i;
          while (j > 0) and (s[j] <> ch) do
            dec(j);
          if ch = #96 then
            j := 0;
          if ((j > 0) or (ch = #96)) and odd(i-j+1) then
            begin
              inc(j);
              b := true;
              d := (i-j+1) div 2;
              while (j+d <= i) do
                begin
                  b := b and (s[j] = s[j+d]);
                  inc(j);
                end;
              if b and (f[i,ch] > f[j-1,ch] + 1) then
                f[i,ch] := f[j-1,ch] + 1;
            end;
        end;

      c := #96;
      for ch := 'a' to 'z' do
        if f[i,ch] < f[i,c] then
          c := ch;

      if f[i,s[i]] > f[i,c] + 1 then
        f[i,s[i]] := f[i,c] + 1;
    end;

  c := #96;
  for ch := 'a' to 'z' do
    if f[n,ch] < f[n,c] then
      c := ch;
  Write(f[n,c]);

  Close(input);
  Close(output);
end.
