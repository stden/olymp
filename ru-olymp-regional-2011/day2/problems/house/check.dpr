uses
  SysUtils, testlib;
const
  eps = 2.1e-6;
  bound = 1e9;
var
  jx, jy, jd, px, py, pd : extended;
  x1, y1, x2, y2, a, b, c, d : extended;
  i, n : longint;

function max(a, b : double) : double;
  begin
    if (a < b) then
      max := b
    else
      max := a;
  end;

Begin
  n := inf.ReadLongint;
  jx := ans.ReadReal;
  jy := ans.ReadReal;
  px := ouf.ReadReal;
  py := ouf.ReadReal;
  if (abs(px) > bound + eps) or (abs(py) > bound + eps) then
    quit(_wa, 'Coordinates are too big ' + FloatToStr(px) + ' ' + FloatToStr(py));
  jd := 0;
  pd := 0;
  for i := 1 to n do begin
    x1 := inf.ReadLongint;
    y1 := inf.ReadLongint;
    x2 := inf.ReadLongint;
    y2 := inf.ReadLongint;
    a := y2 - y1;
    b := x1 - x2;
    d := sqrt(a * a + b * b);
    a := a / d;
    b := b / d;
    c := -x1 * a - y1 * b;
    d := abs(a * px + b * py + c);
    if (d > pd) then
      pd := d;
    d := abs(a * jx + b * jy + c);
    if (d > jd) then
      jd := d;
  end;
  if (abs(jd - pd) / max(1, jd) < eps) then
    quit(_ok, 'Ok (' + floatToStr(px) + ', ' + floatToStr(py) + ') dist = ' + floatToStr(pd));
  if (jd < pd) then
    quit(_wa, 'jd = ' + floatToStr(jd) + '; pd = ' + floatToStr(pd) + ' diff = ' + floattostr(abs(jd - pd) / max(1, jd)));
  quit(_fail, 'jd = ' + floatToStr(jd) + '; pd = ' + floatToStr(pd));
End.