uses Math;
const LEVEL = 12;
Var
  a: array [0..LEVEL, '1'..'2'] Of int64;
  b: array ['1'..'2', 0..LEVEL, '1'..'2'] of int64;
  n, i, j, l, r: Longint;
  s: string;
  s1: array ['1'..'2'] Of string;
function f(x: int64): int64;
var kol1, kol2: int64;
l, c, i: longint;
Begin
  if (x = 0) Then
    Begin
      f := 0;
      Exit;
    End;
  kol1 := 0;
  kol2 := 0;
  l := 11;
  s := s1['1'];
  while (x > 0) Do begin
  i := 1;
  while ((i <= length(s)) and (x >= a[l, s[i]])) Do
    Begin
      {if (s[i] = '1') Then
        Begin
          kol1 := kol1 + 3*a[l-1, '1'];
          kol2 := kol2 + 2*a[l-1, '2'];
        End
      else
        Begin
          kol1 := kol1 + 4*a[l-1, '1'];
          kol2 := kol2 + 3*a[l-1, '2'];
        End;  }
      kol1 := kol1 + b['1', l, s[i]];
      kol2 := kol2 + b['2', l, s[i]];
      x := x - a[l, s[i]];
      inc(i);
    End;
  if (x = 0) Then
    begin
      f := kol1 + kol2*2;
      Exit;
    End;
  dec(l);
  s := s1[s[i]];
  End;
  if (x = 0) Then
    Exit;
  i := 1;
  while (x > 0) Do
    Begin
      x := x-1;
      if (s[i] = '1') Then
        kol1 := kol1+1
      else
        kol2 := kol2+1;
      inc(i);
    End;
  f := kol1 + kol2*2;
End;
Begin
  Assign(input,'digitsum.in');
  Reset(input);
  Assign(output,'digitsum.out');
  Rewrite(output);
  s1['1'] := '11212';
  s1['2'] := '1121212';
  a[0, '1'] := 1;
  a[0, '2'] := 1;
  b['1', 0, '1'] := 1;
  b['1', 0, '2'] := 0;
  b['2', 0, '1'] := 0;
  b['2', 0, '2'] := 1;
  For i := 1 To LEVEL Do
    Begin
      a[i, '1'] := 3*a[i-1, '1'] + 2*a[i-1, '2'];
      a[i, '2'] := 4*a[i-1, '1'] + 3*a[i-1, '2'];
      b['1', i, '1'] := 3*b['1', i-1, '1'] + 2*b['1', i-1, '2'];
      b['1', i, '2'] := 4*b['1', i-1, '1'] + 3*b['1', i-1, '2'];
      b['2', i, '1'] := 3*b['2', i-1, '1'] + 2*b['2', i-1, '2'];
      b['2', i, '2'] := 4*b['2', i-1, '1'] + 3*b['2', i-1, '2'];
      {writeLn(b['1', i, '1'],' ',b['1', i, '2'],' ',
      b['2', i, '1'],' ', b['2', i, '2'],' ',a[i, '1'],' ', a[i, '2']);
      }
    End;

  Read(n);
  while (n > 0) Do
    Begin
      dec(n);
      Read(l, r);
      WriteLn(f(r) - f(l-1));
    End;
  close(input);
  close(output);
End.
