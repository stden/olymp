uses Math;
type digit = array [0..100000] Of Longint;
uk = ^digit;
var
  d1, d2, d3, d4: digit;
  a, b, c: uk;
  n, i, j, ost: Longint;
  ch: char;
procedure swap(var x, y: uk);
var t: uk;
Begin
  t := x;
  x := y;
  y := t;
End;
procedure square(a, b: uk);
var i, j: Longint;
Begin
  Fillchar(b^, sizeof(b^), 0);
  For i := 1 To a^[0] Do
    For j := 1 To a^[0] Do
      Begin
        b^[i+j-1] := a^[i]*a^[j] + b^[i+j-1];
        b^[i+j] := b^[i+j] + (b^[i+j-1] div 10);
        b^[i+j-1] := b^[i+j-1] mod 10;
      End;
  b^[0] := 2*a^[0];
  while (b^[0] > 1) and (b^[b^[0]] = 0) Do dec(b^[0]);
End;
function div3(a: uk): Longint;
var i, ost: Longint;
Begin
  ost := 0;
  for i := a^[0] Downto 1 Do
    Begin
      a^[i] := 10*ost + a^[i];
      ost := a^[i] mod 3;
      a^[i] := a^[i] Div 3;
    End;
  while (a^[0] > 1) and (a^[a^[0]] = 0) Do dec(a^[0]);
  div3 := ost;
End;
procedure mul(a, b: uk; k: Longint);
var i, j: Longint;
Begin
  Fillchar(b^, sizeof(b^), 0);
  For i := 1 To a^[0] Do
    Begin
      b^[i] := b^[i] + a^[i]*k;
      b^[i+1] := b^[i+1] + b^[i] Div 10;
      b^[i] := b^[i] mod 10;
    End;
  b^[0] := a^[0] + 1;
  while (b^[0] > 1) and (b^[b^[0]] = 0) Do dec(b^[0]);
End;
procedure incost(a: uk; k: Longint);
var i: Longint;
Begin
  i := 1;
  a^[1] := a^[1] + k;
  while (a^[i] >= 10) Do
    begin
      a^[i+1] := a^[i+1] + a^[i] Div 10;
      a^[i] := a^[i] mod 10;
      inc(i);
    End;
  a^[0] := max(a^[0], i);
End;
procedure sum(a, b, c: uk);
Var n, i: Longint;
Begin
  n := max(a^[0], b^[0]);
  Fillchar(c^, sizeof(c^), 0);
  For i := 1 To n Do
    Begin
      c^[i] := c^[i] + a^[i] + b^[i];
      c^[i+1] := c^[i] Div 10;
      c^[i] := c^[i] mod 10;
    End;
  c^[0] := n + 1;
  while (c^[0] > 1) and (c^[c^[0]] = 0) do dec(c^[0]);
End;
Begin
  Assign(input,'room.in');
  Reset(input);
  Assign(output,'room.out');
  Rewrite(output);
  a := @d1;
  b := @d2;
  c := @d3;
  a^[0] := 0;
  read(ch);
  while not(ch in ['0'..'9']) Do read(ch);
  while (ch in ['0'..'9']) Do
    Begin
      inc(a^[0]);
      a^[a^[0]] := ord(ch) - ord('0');
      read(ch);
    End;
  For i := 1 To a^[0] Div 2 Do
    Begin
      j := a^[i];
      a^[i] := a^[a^[0]+1-i];
      a^[a^[0]+1-i] := j;
    End;
  ost := div3(a);
  square(a, b);
  mul(b, c, 3);
  mul(a, b, 1 + 2*ost);
  incost(b, ost);
  sum(c, b, a);
  For i := a^[0] Downto 1 Do
    write(a^[i]);
  close(input);
  close(output);
End.
