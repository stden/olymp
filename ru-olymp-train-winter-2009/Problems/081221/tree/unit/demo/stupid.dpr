uses
  treeunit;

const
  maxN = 200000;

var
  n, i: longint;
  a, b: array [1 .. maxN] of longint;
  r: array [1 .. maxN] of longint;
  can: array [1 .. maxN] of boolean;
begin
  init();
  n := getN();
  for i := 1 to n do
    can[i] := true;
  for i := 1 to n - 1 do
  begin
    a[i] := getA(i);
    b[i] := getB(i);
    r[i] := query(i);
    if r[i] = 0 then can[b[i]] := false
    else can[a[i]] := false;
  end;
  for i := 1 to n do
    if can[i] then
      report(i);
end.
