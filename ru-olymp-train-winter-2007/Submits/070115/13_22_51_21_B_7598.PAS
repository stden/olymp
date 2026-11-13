Program prg;

const
  taskname = 'reverse';

type
  integer = longint;

var
  n: integer;
  i, j, k: integer;
  s: ansistring;
  good: boolean;
  cf, cl: char;

function subright(c: char): boolean;
  begin
    if (ord(s[1]) < ord(c)) then begin
      subright:=false;
      exit;
    end else begin
      s[1]:=chr(ord(s[1]) - (ord(c) - ord('0')));
      subright:=true;
    end;
  end;

function subleft(c: char): boolean;
  var
    i: integer;

  begin
    i:=length(s);
    while (i > 0) do begin
      if (ord(s[i]) < ord(c)) then begin
        s[i]:='9';
        dec(i);
      end else begin
        s[i]:=chr(ord(s[i]) - (ord(c)-ord('0')));
        break;
      end;
    end;
    if (i <= 0) then subleft:=false else subleft:=true;
  end;

begin
  assign(input, taskname+'.in');
  assign(output, taskname+'.out');
  reset(input);
  rewrite(output);

  while (true) do begin
    readln(s);
    if (s = '0') then begin
      break;
    end;

    if (length(s) = 1) then begin
      val(s, n);
      if (n mod 2 = 0) then
        writeln('YES')
      else
        writeln('NO');
      continue;
    end;
    if (s = '10') or (s = '12') or (s = '14') or (s = '16') or (s = '18') then begin
      writeln('YES');
      continue;
    end;

    good:=true;
    while (length(s) > 1) do begin
      if (length(s) = 2) and ((s = '10') or (s = '12') or (s = '14') or (s = '16') or (s = '18')) then break;

      cf:=s[1];
      cl:=s[length(s)];
      if (cl = '1') then begin
        if (length(s) = 2) and (s[1] = '1') then begin
          good:=true;
          break;
        end;
        if (cf = '2') then begin
          s[1] := '1';
          delete(s, length(s), 1);
        end else
        if (cf <> '1') then begin
          good := false;
          break;
        end else
        if (s[2] = s[length(s) - 1]) then begin
          delete(s, 1, 1);
          delete(s, length(s), 1);
        end else
        if (s[2] = '2') then begin
          delete(s, 1, 1);
          s[1]:='1';
          delete(s, length(s), 1);
          if not subleft('1') then begin
            good:=false;
            break;
          end;
        end else
        if (s[2] = '1') then begin
          delete(s, 1, 2);
          delete(s, length(s), 1);
          if not subleft('1') then begin
            good:=false;
            break;
          end;
        end else begin
          good:=false;
          break;
        end;
      end else begin
        if (cf = cl) then begin
          delete(s, 1, 1);
          delete(s, length(s), 1);
        end else
        if (cf = '1') then begin
          delete(s, 1, 1);
          if not subright(cl) then begin
            good:=false;
            break;
          end;
          delete(s, length(s), 1);
          if not subleft('1') then begin
            good := false;
            break;
          end;
          while (length(s) > 0) and (s[1] = '0') do delete(s, 1, 1);
        end else
        if (ord(cf) = ord(cl)+1) then begin
          delete(s, length(s), 1);
          s[1] := '1';
        end else begin
          good:=false;
          break;
        end;
      end;

    end;
    if (length(s) = 1) and not ((s = '2') or (s = '4') or (s = '6') or (s = '8')) then good:=false;
    if (length(s) = 2) and ((s = '10') or (s = '12') or (s = '14') or (s = '16') or (s = '18')) then good:=true;

    if good then writeln('YES') else writeln('NO');
  end;

  close(input);
  close(output);
end.
