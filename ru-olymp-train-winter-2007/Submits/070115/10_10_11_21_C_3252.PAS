Program prg;

const
  taskname = 'bit';

type
  integer = longint;

var
  n: integer;
  l: integer;
  i, j, k: integer;
  a, b, c: array[0..100010] of boolean;
  s: ansistring;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  read(n);
  for i:=1 to n do begin
    readln(l);
    readln(s);

    if (l = 1) then begin
      writeln('NO');
      continue;
    end;
    if (l = 2) then begin
      if (s[1] = s[2]) then writeln('NO') else writeln('YES');
      continue;
    end;

    fillchar(a, sizeof(a), 0);
    fillchar(b, sizeof(b), 0);
    fillchar(c, sizeof(c), 0);

    if (s[1] = 'a') then begin
      if (s[2] = 'a') then begin
        a[3] := false;
        b[3] := true;
        c[3] := true;
      end else
      if (s[2] = 'b') then begin
        a[3] := true;
        b[3] := true;
        c[3] := false;
      end else begin
        a[3] := true;
        b[3] := false;
        c[3] := true;
      end;
    end else
    if (s[1] = 'b') then begin
      if (s[2] = 'a') then begin
        a[3] := true;
        b[3] := true;
        c[3] := false;
      end else
      if (s[2] = 'b') then begin
        a[3] := true;
        b[3] := false;
        c[3] := true;
      end else begin
        a[3] := false;
        b[3] := true;
        c[3] := true;
      end;
    end else
    if (s[1] = 'c') then begin
      if (s[2] = 'a') then begin
        a[3] := true;
        b[3] := false;
        c[3] := true;
      end else
      if (s[2] = 'b') then begin
        a[3] := false;
        b[3] := true;
        c[3] := true;
      end else begin
        a[3] := true;
        b[3] := true;
        c[3] := false;
      end;
    end;

    for j:=4 to l do begin

        if (a[j-1] = true) then
          if (s[j-1] = 'a') then begin
            b[j+1]:=true;
            c[j+1]:=true;
          end else
          if (s[j-1] = 'b') then begin
            c[j]:=true;
          end else
          if (s[j-1] = 'c') then begin
            b[j]:=true;
          end;

        if (b[j-1] = true) then
          if (s[j-1] = 'b') then begin
            a[j+1]:=true;
            c[j+1]:=true;
          end else
          if (s[j-1] = 'a') then begin
            c[j]:=true;
          end else
          if (s[j-1] = 'c') then begin
            a[j]:=true;
          end;

        if (c[j-1] = true) then
          if (s[j-1] = 'c') then begin
            b[j+1]:=true;
            a[j+1]:=true;
          end else
          if (s[j-1] = 'b') then begin
            a[j]:=true;
          end else
          if (s[j-1] = 'a') then begin
            b[j]:=true;
          end;

    end;

    write(length(s) , ' ');
    if (s[l] = 'a') then begin
      if (a[l]) then writeln('YES') else writeln('NO');
    end else
    if (s[l] = 'b') then begin
      if (b[l]) then writeln('YES') else writeln('NO');
    end else
    if (s[l] = 'c') then begin
      if (c[l]) then writeln('YES') else writeln('NO');
    end;

  end;

  close(input);
  close(output);
end.
