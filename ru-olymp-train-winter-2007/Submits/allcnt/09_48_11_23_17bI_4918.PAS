const
  MaxN = 239017;
  Inf = 1 shl 31 - 1;
var
  n : LongInt;
  a, rez, r, pred : Array[-2 .. MaxN] of LongInt;

Procedure Init;
var
  i : LongInt;
begin
  Assign(input, 'subseq.in');
  Assign(output, 'subseq.out');
  Reset(input);
  Rewrite(output);
  ReadLn(n);
  for i := 1 to n do
    Read(a[i]);        
end;

Function Find(const f : LongInt) : LongInt;
var
  l, r, tek : LongInt;
begin
  l := 0;
  r := n;
  While l <> r do
  begin                
    tek := (l + r - 1) div 2 + 1;
    if f <= a[rez[tek]] then 
      l := tek
    else
      r := tek - 1;
  end;
  Find := l;
end;

Procedure Solve;
var
  i, j, u : LongInt;
begin
  a[-2] := Inf;
  a[-1] := -Inf;
  rez[0] := -2;        
  for i := 1 to n do
    rez[i] := -1;
  for i := 1 to n do
    pred[i] := 0;
  for i := 1 to n do
  begin
    u := Find(a[i]);
    pred[i] := rez[u];
    rez[u + 1] := i;     
  end;

{  for i := 1 to n do
    Write(rez[i], ' ');
  WriteLn;
  for i := 1 to n do
    Write(pred[i], ' ');            
  WriteLn;}
  i := n;
  While rez[i] = -1 do
    Dec(i);
  WriteLn(i);
  i := rez[i];
  While i > 0 do
  begin
    Inc(r[0]);
    r[r[0]] := i;
    i := pred[i];
  end;
  i := n;
  While rez[i] = -1 do
    Dec(i);
  for j := i downto 1 do
    WriteLn(r[j]);
end;

begin
  Init;
  Solve;
  Close(input);
  Close(output);
end.