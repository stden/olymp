uses Math;
const osn = 1000000000;
type digit = array [0..25] Of Longint;
tuk = ^digit;
var
  uka: array [0..501, 0..501] of digit;
  a: array [0..501, 0..501] of tuk;

  ukb, ukb1, ukc, ukc1, ukc2: array [1..501] of digit;
  b, b1, c, c1, c2: array [1..501] of tuk;

  n, m, i, j, t, l: Longint;
  ukans, ukd1, ukd: digit;
  ans, d1, d: tuk;
  int, int1: int64;
procedure swap(var x, y: tuk);
var t: tuk;
Begin
  t := x;
  x := y;
  y := t;
End;
procedure sum(a, b, c: tuk);
var i, j, n: Longint;
Begin
  n := max(a^[0], b^[0]);
  Fillchar(c^, sizeof(c^), 0);
  For i := 1 To n Do
    Begin
      c^[i] := c^[i] + a^[i] + b^[i];
      c^[i+1] := c^[i] Div osn;
      c^[i] := c^[i] mod osn;
    End;
  c^[0] := n+1;
  while (c^[0] > 1) and (c^[c^[0]] = 0) do dec(c^[0]);
End;
procedure mul(a, b, c:tuk);
var i, j, n, m: Longint;
Begin
  n := a^[0];
  m := b^[0];
  Fillchar(c^, sizeof(c^), 0);
  For i := 1 To n Do
    For j := 1 To m Do
      Begin
        int := a^[i];
        int := c^[i+j-1] + int*b^[j];
        c^[i+j] := c^[i+j] + (int Div osn);
        c^[i+j-1] := int mod osn;
      End;
  c^[0] := n+m;
  while (c^[0] > 1) and (c^[c^[0]] = 0) do dec(c^[0]);
End;
procedure vych(a, b, c: tuk);
var i, ost: Longint;
Begin
  ost := 0;
  fillchar(c^, sizeof(c^), 0);
  For i := a^[0] Downto 1 Do
    Begin
      c^[i] := a^[i] - ost - b^[i];
      if (c^[i] < 0) Then
        begin
          c^[i] := c^[i] + osn;
          ost := 1;
        End
      else
        ost := 0;
    End;
End;
procedure find_a;
var i, j, k: Longint;
Begin
  For i := 0 To n Do
    begin
      a[i, 1] := @uka[i, 1];
      a[i, 1]^[0] := 1;
      if (i >= t) and (2*t >= i) Then
        a[i, 1]^[1] := 1
      else
        a[i, 1]^[1] := 0;
    End;
  For j := 2 To n Div t Do
    For i := j*t To 2*j*t Do
      Begin
        if (i > n) Then Break;
        a[i, j] := @uka[i, j];
        a[i, j]^[0] := 1;
        For k := t To 2*t Do
          Begin
            if (i - k <= 0) Then Break;
            if (a[i-k, j-1] = nil) Then continue;
            sum(a[i, j], a[i-k, j-1], d);
            swap(a[i, j], d);
          End;
      End;
End;
procedure find_c;
var i, j, k: Longint;
Begin
  For i := 1 To n Do
    begin
      c[i]^[0] := 1;
      if (i >= t-1) and (2*t-1 >= i) Then
        c[i]^[1] := 1
      else
        c[i]^[1] := 0;
    End;
  c2[1]^ := c[n]^;
  For j := 2 To n Do Begin
  For i := 1 To n Do
      Begin
        Fillchar(c1[i]^, sizeof(c1[i]^), 0);
        c1[i]^[0] := 1;
        For k := t-1 To 2*t-1 Do
          Begin
            if (i - k <= 0) Then Break;
            if (c[i-k] = nil) Then continue;
            sum(c1[i], c[i-k], d);
            swap(c1[i], d);
          End;
      End;
  c2[j]^ := c1[n]^;
  For i := 1 To n Do
    swap(c[i], c1[i]);
  End;
End;
procedure init_b;
var i, j: Longint;
Begin
  For i := 1 To 500 Do
    ukb[i][0] := 1;
  ukb[1][1] := 1;
End;

procedure next_level_b;
var i, j: Longint;
Begin
  For i := 1 To n Do
    Begin
      Fillchar(b1[i]^, sizeof(b1[i]^), 0);
      b1[i]^[0] := 1;
      For j := 1 To n Do
        Begin
          if (a[i, j] = nil) Then
            continue;
          mul(a[i, j], b[j], d1);
          sum(d1, b1[i], d);
          swap(b1[i], d);
        End;
    End;
  For i := 1 To n Do
    swap(b[i], b1[i]);
End;
Begin
  assign(input,'btrees.in');
  Reset(input);
  Assign(output,'btrees.out');
  Rewrite(output);
  Read(n, t);
  if (n < t) Then
    Begin
      if (t = n+1) Then
        writeLn('1')
      else
        writeLn('0');
      Exit;
    End;
  For i := 0 To 500 Do
    Begin
      b[i] := @ukb[i];
      b1[i] := @ukb1[i];
      b[i]^[0] := 1;
      b1[i]^[0] := 1;
      c[i] := @ukc[i];
      c1[i] := @ukc1[i];
      c[i]^[0] := 1;
      c1[i]^[0] := 1;
      c2[i] := @ukc2[i];
      c2[i]^[0] := 1;
    End;
  ans := @ukans;
  d1 := @ukd1;
  d := @ukd;
  ans^[0] := 1;
  if (n <= 2*t-1) and (n >= t) Then
    ans^[1] := 1
  else
    ans^[1] := 0;
  find_a;
  init_b;
  find_c;
  l := 1;
  i := 0;
  while (l*t <= n) Do
    begin
      l := l*t;
      inc(i);
      next_level_b;
      For j := 1 To n Do
        Begin
          mul(b[j], c2[j], d1);
          sum(ans, d1, d);
          swap(ans, d);
        End;
    End;
  write(ans^[ans^[0]]);
  For i := ans^[0] - 1 Downto 1 Do
    Begin
      l := osn Div 10;
      while (l > 0) Do
        begin
          write(ans^[i] Div l);
          ans^[i] := ans^[i] mod l;
          l := l Div 10;
        End;
    End;
  close(input);
  close(output);
End.


