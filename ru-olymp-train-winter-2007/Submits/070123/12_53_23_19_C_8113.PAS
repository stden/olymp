program tourism;

{$MODE DELPHI}

const
  MAXN = 4010;

var
  n, k, i, j, t, q: Integer;
  s: string;
  a: array [0..MAXN, 0..MAXN] of Boolean;
  ans: array [0..MAXN] of Integer;
  b: array [0..MAXN] of Boolean;


function f(ch: char): Integer;
begin
  case ch of
    '0'..'9': Result := ord(ch) - ord('0');
    'A'..'Z': Result := ord(ch) - ord('A') + 10;
    'a'..'z': Result := ord(ch) - ord('a') + 36;
    '!': Result := 62;
    '?': Result := 63;
  end;
end;

begin
  Assign(input, 'tourism.in');
  Assign(output, 'tourism.out');
  Reset(input); Rewrite(output);

  ReadLn(n);
  ReadLn(s);
  fillchar(a, sizeof(a), 0);
  i := 1; j := 2;
  for t := 1 to Length(s) do
    begin
      k := f(s[t]);
      for q := 0 to 5 do
        if j <= n then
          begin
            if k and (1 shl q) > 0 then
              a[i,j] := true
            else
              a[j,i] := true;
            inc(j);
            if j > n then
              begin
                inc(i);
                j := i+1;
              end;
        end;
    end;

  for i := 2 to n do
    for j := 2 to n do
      begin
        if a[1,i] and a[i,j] and a[j,1] then
          begin
            ans[1] := 1; ans[2] := i; ans[3] := j;
            break;
          end;
        if a[1,j] and a[j,i] and a[i,1] then
          begin
            ans[1] := 1; ans[2] := j; ans[3] := i;
            break;
          end;
      end;

  fillchar(b, sizeof(b), 0);
  b[ans[1]] := true;
  b[ans[2]] := true;
  b[ans[3]] := true;
  for i := 4 to n do
    begin
      k := 0;
      for j := 1 to n do
        if not b[i] and a[ans[i-1],j] and a[j,ans[1]] then
          k := j;
      b[k] := true;
      ans[i] := k;
    end;

  Read(k);
  for i := 1 to k do  
    begin
      Read(q);
      if (q >= 3) and (q <= n) then
        begin
          for j := 1 to q do
            Write(ans[j]-1, ' ');
          WriteLn;
        end
      else
        WriteLn(-1);
    end;

  Close(input);
  Close(output);
end.