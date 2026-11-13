{$O-,Q+,R+}
{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}
uses testlib;
type integer = longint;
const MaxN = 30;

var A : array [1..30, 1..30] of boolean;
    B : array [1..30] of integer;
    n : integer;


function answer (var f : instream) : integer;
var i, p, x, j : integer;
begin

  for i := 1 to n do B[i] := 0;

  p := 0;
  for i := 1 to n shr 1 do begin
    x := f.getlong;
    if (x < 1) or (x > n) then f.quit (_WA, 'Недопустимый номер вершины: ' + i2s (x));
    if (x <= p) then f.quit (_WA, 'Нарушен порядок возрастания');
    p := x;
    B[x] := 1;
  end;

  if (B[1] = 0) then f.quit (_WA, 'Первая вершина должна лежать в первом множестве');

  Result := 0;

  for i := 1 to n do
    for j := i + 1 to n do
      if (B[i] <> B[j]) and A[i, j] then inc (Result);

end;

var i, m, u, v, jury, cont : integer;


begin
  inf.noeoln; n := inf.getintr (2, MaxN); inf.test (not odd (n));
  inf.noeoln; m := inf.getintr (1, MaxN * MaxN);
  inf.reql (Reject);
  fillchar (A, sizeof (A), 0);
  for i := 1 to m do begin
    inf.noeoln; u := inf.getintr (1, n);
    inf.noeoln; v := inf.getintr (1, n);
    inf.test ((u <> v) and not A[u, v]);
    A[u, v] := true;
    A[v, u] := true;
    inf.reql (Reject);
  end;
  inf.reqeof;
  jury := answer (ans);
  cont := answer (ouf);

  if jury < cont then quit (_WA, 'Неоптимальный ответ: ' + i2s (cont) + ' вместо ' + i2s (jury));
  if jury > cont then quit (_Fail, 'Слишком хороший ответ: ' + i2s (cont) + ' вместо ' + i2s (jury));

  quit (_OK, 'Величина разреза: ' + i2s (cont));
end.