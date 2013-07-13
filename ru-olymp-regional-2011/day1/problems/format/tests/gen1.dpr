var
  s : string;

begin
  reset(input, paramstr(1));
  rewrite(output, paramstr(2));
  while not(eof) do begin
    readln(s);
    if (s <> '') then begin
      writeln(s);
    end;
  end;
end.