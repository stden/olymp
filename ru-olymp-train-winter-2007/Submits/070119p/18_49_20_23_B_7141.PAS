uses
        SysUtils;
type
        PVert = ^TVert;
        TVert =
        record
          x, y : LongInt;
          l, r, pred : PVert;
        end;
        TPoint =
        record
          x, y : LongInt;
        end;
        TSeg =
        record
          a, b : TPoint;
        end;
var
        root : PVert;
        o : Array[1 .. 125000] of TSeg;
        n : LongInt;

Function VP(const a, b : TPoint) : LongInt;
begin
  VP := a.x * b.y - a.y * b.x
end;

Procedure MakeVector(const a, b : TPoint; var v : TPoint);
begin
  v.x := b.x - a.x;
  v.y := b.y - a.y;
end;

Function Intersect(const a, b : TSeg) : Boolean;
var
        v1, v2, v3, v4, v5, v6 : TPoint;
begin
  MakeVector(a.a, a.b, v1);
  MakeVector(a.a, b.a, v2);
  MakeVector(a.a, b.b, v3);
  MakeVector(b.a, b.b, v4);
  MakeVector(b.a, a.a, v5);
  MakeVector(b.a, a.b, v6);
  Intersect := (VP(v1, v2) * VP(v1, v3) <= 0) and (VP(v4, v5) * VP(v4, v6) <= 0);
end;

Procedure Split(const t : PVert; const x : LongInt; var l, r : PVert);
begin
  if t = nil then
  begin
    l := nil;
    r := nil;
    Exit;
  end;
  if t^.x > x then
  begin
    Split(t^.l, x, l, t^.l);
    t^.l^.pred := t;
    r := t;
  end
  else
  begin
    Split(t^.r, x, t^.r, r);
    t^.r^.pred := t;
    l := t;
  end;
end;

Procedure Merge(const a, b : PVert; var t : PVert);
begin
  if a^.y < b^.y then
  begin
    t := a;
    b^.pred := a;
    if a^.x > b^.x then
      Merge(a^.l, b, t^.l)
    else
      Merge(a^.r, b, t^.r);
  end
  else
  begin
    t := b;
    a^.pred := b;
    if b^.x > a^.x then
      Merge(b^.l, a, t^.l)
    else
      Merge(b^.r, a, t^.r);
  end;
end;

Procedure Insert(var t : PVert; const x, y : LongInt);
begin
  if t = nil then
  begin
    New(t);
    t^.x := x;
    t^.y := y;
    t^.l := nil;
    t^.r := nil;
    Exit;
  end;
  if t^.y > y then
  begin
  end
  else
  begin
{    if t^.}
  end;
end;

Procedure Init;
var
        i : LongInt;
begin
  ReadLn(n);
  for i := 1 to n do
    Read(o[i].a.x, o[i].a.y, o[i].b.x, o[i].b.y);
end;
var
        _end : Real;

Procedure Solve;
var
        i, j : LongInt;
begin
  for i := n downto 1 do
    if now < _end then
      for j := i - 1 downto 1 do
        if Intersect(o[i], o[j]) then
        begin
          WriteLn('YES');
          Write(i, ' ', j);
          Exit;
        end;
  Write('NO');
end;

begin
  _end := now + 2 / 60 / 60 / 24;
  Assign(input, 'segments.in');
  Reset(input);
  Assign(output, 'segments.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.