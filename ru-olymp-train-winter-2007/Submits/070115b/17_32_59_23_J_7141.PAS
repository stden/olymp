  {$I-,Q-,R-,S-}
const
        MaxN = 30000;
type
        TP = ^TT;
        TT =
        record
          b, c : LongInt;
          next : TP;
        end;
var
        used : Array[1 .. MaxN] of Boolean;
        a, b, c, n, m, i, j : LongInt;
        sm : Array[1 .. MaxN] of TP;
        dist, ist : Array[1 .. MaxN] of LongInt;
        heap, toheap : Array[1 .. MaxN] of LongInt;
        col : LongInt;

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
    t := 1;
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
var
        t : TP;
begin
  t := sm[a];
  New(sm[a]);
  sm[a]^.next := t;
  sm[a]^.b := b;
  sm[a]^.c := c;
end;

begin
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
  for i := 1 to n do
  begin
    m := heap[1];
    used[m] := True;
    ist[m] := dist[m];
    dist[m] := 1000000000;
    MoveDown(1);
    While sm[m] <> nil do
    begin
      if (dist[sm[m]^.b] > ist[m] + sm[m]^.c) and (not used[sm[m]^.b]) then
      begin
        dist[sm[m]^.b] := ist[m] + sm[m]^.c;
        MoveUp(toheap[sm[m]^.b]);
      end;
      sm[m] := sm[m]^.next;
    end;
  end;
  for i := 1 to n do
    Write(ist[i], ' ');
  Close(output);
  Close(input);
end.