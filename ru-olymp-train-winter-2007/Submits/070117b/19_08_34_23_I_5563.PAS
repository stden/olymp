const
        MaxN = 239017 + 1000;
        Inf = MaxLongInt;
var
        min, pred, a : Array[-10 .. MaxN] of LongInt;
        n, i, b : LongInt;

Function Find(const w : LongInt) : LongInt;
var
        l, r, t : LongInt;
begin
  l := 0;
  r := n;
  While l <> r do
  begin
    t := (l + r - 1) div 2 + 1;
    if min[a[t]] >= w then
      l := t
    else
      r := t - 1;
  end;
  Find := (l + r) div 2;
end;

Procedure Ans(const a : LongInt);
begin
  if a < 0 then
    Exit;
  Ans(pred[a]);
  WriteLn(a);
end;

begin
  Assign(input, 'subseq.in');
  Reset(input);
  Assign(output, 'subseq.out');
  Rewrite(output);
  ReadLn(n);
  for i := 1 to n + 5 do
    min[i] := -3;
  min[0] := -5;
  a[-5] := Inf;
  a[-3] := -Inf;
  for i := 1 to n do
  begin
    Read(a[i]);
    b := Find(a[i]);
    pred[i] := min[b + 1];
    min[b + 1] := i;
  end;
  i := 0;
  While min[i] <> -3 do
    Inc(i);
  Dec(i);
  WriteLn(i);

  Ans(i);
  Close(input);
  Close(output);
end.
