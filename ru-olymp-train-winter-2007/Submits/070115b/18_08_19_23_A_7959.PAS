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
        list : Array[0 .. 200000] of LongInt;

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

begin
  Assign(input, 'bridges.in');
  Reset(input);
  Assign(output, 'bridges.out');
  Rewrite(output);
  ReadLn(n, m);
  for i := 1 to m do
  begin
    ReadLn(a, b);
    Add(a, b, i);
    Add(b, a, i);
  end;
  a := 0;
  DFS(1, 0, 0);
  for i := 0 to list[0] do
    WriteLn(list[i]);
  Close(output);
  Close(input);
end.
