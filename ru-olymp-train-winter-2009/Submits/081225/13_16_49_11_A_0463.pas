Var
  a: array [1..3000000] Of Longint;
  n, i, j, ans, ind: Longint;
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
  WriteLn('2');
  For i := 1 To n - ans Do
    write('0');
  WriteLn;
  For i := 1 To ans Do
    write('1');
  WriteLn;
  close(input);
  close(output);
End.


