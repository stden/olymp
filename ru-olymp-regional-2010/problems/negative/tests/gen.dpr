{$apptype console}
uses
  SysUtils, Math;

var
  n, m : integer;
  p1, p2 : array[1..100, 1..100] of char;
  i, j, k : integer;
  r, c : integer;

begin
  n := strtoint(paramstr(1));
  m := strtoint(paramstr(2));
  randseed := strtoint(paramstr(3));
  for i := 1 to n do begin
    for j := 1 to m do begin
      if (random(2) = 1) then begin
        p1[i][j] := 'B';
      end else begin
        p1[i][j] := 'W'
      end;
      p2[i][j] := p1[i][j];
    end;
  end;

  k := random(n * m + 1);
  for i := 1 to k do begin
    r := 1 + random(n);
    c := 1 + random(m);
    if (p2[r][c] = 'W') then begin
      p2[r][c] := 'B'
    end else begin
      p2[r][c] := 'W'
    end;
  end;

  writeln(n, ' ', m);
  for i := 1 to n do begin
    for j := 1 to m do begin
      write(p1[i][j]);
    end;
    writeln;
  end;

  writeln;
    
  for i := 1 to n do begin
    for j := 1 to m do begin
      write(p2[i][j]);
    end;
    writeln;
  end;
end.
