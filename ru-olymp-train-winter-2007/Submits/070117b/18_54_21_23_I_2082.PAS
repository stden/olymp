const
        MaxN = 239017 + 1000;
        Inf = MaxLongInt;
var
        min, rez : Array[0 .. MaxN] of LongInt;
        n, i, a, b : LongInt;

Function Find(const a : LongInt) : LongInt;
var
        l, r, t : LongInt;
begin
  l := 0;
  r := n;
  While l <> r do
  begin
    t := (l + r - 1) div 2 + 1;
    if min[t] >= a then
      l := t
    else
      r := t - 1;
  end;
  Find := (l + r) div 2;
end;

begin
  Assign(input, 'subseq.in');
  Reset(input);
  Assign(output, 'subseq.out');
  Rewrite(output);
  ReadLn(n);
  for i := 1 to n do
    min[i] := -Inf;
  min[0] := Inf;
  rez[0] := 0;
  for i := 1 to n do
  begin
    Read(a);
    b := Find(a);
    if min[b + 1] = -Inf then
    begin
      Inc(rez[0]);
      rez[rez[0]] := i;
    end;
    min[b + 1] := a;
  end;
  i := 1;
  WriteLn(rez[0]);
  for i := 1 to rez[0] do
    WriteLn(rez[i]);
  Close(input);
  Close(output);
end.