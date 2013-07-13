type
        Real = Extended;
        TPoint =
        record
          x, y : Real;
        end;
        TT =
        record
          a, b, c : TPoint;
        end;
var
        a, b : TT;
        n, e : LongInt;
        p, q : Array[1 .. 20] of TPoint;

Function GetS : Real;
var
        s : Real;
        i : LongInt;
begin
  s := 0;
  for i := 1 to n do
    s := s + p[i mod n + 1].x * p[i].y - p[i mod n + 1].y * p[i].x;
  GetS := Abs(s) / 2;
end;

Function STr(const t : TT) : Real;
begin
  n := 3;
  p[1] := t.a;
  p[2] := t.b;
  p[3] := t.c;
  STr := GetS;
end;

Function InTriangle(const p : TPoint; t : TT) : Boolean;
var
        q : TPoint;
        s : Real;
begin
  s := STr(t);
  q := t.a;
  t.a := p;
  s := s - STr(t);
  t.a := q;
  q := t.b;
  t.b := p;
  s := s - STr(t);
  t.b := q;
  q := t.c;
  t.c := p;
  s := s - STr(t);
  t.c := q;
  InTriangle := Abs(s) < 1e-6;
end;

Procedure BS(l, r : TPoint; const t : TT);
var
        tmp : TPoint;
begin
  While (Abs(r.x - l.x) > 1e-6) or (Abs(r.y - l.y) > 1e-6) do
  begin
    tmp.x := (l.x + r.x) / 2;
    tmp.y := (l.y + r.y) / 2;
    if InTriangle(tmp, t) then
    begin
      if InTriangle(l, t) then
        l := tmp
      else
        r := tmp;
    end
    else
    begin
      if not InTriangle(l, t) then
        l := tmp
      else
        r := tmp;
    end;
  end;
  if (not InTriangle(l, a)) or (not InTriangle(l, b)) then
    Exit;
  Inc(e);
  q[e] := l;
end;

Function More(const a, b : TPoint) : Boolean;
begin
  if (Abs(b.x) < 1e-6) and (Abs(b.y) < 1e-6) then
    More := True
  else
    More := (a.x * b.y > a.y * b.x) or ((Abs(a.x * b.y - a.y * b.x) < 1e-6) and (a.x * a.x + a.y * a.y > b.x * b.x + b.y * b.y));
end;

Procedure Solve;
var
        i, j : LongInt;
        w : Real;
        t : TPoint;
begin
  BS(a.a, a.b, b);
  BS(a.b, a.c, b);
  BS(a.c, a.a, b);
  BS(b.a, b.b, a);
  BS(b.b, b.c, a);
  BS(b.c, b.a, a);
  if InTriangle(a.a, b) then
  begin
    Inc(e);
    q[e] := a.a;
  end;
  if InTriangle(a.b, b) then
  begin
    Inc(e);
    q[e] := a.b;
  end;
  if InTriangle(a.c, b) then
  begin
    Inc(e);
    q[e] := a.c;
  end;
  if InTriangle(b.a, a) then
  begin
    Inc(e);
    q[e] := b.a;
  end;
  if InTriangle(b.b, a) then
  begin
    Inc(e);
    q[e] := b.b;
  end;
  if InTriangle(b.c, a) then
  begin
    Inc(e);
    q[e] := b.c;
  end;
  for i := 2 to e do
  begin
    q[i].x := q[i].x - q[1].x;
    q[i].y := q[i].y - q[1].y;
  end;
  q[1].x := 0;
  q[1].y := 0;
  for i := 1 to e do
    for j := 2 to e - 1 do
      if More(q[j], q[j + 1]) then
      begin
        t := q[j];
        q[j] := q[j + 1];
        q[j + 1] := t;
      end;
  w := STr(a) + STr(b);
  n := e;
  p := q;
{  for i := 1 to n do
    WriteLn(p[i].x : 0 : 3, ' ', p[i].y : 0 : 3);}
  WriteLn(w - GetS : 0 : 5);
end;

begin
  Assign(input, 'triangle.in');
  Reset(input);
  Assign(output, 'triangle.out');
  Rewrite(output);
  ReadLn(a.a.x, a.a.y, a.b.x, a.b.y, a.c.x, a.c.y, b.a.x, b.a.y, b.b.x, b.b.y, b.c.x, b.c.y);
  Solve;
  Close(input);
  Close(output);
end.