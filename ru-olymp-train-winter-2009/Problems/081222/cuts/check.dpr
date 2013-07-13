{$O-,Q+,R+}
uses testlib;
type integer = longint;

const MaxN = 50;
      MaxM = 300;
      MaxK = 300;
      MaxC = 1000000000;

type tarr = array [1..MaxK] of int64;
var s : array [1..MaxK] of string;

procedure qsort (l, r : integer);
var i, j : integer;
    x, y : string;
begin
  if l >= r then exit;
  i := l; j := r;
  x := s[(l + r) shr 1];
  repeat
    while s[i] < x do inc (i);
    while x < s[j] do dec (j);
    if i <= j then begin
      y := s[i]; s[i] := s[j]; s[j] := y;
      inc (i); dec (j)
    end;
  until i > j;
  qsort (l, j);
  qsort (i, r);
end;

var n, m, k : integer;
    u, v, w : array [1..MaxM] of integer;

procedure answer (var f : instream; var a : tarr);
var i, j : integer;
begin
  for i := 1 to k do begin
    s[i] := f.readstring;
    if length (s[i]) <> n then f.quit (_PE, 'Требовалась строка длины ' + i2s (n) + ', а получена строка длины ' + i2s (length (s[i])));
    for j := 1 to length (s[i]) do
      if not (s[i, j] in ['0', '1']) then f.quit (_PE, 'Символ не равен 0 или 1: ' + mp (s[i, j]));
    if (s[i, 1] <> '0') or (s[i, n] <> '1') then
      f.quit (_WA, 'Объект не является разрезом');

    a[i] := 0;

    for j := 1 to m do
      if (s[i, u[j]] = '0') and (s[i, v[j]] = '1') then
        inc (a[i], w[j]);
  end;


  for i := 1 to k - 1 do
    if a[i] > a[i + 1] then
      f.quit (_WA, 'Последовательность разрезов не упорядочена');

  qsort (1, k);

  for i := 1 to k - 1 do
    if s[i] = s[i + 1] then
      f.quit (_WA, 'Повторяется разрез ' + s[i]);

end;

var b : array [1..MaxN, 1..MaxN] of boolean;
    i : integer;
    jury, cont : tarr;

begin
  inf.noeoln; n := inf.getintr (1, MaxN);
  inf.noeoln; m := inf.getintr (1, MaxM);
  inf.reql (Reject);
  for i := 1 to m do begin
    inf.noeoln; u[i] := inf.getintr (1, n);
    inf.noeoln; v[i] := inf.getintr (1, n);
    inf.noeoln; w[i] := inf.getintr (1, MaxC);
    inf.reql (Reject);
    inf.test ((u[i] <> v[i]) and not b[u[i], v[i]]);
    b[u[i], v[i]] := true;
  end;
  inf.noeoln; k := inf.getintr (1, MaxK);
  inf.reql (Reject);
  inf.reqeof;
  answer (ans, jury);
  answer (ouf, cont);

  for i := 1 to k do begin
    if jury[i] < cont [i] then quit (_WA, i2s (i) + '-й разрез у жюри лучше: ' + cp2s (jury[i]) + ' против ' + cp2s (cont[i]));
    if jury[i] > cont [i] then quit (_Fail, i2s (i) + '-й разрез у жюри ХУЖЕ: ' + cp2s (jury[i]) + ' против ' + cp2s (cont[i]));
  end;

  quit (_OK, i2s (k) + ' разрезов, величина максимального = ' + cp2s (jury[k]));
end.
