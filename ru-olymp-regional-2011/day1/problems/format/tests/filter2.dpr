const
  symbs = [',', '.', '?', '!', '-', ':', ''''];

var
  i, w, b : integer;
  s, tok, ss, all : string;
  par : boolean;

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
  readln(w, b);
  par := false;
  writeln(w, ' ', b);
  while not(eof) do begin
    readln(s);
    if (s = '') then begin
      par := true;
      writeln(s);
      continue;
    end;
    ss := '';
    i := 1;
    while (i <= length(s)) do begin
      all := '';
      tok := '';
      while (i <= length(s)) and (letter(s[i])) do begin
        tok := tok + s[i];
        all := all + s[i];
        i := i + 1;
      end;
      while (i <= length(s)) and not(letter(s[i])) do begin
        if (s[i] in symbs) then begin
          tok := tok + s[i];
        end;
        all := all + s[i];
        i := i + 1;
      end;
      if (length(tok) > w) or ((par) and (length(tok) > w - b)) then begin
        all := '';
      end;
      par := false;
      ss := ss + all;
    end;
    if (length(ss) > 250) then begin
      writeln(copy(ss, 1, 250));
    end else begin
      writeln(ss);
    end;
  end;
end.