const
        MaxN = 30000;
type
        TP = ^TT;
        TT =
        record
          b : Word;
          n : LongInt;
          next : TP;
        end;
var
        n, m, i, a, b : LongInt;
        sm : Array[1 .. MaxN] of TP;
        f, t : Array[1 .. MaxN] of LongInt;
        used : Array[1 .. MaxN] of Boolean;
        list : Array[-1 .. 200000] of LongInt;

Procedure DFS(const v, pred, reb : LongInt);
var
        s : TP;
begin
  s := sm[v];
  Inc(a);
  t[v] := a;
  f[v] := a;
  used[v] := True;
  While s <> nil do
  begin
    if s^.b <> pred then
    begin
      if not used[s^.b] then
        DFS(s^.b, v, s^.n);
      if f[s^.b] < f[v] then
        f[v] := f[s^.b];
    end;
    s := s^.next;
  end;
  if (v <> 1) and (f[v] >= t[v]) then
  begin
    Inc(list[0]);
    list[list[0]] := reb;
  end;
end;

Procedure Add(const a, b, i : LongInt);
var
        t : TP;
begin
  t := sm[a];
  New(sm[a]);
  sm[a]^.next := t;
  sm[a]^.b := b;
  sm[a]^.n := i;
end;

Procedure QSort(const l, r : LongInt);
var
        i, j, x : LongInt;
begin
  i := l;
  j := r;
  x := list[(l + r) div 2];
  repeat
    While list[i] < x do
      Inc(i);
    While list[j] > x do
      Dec(j);
    if i <= j then
    begin
      list[-1] := list[i];
      list[i] := list[j];
      list[j] := list[-1];
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
  Assign(input, 'bridges.in');
  Reset(input);
  Assign(output, 'bridges.out');
  Rewrite(output);
  Read(n, m);
  for i := 1 to m do
  begin
    Read(a, b);
    Add(a, b, i);
    Add(b, a, i);
  end;
  a := 0;
  DFS(1, 0, 0);
  QSort(1, list[0]);
  for i := 0 to list[0] do
    WriteLn(list[i]);
  Close(output);
  Close(input);
end.
