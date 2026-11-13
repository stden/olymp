uses Math;
Var
  a: array [0..3000001] Of Longint;
  b, c: array [0..3000001] Of Longint;
  n, i, j, ans, ind, ans1, kol: Longint;
  ch: char;
Begin
  assign(input,'palin.in');
  Reset(input);
  Assign(output,'palin.out');
  Rewrite(output);
  read(ch);
  while not(ch in ['0'..'1']) Do
    Read(ch);
  n := 0;
  ans := 0;
  while (ch in ['0'..'1']) Do
    begin
      inc(n);
      a[n] := ord(ch) - ord('0');
      ans := ans + a[n];
      read(ch);
    End;
  ind := 0;
  For i := 1 To n Div 2 Do
    if (a[i] <> a[n+1-i]) Then
      inc(ind);
  if (ind = 0) Then
    begin
      WriteLn('1');
      For i := 1 To n Do
        write(a[i]);
      WriteLn;
      Exit;
    End;
  ans := n - ans;
  kol := 0;
  b[0] := 0;
  For i := 1 To n Do
    if (a[i] = 1) Then
      begin
        inc(kol);
        b[kol] := i;
      End;
  inc(kol);
  b[kol] := n+1;
  For i := 1 To kol Do
    Begin
      c[i-1] := min(b[i] - b[i-1], b[kol+1-i] - b[kol - i]) - 1;
      ans := ans - c[i-1];
    End;
  WriteLn('2');
  For i := 1 To ans Do
    write('0');
  WriteLn;
  For i := 1 To kol Do
    Begin
      For j := 1 To c[i-1] Do
        write('0');
      if (i < kol) Then
        write('1');
    End;
  WriteLn;

  close(input);
  close(output);
End.


