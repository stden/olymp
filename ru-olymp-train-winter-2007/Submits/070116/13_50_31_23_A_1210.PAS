{$I-,Q-,R-,S-}
{$M $1000000}
uses
        SysUtils;
const
        MaxN = 100;
type
        PSm = ^TSm;
        TSm =
        record
          b : LongInt;
          next : PSm;
        end;
var
        sm1, sm2 : Array[1 .. MaxN] of PSm;
        u1, u2 : Array[1 .. MaxN] of Boolean;
        Drez, DUsed, ocan : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
        rrr : Array[1 .. MaxN] of LongInt;
        m, n : LongInt;
        e : Extended;


Procedure Add(var a : PSm; const b : LongInt);
var
        t : PSm;
begin
  t := a;
  New(a);
  a^.b := b;
  a^.next := t;
end;

Procedure Init;
var
        i, a, b : LongInt;
begin
  ReadLn(m);
  for i := 1 to m - 1 do
  begin
    Read(a, b);
    Add(sm1[a], b);
    Add(sm1[b], a);
  end;
  ReadLn(n);
  for i := 1 to n - 1 do
  begin
    Read(a, b);
    Add(sm2[a], b);
    Add(sm2[b], a);
  end;
end;

var
        mused : Array[1 .. MaxN] of Boolean;
        p : Array[1 .. MaxN] of LongInt;

Function DFS2(const v, m : LongInt) : Boolean;
var
        i : LongInt;
begin
  if mused[v] then
  begin
    DFS2 := False;
    Exit;
  end;
  mused[v] := True;
  for i := 1 to m do
    if ocan[v][i] then
    begin
      if p[i] = 0 then
      begin
        p[i] := v;
        DFS2 := True;
        Exit;
      end
      else
      begin
        if DFS2(p[i], m) then
        begin
          p[i] := v;
          DFS2 := True;
          Exit;
        end;
      end;
    end;
  DFS2 := False;
end;

Function Pair(const n, m : LongInt) : Boolean;
var
        i : LongInt;
begin
  FillChar(p, SizeOf(p), 0);
  for i := 1 to n do
  begin
    FillChar(mused, SizeOf(mused), False);
    if not DFS2(i, m) then
    begin
      Pair := False;
      Exit;
    end;
  end;
  Pair := True;
end;

Function DFS(const a, b, pa, pb : LongInt) : Boolean;
var
        t1, t2 : PSm;
        i, j : LongInt;
        mycan : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
begin
  if not DUsed[a][b] then
  begin
    DUsed[a][b] := True;
    t1 := sm1[a];
    i := 0;
    j := 0;
    While t1 <> nil do
    begin
      if t1^.b <> pa then
      begin
        Inc(i);
        j := 0;
        t2 := sm2[b];
        While t2 <> nil do
        begin
          if t2^.b <> pb then
          begin
            Inc(j);
            mycan[i][j] := DFS(t1^.b, t2^.b, a, b);
          end;
          t2 := t2^.next;
        end;
      end;
      t1 := t1^.next;
    end;
    ocan := mycan;
    DRez[a][b] := Pair(i, j);
  end;
  DFS := DRez[a][b];
end;

Procedure GetAns(const a, b, pa, pb : LongInt);
var
        i, j : LongInt;
        t1, t2 : PSm;
        mycan : Array[1 .. MaxN, 1 .. MaxN] of Boolean;
        deba, debb, MYP : Array[1 .. MaxN] of LongInt;
begin
  rrr[a] := b;
  t1 := sm1[a];
  i := 0;
  j := 0;
  While t1 <> nil do
  begin
    if t1^.b <> pa then
    begin
      Inc(i);
      deba[i] := t1^.b;
      j := 0;
      t2 := sm2[b];
      While t2 <> nil do
      begin
        if t2^.b <> pb then
        begin
          Inc(j);
          debb[j] := t2^.b;
          mycan[i][j] := DFS(t1^.b, t2^.b, a, b);
        end;
        t2 := t2^.next;
      end;
    end;
    t1 := t1^.next;
  end;
  ocan := mycan;
  Pair(i, j);
  myp := p;
  for i := 1 to j do
    if myp[i] <> 0 then
      GetAns(deba[myp[i]], debb[i], a, b);
end;

Procedure Solve;
var
        i, j : LongInt;
begin
  for i := 1 to n do
  begin
    if now > e then
      Break;
    FillChar(dused, SizeOf(dused), False);
    if DFS(1, i, 0, 0) then
    begin
      WriteLn('YES');
      GetAns(1, i, 0, 0);
      for j := 1 to m do
        Write(rrr[j], ' ');
      Exit;
    end;
  end;
  Write('NO');
end;

begin
  e := now + 1.5 / 60 / 60 / 24;
  Assign(input, 'map.in');
  Reset(input);
  Assign(output, 'map.out');
  Rewrite(output);
  Init;
  if n > 100 then
    Write('NO')
  else
    Solve;
  Close(input);
  Close(output);
end.
