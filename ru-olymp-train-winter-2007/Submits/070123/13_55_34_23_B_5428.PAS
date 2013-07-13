const
  MaxN = 100000;
type
  PSm = ^TSm;
  TSm =
  record
    b : LongInt;
    next :  PSm;
  end;
var
  sm : Array[1 .. MaxN] of PSm;
  n : LongInt;
//  l, r : LongInt;
  p1, p2{, pred2, pred1} : Array[1 .. MaxN] of LongInt;
{  bfs : Array[1 .. MaxN] of
  record
    i : LongInt;
    left : Boolean;
  end;}
  used : Array[1 .. MaxN] of Boolean;

Procedure Add(const a, b : LongInt);
var
  t : PSm;
begin
  t := sm[a];
  New(sm[a]);
  sm[a]^.b := b;
  sm[a]^.next := t;
end;

Procedure Init;
var
  i, j, k, t : LongInt;
begin
  Assign(input, 'omax.in');
  Reset(input);
  ReadLn(n);
  for i := 1 to n do
  begin
    Read(k);
    for j := 1 to k do
    begin
      Read(t);
      Add(i, t);
    end;
  end;
  Close(input);
end;

{Procedure DFS(const v : LongInt; const left : Boolean);
begin
  WriteLn(v, ' ', left);
  if v = -1 then
    Exit;
  if left then
  begin
    DFS(pred1[v], False);
    p1[v] := pred1[v];
    p2[pred1[v]] := v;
  end
  else
  begin
    DFS(pred2[v], True);
    p2[v] := pred2[v];
    p1[pred2[v]] := v;
  end;
end;

Procedure AddToBFS(const i, pred : LongInt; const left : Boolean);
begin
  if ((left) and (used1[i])) or ((not left) and (used2[i])) then
    Exit;
  if left then
    used1[i] := True
  else
    used2[i] := True;
  Inc(r);
  bfs[r].i := i;
  bfs[r].left := left;
  if left then
    pred1[i] := pred
  else
    pred2[i] := pred;
end;

Function Potok : Boolean;
var
  i : LongInt;
  t : PSm;
begin
  FillChar(used1, SizeOf(used1), False);
  FillChar(used2, SizeOf(used2), False);
  FillChar(pred1, SizeOf(pred1), 0);
  FillChar(pred2, SizeOf(pred2), 0);
  l := 1;
  r := 0;
  for i := 1 to n do
    if p1[i] = 0 then
      AddToBFS(i, -1, True);
  While l <= r do
  begin
    if bfs[l].left then
    begin
      t := sm[bfs[l].i];
      While t <> nil do
      begin
        AddToBFS(t^.b, bfs[l].i, False);
        t := t^.next;
      end;
    end
    else
    begin
      if p2[bfs[l].i] <> 0 then
        AddToBFS(p2[bfs[l].i], bfs[l].i, True);
    end;
    Inc(l);
  end;
  Potok := False;
  for i := 1 to n do
    if (p2[i] = 0) and (used2[i]) then
    begin
      Potok := True;
      DFS(i, False);
    end;
end;
}
Function IMBI(const i : LongInt) : Boolean;
var
  t : PSm;
begin
  if used[i] then begin
    IMBI := False; Exit; end;
  used[i] := True;
  t := sm[i];
  While t <> nil do
  begin
    if (p2[t^.b] = 0) or (IMBI(p2[t^.b])) then
    begin
      IMBI := True;
      p2[t^.b] := i;
      p1[i] := t^.b;
      Exit;
    end;
    t := t^.next;
  end;
  IMBI := False;
end;

Function WWW(const f, i : LongInt) : Boolean;
var
  t : PSm;
begin
  if (used[i]) and (i = f) then
  begin
    WWW := True;
    Exit;
  end;
  if used[i] then
  begin
    WWW := False;
    Exit;
  end;
  used[i] := True;
  t := sm[i];
  While t <> nil do
  begin
    if (WWW(f, p2[t^.b])) and (t^.b <> p1[i]) then
    begin
      WWW := True;
      Exit;
    end;
    t := t^.next;
  end;
  WWW := False;
end;

Procedure Solve;
var
  i : LongInt;
begin
  FillChar(p1, SizeOf(p1), False);
  FillChar(p2, SizeOf(p2), False);
  for i := n downto 1 do
  begin
    FillChar(used, SizeOf(used), False);
    if not IMBI(i) then
    begin
      Write('NO');
      Exit;
    end;
  end;
  FillChar(used, SizeOf(used), False);
  for i := 1 to n do
  begin
    FillChar(used, SizeOf(used), False);
    if WWW(i, i) then
    begin
      Write('NO');
      Exit;
    end;
  end;
  Write('YES');
  for i := 1 to n do
    Write(p1[i], ' ');
end;

begin
  Init;
  Assign(output, 'omax.out');
  Rewrite(output);
  Solve;
  Close(output);
end.
