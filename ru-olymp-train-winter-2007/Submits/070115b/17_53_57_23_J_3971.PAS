  {$I-,Q-,R-,S-}
uses
        SysUtils;
const
        MaxN = 30100;
        MaxM = 800100;
type
        TP = ^TT;
        TT =
        record
          a, b, c : Word;
        end;
var
        used : Array[1 .. MaxN] of Boolean;
        l, a, b, c, n, m, mm, i, j : LongInt;
        sm : Array[0 .. MaxM] of TT;
        dist, ist, uk : Array[1 .. MaxN] of LongInt;
        heap, toheap : Array[1 .. MaxN] of LongInt;
        col : LongInt;
        _end : Extended;

Procedure Swap(var a, b : LongInt);
var
        c : LongInt;
begin
  c := a;
  a := b;
  b := c;
end;

Procedure MoveUp(a : LongInt);
begin
  While a <> 1 do
  begin
    if dist[heap[a]] < dist[heap[a div 2]] then
    begin
      Swap(heap[a], heap[a div 2]);
      Swap(toheap[heap[a]], toheap[heap[a div 2]]);
      a := a div 2;
    end
    else
      Break;
  end;
end;

Function MinHeap(const a, b : LongInt) : LongInt;
begin
  if b > col then
    MinHeap := a
  else
    if a > col then
      MinHeap := b
    else
      if dist[heap[a]] > dist[heap[b]] then
        MinHeap := b
      else
        MinHeap := a;
end;

Procedure MoveDown(a : LongInt);
var
        t : LongInt;
begin
  While True do
  begin
    t := MinHeap(a * 2, a * 2 + 1);
    if t > col then
      Break;
    if dist[heap[t]] >= dist[heap[a]] then
      Break;
    Swap(toheap[heap[a]], toheap[heap[t]]);
    Swap(heap[a], heap[t]);
    a := t;
  end;
end;

Procedure Add(const a, b, c : LongInt);
begin
  Inc(mm);
  sm[mm].a := a;
  sm[mm].b := b;
  sm[mm].c := c;
end;

Procedure QSort(const l, r : LongInt);
var
        i, j : LongInt;
        x : Word;
begin
  i := l;
  j := r;
  x := sm[(l + r) div 2].a;
  repeat
    While x > sm[i].a do
      Inc(i);
    While sm[j].a > x do
      Dec(j);
    if i <= j then
    begin
      sm[0] := sm[i];
      sm[i] := sm[j];
      sm[j] := sm[0];
      Inc(i);
      Dec(j);
    end;
  until i > j;
  if l < j then
    QSort(l, j);
  if i < r then
    QSort(i, r);
end;


begin
  _end := now + 1.5 / 60 / 60 / 24;
  Assign(input, 'path.in');
  Reset(input);
  Assign(output, 'path.out');
  Rewrite(output);
  ReadLn(n, m);
  for i := 1 to m do
  begin
    ReadLn(a, b, c);
    Add(a, b, c);
    Add(b, a, c);
  end;
  QSort(1, mm);
  col := n;
  for i := 1 to n do
  begin
    heap[i] := i;
    toheap[i] := i;
  end;
  for i := 1 to n do
    dist[i] := 30000*10000;
  dist[1] := 0;
  col := n;
  FillChar(used, SizeOf(used), False);
  for i := mm downto 1 do
    uk[sm[i].a] := i;
  for i := 1 to n do
  begin
    if (i mod 500 = 0) and (now > _end) then
      Break;
    m := heap[1];
{    m := 1;
    for j := 1 to n do
      if not used[j] then
        if (used[m]) or (dist[m] > dist[j]) then
          m := j;}
    used[m] := True;
    ist[m] := dist[m];
    dist[m] := 1000000000;
    MoveDown(1);
    l := uk[m];
    While sm[l].a = m do
    begin
      if (not used[sm[l].b]) and (dist[sm[l].b] > ist[m] + sm[l].c) then
      begin
        dist[sm[l].b] := ist[m] + sm[l].c;
        MoveUp(toheap[sm[l].b]);
      end;
      Inc(l);
    end;
  end;
  for i := 1 to n do
    Write(ist[i], ' ');
  Close(output);
  Close(input);
end.
