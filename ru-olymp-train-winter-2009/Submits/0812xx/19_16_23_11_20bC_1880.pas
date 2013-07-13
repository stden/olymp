uses Math;
type digit = array [0..400] Of Longint;
tuk = ^digit;
Var
  ch: char;
  a, a1, a2, b, c, d, e: digit;
  uka, ukb, uk, uk1,uk2, l, r, x: tuk;
  n, m, i, j, k, ind, ind1, len: Longint;
  ans: array [1..2000, 1..200] of char;
  ans1: array [1..2000] Of Longint;
procedure swap(var x, y: tuk);
var t: tuk;
Begin
  t := x;
  x := y;
  y := t;
End;
function srav(a, b: tuk): boolean;
var i: Longint;
Begin
  if (a^[0] <> b^[0]) Then
    Begin
      srav := a^[0] < b^[0];
      Exit;
    End;
  For i := a^[0] Downto 1 Do
    if (a^[i] <> b^[i]) Then
      Begin
        srav := a^[i] < b^[i];
        Exit;
      End;
  srav := true;
End;
procedure read_data(var a: digit);
Begin
  a[0] := 0;
  while not(ch in ['0'..'9']) Do read(ch);
  while (ch in ['0'..'9']) Do
    begin
      inc(a[0]);
      a[a[0]] := ord(ch) - ord('0');
      write(a[a[0]]);
      Read(ch);
    End;
  for i := 1 To a[0] Div 2 Do
    Begin
      j := a[a[0]+1-i];
      a[a[0]+1-i] := a[i];
      a[i] := j;
    End;
End;
procedure mul(a, b, c: tuk);
Var i, j, n, m: Longint;
Begin
  n := a^[0];
  m := b^[0];
  fillchar(c^, sizeof(c^), 0);
  For i := 1 To n Do
    For j := 1 To m Do
      begin
        c^[i+j-1] := c^[i+j-1] + a^[i]*b^[j];
        c^[i+j] := c^[i+j] + c^[i+j-1] div 10;
        c^[i+j-1] := c^[i+j-1] mod 10;
      End;
  c^[0] := n+m;
  while (c^[0] > 1) and (c^[c^[0]] = 0) Do dec(c^[0]);
End;
procedure sum(a, b, c: tuk);
var i, j, n: Longint;
Begin
  n := max(a^[0], b^[0]);
  fillchar(c^, sizeof(c^), 0);
  For i := 1 To n Do
    Begin
      c^[i] := c^[i] + a^[i] + b^[i];
      c^[i+1] := c^[i] Div 10;
      c^[i] := c^[i] mod 10;
    End;
  c^[0] := n+1;
  while (c^[0] > 1) and (c^[c^[0]] = 0) do dec(c^[0]);
End;
procedure div2(a: tuk);
var i, ost: Longint;
Begin
  ost := 0;
  for i := a^[0] Downto 1 Do
    Begin
      ost := ost*10 + a^[i];
      a^[i] := ost div 2;
      ost := ost mod 2;
    End;
  while (a^[0] > 1) and (a^[a^[0]] = 0) Do dec(a^[0]);
End;
procedure vych(a, b, c: tuk);
Var i, ost, ost1: Longint;
Begin
  Fillchar(c^, sizeof(c^), 0);
  ost := 0;
  for i := 1 To a^[0] Do
    Begin
      c^[i] := a^[i] - ost - b^[i];
      if (c^[i] < 0) Then
        begin
          c^[i] := c^[i] + 10;
          ost := 1;
        End
      else
        ost := 0;
    End;
  c^[0] := a^[0];
  while (c^[0] > 1) and (c^[c^[0]] = 0) Do dec(c^[0]);
End;
Begin
  Assign(input,'division.in');
  Reset(input);
  Assign(output,'division.out');
  Rewrite(output);
  read(ch);
  read_data(a);
  len := a[0];
  write(' |');
  read_data(b);
  uka := @a;
  ukb := @b;
  writeLn;
  Fillchar(c, sizeof(c), 0);
  Fillchar(d, sizeof(d), 0);
  Fillchar(e, sizeof(e), 0);
  l := @c;
  r := @d;
  x := @e;
  uk := @a1;
  {ind := 0;
  while (ind <> 1)  or (r^[ind] - l^[ind] > 1) Do
    Begin
      sum(l, r, x);
      div2(x);
      mul(x, ukb, uk);
      if srav(uk, uka) Then
        swap(l, x)
      else
        swap(r, x);
      if (l^[0] = r^[0]) Then
        if (ind = 0) Then ind := l^[0];
      while (ind > 1) and (l^[ind] = r^[ind]) do dec(ind);
    End; }
  l^[0] := a[0];
  For i := a[0] Downto 1 do
    Begin
      ind := 0;
      ind1 := 10;
      while (ind + 1 < ind1) Do
        Begin
          l^[i] := (ind + ind1) Div 2;
          mul(ukb, l, r);
          if srav(r, uka) Then
            ind := l^[i]
          else
            ind1 := l^[i];
        End;
      l^[i] := ind;
      if (l^[0] > 1) and (l^[l^[0]] = 0) Then dec(l^[0]);
    End;
  while (l^[0] > 1) and (l^[l^[0]] = 0) do
    dec(l^[0]);
  n := 0;

  For k := l^[0] Downto 1 Do
    if (l^[k] <> 0) THen
      Begin
        fillchar(x^, sizeof(x^), 0);
        x^[0] := k;
        x^[k] := l^[k];
        mul(x, ukb, uk);
        inc(n);
        For i := 1 To len Do
          ans[n, i] := chr(ord('0') + uk^[len+1-i]);
        ans1[n] := len - k + 1;
        ind := 1;
        while (ind < len) and (ans[n, ind] in ['0']) Do
          Begin
            ans[n, ind] := ' ';
            ans[n+1, ind] := ' ';
            inc(ind);
          End;
        ind := 1;
        if (n > 1) Then
          while (ind < len) and (ans[n-1, ind] = ' ') Do
            Begin
              ans[n+1, i] := ' ';
              inc(ind);
            End;
        for i := ind To len Do
          ans[n+1, i] := '-';
        if (n > 1) Then
          begin
            ans1[n-1] := ans1[n];
            ans1[n-2] := ans1[n];
          End;
        ans1[n+1] := ans1[n];
        n := n+2;
        vych(uka, uk, r);
        swap(uka, r);
        for i := 1 To len Do
          ans[n, i] := chr(ord('0') + uka^[len+1-i]);
        ind := 1;
        while (ind < len) and (ans[n, ind] = '0') Do
          Begin
            ans[n, ind] := ' ';
            inc(ind);
          End;
        ans1[n-1] := len;
        ans1[n] := len;
     End;
  For i := 1 To n Do
    Begin
      For j := 1 To ans1[i] Do
        write(ans[i, j]);
      if (i = 1) Then
        Begin
          For j := ans1[i] + 1 To len Do
            write(' ');
          write(' +');
          For j := 1 To max(l^[0], ukb^[0]) Do
            write('-');
        End;
      if (i = 2) Then
        Begin
          For j := ans1[i] + 1 To len Do
            write(' ');
          write(' |');
          For j := l^[0] Downto 1 Do
            write(l^[j]);
        End;
      WriteLn;
    End;
  if (n = 0) Then
    Begin
      For i := 1 To len Do
        write(' ');
      write(' +');
      for i := 1 To max(l^[0], ukb^[0]) Do
        write('-');
      WriteLn;
      For i := 1 To len Do
        write(' ');
      write(' |');
      For i := l^[0] Downto 1 Do
        write(l^[i]);
      WriteLn;
    End;
  close(input);
  close(output);
End.
