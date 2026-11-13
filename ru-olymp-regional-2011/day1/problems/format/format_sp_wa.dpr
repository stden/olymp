const
  symbs = [',', '.', '?', '!', '-', ':', ''''];
  maxlinelen = 250;

var
  par : boolean;
  s, ss, tok : string;
  i, spaces, j, w, b : integer;

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
  reset(input, 'format.in');
  rewrite(output, 'format.out');
  readln(w, b);
  par := true;
  ss := '';
  spaces := 0;
  while not(eof) do begin
    readln(s);
    assert(length(s) <= maxlinelen);
    if (s = '') then begin
      if (ss <> '') then begin
        assert(length(ss) <= w);
        writeln(ss);
        spaces := 0;
        ss := '';
      end;
      par := true;
      continue;
    end;

    if (par) then begin
      for i := 1 to b do begin
        ss := ss + ' ';
      end;
      par := false;
    end;
    i := 1;
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
      if (length(ss) + spaces + length(tok) > w) then begin
        assert(length(ss) <= w);
        writeln(ss);
        ss := tok;
        spaces := 1;
      end else begin
        for j := 1 to spaces do begin
          ss := ss + ' ';
        end;
        ss := ss + tok;
        spaces := 1;
      end;
    end;
  end;
  if (ss <> '') then begin
    assert(length(ss) <= w);
    writeln(ss);
  end;
end.