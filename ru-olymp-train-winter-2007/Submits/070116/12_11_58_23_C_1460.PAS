const
        MaxN = 50000;
type
        TP = ^TT;
        TT =
        record
          b : LongInt;
          next : TP;
        end;
var
        sm : Array[1 .. MaxN] of TP;
        rez : Array[1 .. MaxN] of LongInt;
        aa, bb : Array[1 .. MaxN] of LongInt;
        n, k : LongInt;

Procedure Add(const a, b : LongInt);
var
        t : TP;
begin
  t := sm[a];
  New(sm[a]);
  sm[a]^.b := b;
  sm[a]^.next := t;
end;

Procedure Init;
var
        i, a, b : LongInt;
begin
  ReadLn(n);
  for i := 1 to n - 1 do
  begin
    Read(a, b);
    Add(a, b);
    Add(b, a);
  end;
  k := 0;
end;

Procedure AddEdge(const a, b : LongInt);
begin
  Inc(k);
  aa[k] := a;
  bb[k] := b;
end;

Function DFS(const v, pred : LongInt) : LongInt;
var
        t : TP;
        p : LongInt;
begin
  if rez[v] = 0 then
  begin
    t := sm[v];
    p := 0;
    While t <> nil do
    begin
      if t^.b <> pred then
      begin
        if p = 0 then
          p := DFS(t^.b, v)
        else
        begin
          AddEdge(p, DFS(t^.b, v));
          p := 0;
        end;
      end;
      t := t^.next;
    end;
    if p <> 0 then
      rez[v] := p
    else
      rez[v] := v;
  end;
  DFS := rez[v];
end;

Procedure Solve;
var
        t : TP;
        p : LongInt;
begin
  t := sm[1];
  p := 0;
  While t <> nil do
  begin
    if p = 0 then
      p := DFS(t^.b, 1)
    else
    begin
      AddEdge(p, DFS(t^.b, 1));
      p := 0;
    end;
    t := t^.next;
  end;
  if p <> 0 then
    AddEdge(p, 1);
end;

Procedure Print;
var
        i : LongInt;
begin
  WriteLn(k);
  for i := 1 to k do
    WriteLn(aa[i], ' ', bb[i]);
end;

begin
  Assign(input, 'biconn.in');
  Reset(input);
  Assign(output, 'biconn.out');
  Rewrite(output);
  Init;
  Solve;
  Print;
  Close(input);
  Close(output);
end.
