Var
  a, last: array [1..100000] Of Longint;
  n, i, j, ans: Longint;
  ch: char;
Begin
  Assign(input,'next.in');
  Reset(input);
  Assign(output,'next.out');
  Rewrite(output);
  ans := 0;
  n := 0;
  read(ch);
  while not(ch in ['0','1']) Do
    read(ch);
  while (ch in ['0'..'1']) Do
    Begin
      inc(n);
      a[n] := ord(ch) - ord('0');
      if (a[n] = 0) Then
        ans := n;
      read(ch);
    End;
  if (ans <= n Div 2) Then
    Begin
      a[ans] := 1;
      For i := ans+1 To n Do
        a[i] := a[i-ans];
    End;
  last[1] := 1;
  For i := 2 To n Do
    if (a[i] = 0) Then
      last[i] := i
    else
      last[i] := last[i-1];
  ans := last[n];
  while (ans < n) Do
    Begin
      i := ans;
      j := i + last[n-i];
      a[ans] := 1;
      inc(i);
      while (i < j) Do
        Begin
          a[i] := a[i-ans];
          inc(i);
        End;
      ans := i;
    End;
  a[n] := 1;
  For i := 1 To n Do
    write(a[i]);
  WriteLn;
  close(input);
  close(output);
End.


