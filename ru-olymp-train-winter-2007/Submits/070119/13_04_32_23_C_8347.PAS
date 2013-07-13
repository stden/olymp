const
        MaxN = 100000;
type
        PSm = ^TSm;
        TSm =
        record
          b : LongInt;
          next : PSm;
        end;
var
        sm, inv : Array[1 .. MaxN] of PSm;
        n, m : LongInt;

Procedure Init;
var
        i, a, b : LongInt;
        t : PSm;
begin
  ReadLn(n, m);
  for i := 1 to m do
  begin
    Read(a, b);
    t := sm[a];
    New(sm[a]);
    sm[a]^.next := t;
    sm[a]^.b := b;
  end;
end;

var
        used : Array[1 .. MaxN] of Boolean;
        list : Array[0 .. MaxN] of LongInt;
        col : LongInt;
        par, predst, _out, _in, p, q : Array[1 .. MaxN] of LongInt;

Procedure DFS1(const v : LongInt);
var
        t : PSm;
begin
  if used[v] then
    Exit;
  used[v] := True;
  t := sm[v];
  While t <> nil do
  begin
    DFS1(t^.b);
    t := t^.next;
  end;
  Inc(list[0]);
  list[list[0]] := v;
end;

Function Parent(const a : LongInt) : LongInt;
begin
  if par[a] <> a then
    par[a] := Parent(par[a]);
  Parent := par[a];
end;

Procedure Union(const a, b : LongInt);
begin
  par[Parent(a)] := Parent(b);
end;

Procedure DFS2(const v : LongInt);
var
        t : PSm;
begin
  used[v] := True;
  t := sm[v];
  While t <> nil do
  begin
    if not used[t^.b] then
    begin
      Union(v, t^.b);
      DFS2(t^.b);
    end;
    t := t^.next;
  end;
end;

Procedure Add(const a, b : LongInt);
begin
  Inc(col);
  p[col] := a;
  q[col] := b;
end;

Procedure Solve;
var
        i : LongInt;
        t, tt : PSm;
begin
  FillChar(used, SizeOf(used), False);
  list[0] := 0;
  for i := 1 to n do
    DFS1(i);
  FillChar(used, SizeOf(used), False);
  for i := 1 to n do
    par[i] := i;
  for i := 1 to list[0] do
    DFS2(list[i]);
  for i := 1 to n do
    Parent(i);
  FillChar(_out, SizeOf(_out), 0);
  FillChar(predst, SizeOf(predst), 0);
  FillChar(_in, SizeOf(_in), 0);
  for i := 1 to n do
  begin
    predst[par[i]] := i;
    t := sm[i];
    While t <> nil do
    begin
      if par[t^.b] <> par[i] then
      begin
        Inc(_out[par[i]]);
        Inc(_in[par[t^.b]]);
      end;
      t := t^.next;
    end;
  end;
  for i := 1 to n do
    if (predst[i] <> 0) and (i <> par[1]) then
    begin
      if _in[i] = 0 then
        Add(1, predst[i]);
      if _out[i] = 0 then
        Add(predst[i], 1);
    end;
  WriteLn(col);
  for i := 1 to col do
    WriteLn(p[i], ' ', q[i]);
end;

begin
  Assign(input, 'republic.in');
  Reset(input);
  Assign(output, 'republic.out');
  Rewrite(output);
  Init;
  Solve;
  Close(input);
  Close(output);
end.
