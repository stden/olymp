uses
        BinSearch;
const
        MaxN = 100;
        Inf = 1000000000;
var
        n, l, r : LongInt;
        a1, a2, lie : Boolean;

Function Min(const a, b : LongInt) : LongInt;
begin
  if a < b then
    Min := a
  else
    Min := b;
end;

Function Max(const a, b : LongInt) : LongInt;
begin
  if a > b then
    Max := a
  else
    Max := b;
end;

Function Dif(a, b : LongInt) : LongInt;
var
        rez : LongInt;
begin
  rez := 0;
  While (a <> 0) or (b <> 0) do
  begin
    if a mod 2 <> b mod 2 then
      Inc(rez);
    a := a div 2;
    b := b div 2;
  end;
  Dif := rez;
end;

Function Q(a : LongInt; const l : LongInt) : String;
var
        i : LongInt;
        s : String;
begin
  s := '';
  for i := 1 to l do
  begin
    if a mod 2 = 0 then
      s := '0 ' + s
    else
      s := '1 ' + s;
    a := a div 2;
  end;
  Q := s;
end;

{Procedure Che;
const
        MaxMax = 63;
var
        a, b, c, d, e, f, g, h : LongInt;
begin
  for a := 0 to MaxMax do
  if a = 7 then
    for b := a to MaxMax do
    if Dif(a, b) >= 3 then
      for c := b to MaxMax do
      if (Dif(a, c) >= 3) and (Dif(b, c) >= 3) then
        for d := c to MaxMax do
          if (Dif(a, d) >= 3) and (Dif(b, d) >= 3) and (Dif(c, d) >= 3) then
          for e := d to MaxMax do
            if (Dif(a, e) >= 3) and (Dif(b, e) >= 3) and (Dif(c, e) >= 3) and (Dif(d, e) >= 3) then
            for f := e to MaxMax do
              if (Dif(a, f) >= 3) and (Dif(b, f) >= 3) and (Dif(c, f) >= 3) and (Dif(d, f) >= 3) and (Dif(e, f) >= 3) then
              for g := f to MaxMax do
                if (Dif(a, g) >= 3) and (Dif(b, g) >= 3) and (Dif(c, g) >= 3) and (Dif(d, g) >= 3) and (Dif(e, g) >= 3) and (Dif(f, g) >= 3) then
                for h := g to MaxMax do
                  if (Dif(a, h) >= 3) and (Dif(b, h) >= 3) and (Dif(c, h) >= 3) and (Dif(d, h) >= 3) and (Dif(e, h) >= 3) and (Dif(f, h) >= 3) and (Dif(g, h) >= 3) then
                  if (a mod 8 <> b mod 8) and
                     (a mod 8 <> c mod 8) and
                     (a mod 8 <> d mod 8) and
                     (a mod 8 <> e mod 8) and
                     (a mod 8 <> f mod 8) and
                     (a mod 8 <> g mod 8) and
                     (a mod 8 <> h mod 8) and
                     (b mod 8 <> c mod 8) and
                     (b mod 8 <> d mod 8) and
                     (b mod 8 <> e mod 8) and
                     (b mod 8 <> f mod 8) and
                     (b mod 8 <> g mod 8) and
                     (b mod 8 <> h mod 8) and
                     (c mod 8 <> d mod 8) and
                     (c mod 8 <> e mod 8) and
                     (c mod 8 <> f mod 8) and
                     (c mod 8 <> g mod 8) and
                     (c mod 8 <> h mod 8) and
                     (d mod 8 <> e mod 8) and
                     (d mod 8 <> f mod 8) and
                     (d mod 8 <> g mod 8) and
                     (d mod 8 <> h mod 8) and
                     (e mod 8 <> f mod 8) and
                     (e mod 8 <> g mod 8) and
                     (e mod 8 <> h mod 8) and
                     (f mod 8 <> g mod 8) and
                     (f mod 8 <> h mod 8) and
                     (g mod 8 <> h mod 8) and
                     (a div 8 <> b div 8) and
                     (a div 8 <> c div 8) and
                     (a div 8 <> d div 8) and
                     (a div 8 <> e div 8) and
                     (a div 8 <> f div 8) and
                     (a div 8 <> g div 8) and
                     (a div 8 <> h div 8) and
                     (b div 8 <> c div 8) and
                     (b div 8 <> d div 8) and
                     (b div 8 <> e div 8) and
                     (b div 8 <> f div 8) and
                     (b div 8 <> g div 8) and
                     (b div 8 <> h div 8) and
                     (c div 8 <> d div 8) and
                     (c div 8 <> e div 8) and
                     (c div 8 <> f div 8) and
                     (c div 8 <> g div 8) and
                     (c div 8 <> h div 8) and
                     (d div 8 <> e div 8) and
                     (d div 8 <> f div 8) and
                     (d div 8 <> g div 8) and
                     (d div 8 <> h div 8) and
                     (e div 8 <> f div 8) and
                     (e div 8 <> g div 8) and
                     (e div 8 <> h div 8) and
                     (f div 8 <> g div 8) and
                     (f div 8 <> h div 8) and
                     (g div 8 <> h div 8) then
                  begin
                    WriteLn(Q(a, 6));
                    WriteLn(Q(b, 6));
                    WriteLn(Q(c, 6));
                    WriteLn(Q(d, 6));
                    WriteLn(Q(e, 6));
                    WriteLn(Q(f, 6));
                    WriteLn(Q(g, 6));
                    WriteLn(Q(h, 6));
                    ReadLn;
                  end;
end;}

var
        num : Array[0 .. 20] of LongInt;
const
        MaxMax = 127;

Procedure DFS(const g : LongInt);
var
        i, j : LongInt;
        b : Boolean;
begin
//  if (g = 2) and (num[1] <> 15) then
//    Exit;
  if g > 16 then
  begin
    for i := 1 to 16 do
      WriteLn(Q(num[i], 7));
    ReadLn;
    Exit;
  end;
  for i := num[g - 1] to MaxMax do
  begin
    b := True;
    num[g] := i;
    for j := 1 to g - 1 do
      if (Dif(num[g], num[j]) < 3) then
      begin
        b := False;
        Break;
      end;
    if b then
      DFS(g + 1);
  end;
end;

begin
  n := GetN;
  l := 0;
  r := n + 1;
  lie := True;
  While l <> r - 1 do
  begin
    if lie then
    begin
      a1 := Query((l + r) div 2);
      a2 := Query((l + r) div 2);
      if a1 = a2 then
      begin
        if a1 = False then
          l := (l + r) div 2
        else
          r := (l + r) div 2;
      end
      else
        lie := False;
    end
    else
    begin
      a1 := Query((l + r) div 2);
      if a1 = False then
        l := (l + r) div 2
      else
        r := (l + r) div 2;
    end;
  end;
  Answer(r);
end.