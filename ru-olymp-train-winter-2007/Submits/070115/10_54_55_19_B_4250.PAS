program reverse;

{$H+}

type
  Integer = Longint;

var
  s: String;
  ans: Boolean;
  l, r, rl, rr, x, y: Integer;

function num(ch: char): Integer;
begin
  num := ord(ch) - ord('0');
end;

begin
  Assign(input, 'reverse.in');
  Assign(output, 'reverse.out');
  Reset(input); Rewrite(output);

  while not eof do
    begin
      ReadLn(s);
      if s = '0' then break;

      ans := true;
      l := 1; r := Length(s);
      rl := 0; rr := 0;
      while l < r do
        begin
          x := rl + num(s[l]);
          y := rr + num(s[r]);
          rl := 0; rr := 0;
          if (y < 0) or (x > y + 5) then
            begin
              inc(y, 10);
              rr := -1;
            end;
          if x > y then
            begin
              dec(x);
              rl := 10;
            end;

          if x <> y then
            begin
              ans := false;
              break;
            end;

          inc(l); dec(r);
        end;
      if l = r then
        if (rl + rr + num(s[l]) < 0) or odd(rl + rr + num(s[l])) then
          ans := false
        else
      else
        if 10*rr + rl <> 0 then
          ans := false;

      if not ans and (s[1] = '1') and (Length(s) > 1) then
        begin
          ans := true;
          l := 2; r := Length(s);
          rl := 10; rr := 0;
          while l < r do
            begin
              x := rl + num(s[l]);
              y := rr + num(s[r]);
              rl := 0; rr := 0;
              if (y < 0) or (x > y + 5) then
                begin
                  inc(y, 10);
                  rr := -1;
                end;
              if x > y then
                begin
                  dec(x);
                  rl := 10;
                end;

              if x <> y then
                begin
                  ans := false;
                  break;
                end;

              inc(l); dec(r);
            end;
          if l = r then
            if (rl + rr + num(s[l]) < 0) or odd(rl + rr + num(s[l])) then
              ans := false
            else
          else
            if 10*rr + rl <> 0 then
              ans := false;

        end;

      if ans then
        WriteLn('YES')
      else
        WriteLn('NO');

    end;

  Close(input);
  Close(output);
end.
