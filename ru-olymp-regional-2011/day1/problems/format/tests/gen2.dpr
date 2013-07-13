const
  symbs = [',', '.', '?', '!', '-', ':', ''''];

var
  i : integer;
  s, ss, tok : string;
  first : boolean;

function letter(ch : char) : boolean;
begin
  result := false;
  if (ord(ch) >= ord('a')) and (ord(ch) <= ord('z')) then begin
    result := true;
  end;
  if (ord(ch) >= ord('A')) and (ord(ch) <= ord('Z')) then begin
    result := true;
  end;
  if (ord(ch) >= ord('0')) and (ord(ch) <= ord('9')) then begin
    result := true;
  end;
end;

begin
  reset(input, paramstr(1));
  rewrite(output, paramstr(2));
  while not(eof) do begin
    readln(s);
    i := 1;
    while (i <= length(s)) and (s[i] in symbs) do begin
      i := i + 1;
    end;
    first := true;
    ss := '';
    while (i <= length(s)) do begin
      tok := '';
      while (i <= length(s)) and (letter(s[i])) do begin
        tok := tok + s[i];
        i := i + 1;
      end;
      while (i <= length(s)) and not(letter(s[i])) do begin
        if (s[i] in symbs) then begin
          tok := tok + s[i];
        end;
        i := i + 1;
      end;
      if (not first) then begin
        ss := ss + ' ';
      end;
      ss := ss + tok;
      first := false;
    end;
    writeln(ss);
  end;
end.