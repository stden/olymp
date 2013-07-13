const
  symbs = [',', '.', '?', '!', '-', ':', ''''];

var
  i : integer;
  s : string;

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
    for i := 1 to length(s) do begin
      if (letter(s[i])) or (s[i] in symbs) or (s[i] = ' ') then begin
        write(s[i]);
      end;
    end;
    writeln;
  end;
end.