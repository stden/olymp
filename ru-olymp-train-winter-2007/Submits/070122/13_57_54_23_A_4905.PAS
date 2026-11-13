const
        MaxN = 1000;
type
        PList = ^TList;
        TList =
        record
          b, num : LongInt;
          next : PList;
        end;
        TRez =
        record
          a, b : LongInt;
        end;
var
        n1, n2, m, col : LongInt;
        sm : Array[1 .. MaxN] of PList;
        p1, p2, e1, e2, rrr, rrr2 : Array[1 .. MaxN] of LongInt;
        used : Array[1 .. MaxN] of Boolean;

        ans : Array[1 .. MaxN * MaxN] of TRez;
        zapr1, zapr2, zapr3, zapr4 : LongInt;

Procedure Add(const a, b, num : LongInt);
var
        t : PList;
begin
  t := sm[a];
  New(sm[a]);
  sm[a]^.next := t;
  sm[a]^.b := b;
  sm[a]^.num := num;
end;

Procedure Init;
var
        i, a, b : LongInt;
begin
  ReadLn(n1, n2, m);
  FillChar(ans, SizeOf(ans), False);
  for i := 1 to m do
  begin
    Read(a, b);
    Add(a, b, i);
  end;
end;

Function DFS(const v : LongInt) : Boolean;
var
        t : PList;
begin
  if used[v] then
  begin
    DFS := False;
    Exit;
  end;
  used[v] := True;
  t := sm[v];
  While t <> nil do
  begin
    if p2[t^.b] = 0 then
    begin
      p2[t^.b] := v;
      p1[v] := t^.b;
      rrr[v] := t^.num;
      DFS := True;
      Exit;
    end
    else
    begin
      if DFS(p2[t^.b]) then
      begin
        p2[t^.b] := v;
        p1[v] := t^.b;
        rrr[v] := t^.num;
        DFS := True;
        Exit;
      end;
    end;
    t := t^.next;
  end;
  DFS := False;
end;

Function DFS2(const v : LongInt) : Boolean;
var
        t : PList;
begin
  if used[v] then
  begin
    DFS2 := False;
    Exit;
  end;
  used[v] := True;
  t := sm[v];
  While t <> nil do
  begin
    if (v <> zapr1) or (t^.b <> zapr2) then
    begin
      if p2[t^.b] = 0 then
      begin
        p2[t^.b] := v;
        p1[v] := t^.b;
        rrr[v] := t^.num;
        DFS2 := True;
        Exit;
      end
      else
      begin
        if DFS2(p2[t^.b]) then
        begin
          p2[t^.b] := v;
          p1[v] := t^.b;
          rrr[v] := t^.num;
          DFS2 := True;
          Exit;
        end;
      end;
    end;
    t := t^.next;
  end;
  DFS2 := False;
end;

Function Can(const v : LongInt) : Boolean;
var
        t : PList;
begin
  if used[v] then
  begin
    Can := False;
    Exit;
  end;
  used[v] := True;
  t := sm[v];
  While t <> nil do
  begin
    if ((v <> zapr1) or (t^.b <> zapr2)) and ((v <> zapr3) or (t^.b <> zapr4)) then
    begin
      if p2[t^.b] = 0 then
      begin
        CAN := True;
        Exit;
      end
      else
      begin
        if CAN(p2[t^.b]) then
        begin
          CAN := True;
          Exit;
        end;
      end;
    end;
    t := t^.next;
  end;
  CAN := False;
end;

Procedure Match;
var
        i : LongInt;
begin
  for i := 1 to n1 do
  begin
    FillChar(used, SizeOf(used), False);
    DFS(i);
  end;
end;

Procedure Add(const a, b : LongInt);
begin
  Inc(col);
  if a < b then
  begin
    ans[col].a := a;
    ans[col].b := b;
  end
  else
  begin
    ans[col].a := b;
    ans[col].b := a;
  end;
end;

Function Count3 : Boolean;
var
        i : LongInt;
begin
  FillChar(used, SizeOf(used), False);
  for i := 1 to n1 do
    if p1[i] = 0 then
      if Can(i) then
      begin
        Count3 := True;
        Exit;
      end;
  Count3 := False;
end;

Procedure Count2(const deleted : LongInt);
var
        i, e : LongInt;
begin
  for i := 1 to n1 do
    if p1[i] <> 0 then
    begin
      e := p1[i];
      p1[i] := 0;
      p2[e] := 0;
      zapr3 := i;
      zapr4 := e;
      if not Count3 then
        Add(deleted, rrr[i]);
      zapr3 := 0;
      zapr4 := 0;
      p1[i] := e;
      p2[e] := i;
    end;
end;

Procedure Count(const deleted : LongInt);
var
        i, tcount : LongInt;
        t : PList;
begin
  e1 := p1;
  e2 := p2;
  rrr2 := rrr;
  FillChar(used, SizeOf(used), False);
  for tcount := 1 to n1 do
    if p1[tcount] = 0 then
      if DFS2(tcount) then
      begin
        Count2(deleted);
        p1 := e1;
        p2 := e2;
        rrr := rrr2;
        Exit;
      end;
  for i := 1 to n1 do
  begin
    t := sm[i];
    While t <> nil do
    begin
      Add(t^.b, deleted);
      t := t^.next;
    end;
  end;
end;

Procedure Solve;
var
        i, e : LongInt;
begin
  Match;
  for i := 1 to n1 do
    if p1[i] <> 0 then
    begin
      e := p1[i];
      p1[i] := 0;
      p2[e] := 0;
      zapr1 := i;
      zapr2 := e;
      Count(rrr[i]);
      zapr1 := 0;
      zapr2 := 0;
      p2[e] := i;
      p1[i] := e;
    end;
end;

Function More(const a, b : TRez) : Boolean;
begin
  More := (a.a > b.a) or ((a.a = b.a) and (a.b > b.b));
end;

Procedure Swap(var a, b : TRez);
var
        c : TRez;
begin
  c := a;
  a := b;
  b := c;
end;

Procedure QSort(const l, r : LongInt);
var
        i, j : LongInt;
        x : TRez;
begin
  i := l;
  j := r;
  x := ans[(l + r) div 2];
  repeat
    While More(x, ans[i]) do
      Inc(i);
    While More(ans[j], x) do
      Dec(j);
    if i <= j then
    begin
      Swap(ans[i], ans[j]);
      Inc(i);
      Dec(j);
    end;
  until i > j;
end;

Procedure Print;
var
        i, rez : Longint;
begin
  if col > 0 then
    rez := 1
  else
    rez := 0;
  for i := 2 to col do
    if More(ans[i], ans[i - 1]) or More(ans[i - 1], ans[i]) then
      Inc(rez);
  WriteLn(rez);
end;

begin
  Assign(input, 'pairs.in');
  Reset(input);
  Assign(output, 'pairs.out');
  Rewrite(output);
  Init;
  Solve;
  if col <> 0 then
    QSort(1, col);
  Print;
  Close(input);
  Close(output);
end.