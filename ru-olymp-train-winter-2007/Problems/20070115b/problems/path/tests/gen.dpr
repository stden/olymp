{$apptype console}
uses
  sysutils, math;
  
var
  nn, m, nt, b, n, i, ii, jj, j, k: integer;
  a: array[0..30000 shr 5 + 1, 1..30000] of integer;
  s: string;

procedure seta(i, j: integer; q: boolean);
begin
  if q then
    a[i shr 5, j] := a[i shr 5, j] or (1 shl (i and 31))
  else
    a[i shr 5, j] := a[i shr 5, j] and not (1 shl (i and 31));
end;

function geta(i, j: integer): boolean;
begin
  geta := (a[i shr 5, j] and (1 shl (i and 31))) <> 0;
end;

var
  q, w: array[1..400000] of integer;
  p: array[1..30000] of integer;

procedure make;
var
  i, j, t, m: integer;
begin
  inc(nt);
  assign(output, chr(ord('0')+nt div 10) + chr(ord('0') + nt mod 10));
  rewrite(output);

  m := 0;
  for i := 1 to n do
    for j := i+1 to n do if geta(i, j) then begin
      inc(m);
      q[m] := i;
      w[m] := j;
    end;

  for i := 1 to n do p[i] := i;
  for i := n downto 1 do begin
    j := random(i) + 1;
    t := p[i];
    p[i] := p[j];
    p[j] := t;
  end;

  writeln(n, ' ', m);
  for i := m downto 1 do begin
    j := random(i) + 1;
    t := q[i];
    q[i] := q[j];
    q[j] := t;
    t := w[i];
    w[i] := w[j];
    w[j] := t;
  end;
  for i := 1 to m do writeln(p[q[i]],' ',p[w[i]],' ',random(10000));  
  close(output);
  rewrite(output, '');
  writeln(nt);
end;

begin
  randseed := 239;
  nt := 0;

  for n := 2 to 10 do begin
    fillchar(a, sizeof(a), 0);
    for i := 2 to n do begin
      j := random(i-1) + 1;
      seta(i, j, true);
      seta(j, i, true);
    end;
    for i := 1 to random(n*(n-1) div 2) do begin
      repeat
        ii := random(n) + 1;
        jj := random(n) + 1;
      until (ii <> jj);
      seta(ii, jj, true);
      seta(jj, ii, true);
    end;
    make;
  end;

  for nn := 1 to 9 do begin
    n := nn * 100 + random(100);
    fillchar(a, sizeof(a), 0);
    for i := 2 to n do begin
      j := random(i-1) + 1;
      seta(i, j, true);
      seta(j, i, true);
    end;
    for i := 1 to max(random(n*(n-1) div 10), 400000) do begin
      repeat
        ii := random(n) + 1;
        jj := random(n) + 1;
      until (ii <> jj);
      seta(ii, jj, true);
      seta(jj, ii, true);
    end;
    make;
  end;

  for nn := 1 to 3 do begin
    n := 30000;
    fillchar(a, sizeof(a), 0);
    for i := 2 to n do begin
      j := random(i-1) + 1;
      seta(i, j, true);
      seta(j, i, true);
    end;
    for i := 1 to (nn-1) * 200000 - 30000 do begin
      repeat
        ii := random(n) + 1;
        jj := random(n) + 1;
      until (ii <> jj);
      seta(ii, jj, true);
      seta(jj, ii, true);
    end;
    make;
  end;

end.