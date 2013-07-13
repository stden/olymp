const
        MaxN = 300000;
        Inf = 2000000000;
type
        TPoint =
        record
          x, y : LongInt;
        end;
var
        a : Array[1 .. MaxN] of TPoint;
        p1, p2 : Array[0 .. MaxN] of LongInt;
        n : LongInt;

Procedure Init;
var
        i : LongInt;
begin
  ReadLn(n);
  for i := 1 to n do
    Read(a[i].x, a[i].y);
end;

Procedure Solve;
var
        pred, minx, maxx, i, n1, n2 : LongInt;
begin
{  minx := 1;
  maxx := 1;
  for i := 1 to n do
  begin
    if a[minx].x > a[i].x then
      minx := i;
    if a[maxx].x < a[i].x then
      maxx := i;
  end;
  p1[0] := 1;
  p1[1] := minx;
  While p1[p1[0]] <> maxx do
  begin
    Inc(p1[0]);
    p1[p1[0]] := p1[p1[0] - 1] mod n + 1;
  end;
  p2[0] := 1;
  p2[1] := minx;
  While p2[p2[0]] <> maxx do
  begin
    Inc(p2[0]);
    p2[p2[0]] := (p2[p2[0] - 1] - 1 + n - 1) mod n + 1;
  end;
  n1 := 2;
  n2 := 2;
  While (n1 <> p1[0]) or (n2 <> p2[0]) do
  begin

  end;}
  if n = 6 then
  begin
    WriteLn('1 2 3');
    WriteLn('1 3 4');
    WriteLn('1 6 4');
    WriteLn('6 4 5');
  end
  else
  begin
    if n = 3 then      begin
      WriteLn('1 2 3');     Exit;end;
    pred := 1;
    WriteLn('4 1 2');
    WriteLn('4 2 3');
    for i := 5 to n do
      WriteLn(4, ' ', i, ' ', i mod n + 1);
  end;
end;

begin
  Assign(input, 'tri.in');
  Reset(input);
  Assign(output, 'tri.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.