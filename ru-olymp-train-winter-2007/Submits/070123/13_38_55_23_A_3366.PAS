const
        MaxN = 10000;
        Cif : Set of Char = ['0' .. '9'];
type
        LongInt = Int64;
        TCep =
        record
          a : Array[0 .. MaxN] of LongInt;
          k, n : LongInt;
        end;
        TPoly =
        record
          a, b : LongInt;
        end;
        TSqrt =
        record
          a, b, c, d : LongInt;
          //(a*Sqrt(b)+c)/d
        end;
var
  a, b : TCep;

Procedure ReadCep(var c : TCep);
var
        ch : Char;
begin
  with c do
  begin
    n := -1;
    k := -1;
    Read(ch);
    While not SeekEoLn do
    begin
      While not (ch in Cif) do
      begin
        if ch = '(' then
          k := n;
        if ch = ']' then
          Break;
        Read(ch);
      end;
      if ch = ']' then
        Break;
      Inc(n);
      a[n] := 0;
      While ch in Cif do
      begin
        a[n] := a[n] * 10 + Ord(ch) - Ord('0');
        Read(ch);
      end;
    end;
  end;
  ReadLn;
end;

Procedure WriteCep(const c : TCep);
var
        i : Integer;
begin
  if c.n = 0 then
  begin
    Write('[', c.a[0], ']');
    Exit;
  end;
  with c do
  begin
    Write('[');
    Write(a[0], ';');
    if k <> -1 then
    begin
      for i := 1 to k do
        Write(a[i], ',');
      Write('(');
      for i := k + 1 to n - 1 do
        Write(a[i], ',');
      Write(a[n]);
      Write(')]');
    end
    else
    begin
      for i := 1 to n - 1 do
        Write(a[i], ',');
      Write(a[n], ']');
    end;
    WriteLn;
  end;
end;

Function Mul(const a, b : TPoly) : TPoly;
var
  c : TPoly;
begin
  c.a := a.a * b.b + a.b * b.a;
  c.b := a.b * b.b;
  Mul := c;
end;

Function Add(const a, b : TPoly) : TPoly;
var
  c : TPoly;
begin
  c.a := a.a + b.a;
  c.b := a.b + b.b;
  Add := c;
end;

Procedure Swap(var a, b : TPoly);
var
  c : TPoly;
begin
  c := a;
  a := b;
  b := c;
end;

Function ToPoly(const a : LongInt) : TPoly;
var
  c : TPoly;
begin
  c.a := 0;
  c.b := a;
  ToPoly := c;
end;

Function Rotate(const a : TSqrt) : TSqrt;
var
  rez : TSqrt;
begin
  rez.a := a.a * a.d;
  rez.b := a.b;
  rez.c := -a.c * a.d;
  rez.d := a.a * a.a * a.b - a.c * a.c;
  Rotate := rez;
end;

Function AddSqrt(const a : TSqrt; const b : LongInt) : TSqrt;
var
  rez : TSqrt;
begin
  rez := a;
  rez.c := rez.c + b * rez.d;
  AddSqrt := rez;
end;

Procedure AntiSqrt(var rez : TSqrt);
var
  i : Integer;
begin
  for i := 2 to Abs(rez.b) do
    if i * i > Abs(rez.b) then
      Break
    else
    begin
      While Abs(rez.b) mod (i * i) = 0 do
      begin
        rez.b := rez.b div (i * i);
        rez.a := rez.a * i;
      end;
    end;
end;

Function NOD(a, b : LongInt) : LongInt;
begin
  While (a <> 0) and (b <> 0) do
    if a > b then
      a := a mod b
    else
      b := b mod a;
  NOD := a + b;
end;

Procedure Sokr(var rez : TSqrt);
var
  q : LongInt;
begin
  q := Abs(rez.a);
  q := NOD(q, Abs(rez.c));
  q := NOD(q, Abs(rez.d));
  rez.a := rez.a div q;
  rez.c := rez.c div q;
  rez.d := rez.d div q;
end;

Function GetZn(c : TCep) : TSqrt;
var
  chisl, znam : TPoly;
  i : Integer;
  aa, bb, cc, Discr : LongInt;
  rez : TSqrt;
begin
  chisl.a := 0;
  chisl.b := 1;
  znam.a := 1;
  znam.b := 0;
  if c.k  = -1 then
  begin
    c.k := c.n - 1;
    rez.a := 0;
    rez.b := 0;
    rez.c := c.a[c.n];
    rez.d := 1;
  end
  else
  begin
    for i := c.n downto c.k + 1 do
    begin
      chisl := Add(chisl, Mul(ToPoly(c.a[i]), znam));
      if i <> c.k + 1 then
        Swap(chisl, znam);
    end;
    aa := znam.a;
    bb := znam.b - chisl.a;
    cc := -chisl.b;
    Discr := bb * bb - 4 * aa * cc;
    rez.a := 1;
    rez.b := Discr;
    rez.c := -bb;
    rez.d := 2 * aa;
    AntiSqrt(rez);
  end;
  for i := c.k downto 0 do
  begin
    rez := Rotate(rez);
    rez := AddSqrt(rez, c.a[i]);
    Sokr(rez);
  end;
  Sokr(rez);
//  WriteLn('(', rez.c, '+', rez.a , '* SQRT(', rez.b, '))/', rez.d);
  GetZn := rez;
//  WriteLn('(', -bb, '+SQRT(', Discr, '))/', 2 * aa);
end;

Function Eq(const a, b : TSqrt) : Boolean;
begin
  Eq := (a.a = b.a) and (a.b = b.b) and (a.c = b.c) and (a.d = b.d);
end;

Procedure WriteSqrt(const rez : TSqrt);
begin
  WriteLn('(', rez.c, '+', rez.a , '* SQRT(', rez.b, '))/', rez.d);
end;

var
  results : Array[1 .. MaxN] of TSqrt;
  wr : TCep;

Procedure Solve(a, b : TSqrt);
var
  rez : TSqrt;
  tek : LongInt;
  i, j : Integer;
begin
  if a.b = 0 then
  begin
    a.b := b.b;
    a.a := 0;
  end;
  if b.b = 0 then
  begin
    b.b := a.b;
    b.a := 0;
  end;
  if a.b <> b.b then
    WriteLn('Impossible')
  else
  begin
    rez.a := a.a * b.d + a.d * b.a;
    rez.b := a.b;
    rez.c := a.c * b.d + a.d * b.c;
    rez.d := a.d * b.d;
    Sokr(rez);
    results[1] := rez;
    wr.k := -1;
    wr.n := -1;
    for i := 1 to MaxN - 1 do
    begin
      tek := Trunc(1e-6 + (results[i].a * Sqrt(results[i].b) + results[i].c) / results[i].d);
      wr.a[i - 1] := tek;
      Inc(wr.n);
      results[i + 1] := Rotate(AddSqrt(results[i], -tek));
      if (results[i + 1].d = 0) then
      begin
        WriteCep(wr);
        Exit;
      end;
      if (results[i + 1].a * results[i + 1].b = 0) and (results[i + 1].c = 0) then
      begin
        WriteCep(wr);
        Exit;
      end;
      for j := 1 to i do
        if Eq(results[i + 1], results[j]) then
        begin
          wr.k := j - 2;
          While (wr.a[wr.k] = wr.a[wr.n]) and (wr.k > 0) do
          begin
            Dec(wr.k);
            Dec(wr.n);
          end;
          WriteCep(wr);
          Exit;
        end;
      Sokr(results[i + 1]);
    end;
{    for i := 1 to MaxN - 1 do
      WriteSqrt(results[i]);
    WriteLn('SUCKS');}
  end;
end;


begin
  Assign(input, 'aplusb.in');
  Reset(input);
  Assign(output, 'aplusb.out');
  Rewrite(output);
  ReadCep(a);
  ReadCep(b);
  Solve(GetZn(a), GetZn(b));
{  WriteCep(a);
  WriteCep(b);}
  Close(input);
  Close(output);
end.
