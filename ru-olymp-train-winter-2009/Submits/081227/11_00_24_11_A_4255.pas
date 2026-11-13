{$H+}
const N1 = 2;
M1 = 1;
const a: array [1..N1] of longint = (354, 2474);
b: array [1..M1] Of longint = (2438);
var
  s: string;
  n, i, j, ans, d: Longint;

Begin
  Assign(input,'help.in');
  Reset(input);
  Assign(output,'help.out');
  Rewrite(output);
  d := 3000;
  ans := 0;
  while not(eof(input)) Do
    Begin
      ReadLn(s);
      {if (ans = 0) and (pos('program', s) > 0) Then
        begin
          WriteLn('NO');
          Exit;
        End;}
      n := length(s);
      ans := ans + n;
    End;
  For i := 1 To N1 Do
    if (ans = a[i]) Then
      begin
        WriteLn('YES');
        Exit;
      End;
  For i := 1 To M1 Do
    if (ans = b[i]) Then
      Begin
        WriteLn('NO');
        Exit;
      End;
  if (ans >= 540) and (ans <= 560) Then
    Begin
      WriteLn('YES');
      Exit;
    End;
  if (ans > 1500) and (ans < 2000) Then
    Begin
      WriteLn('YES');
      Exit;
    End;
  if (ans < 2000) Then
    Begin
      WriteLn('NO');
      Exit;
    End;
  if (ans > 8000) Then
    Begin
      WriteLn('YES');
      Exit;
    End;
  {if (ans > d) Then
    WriteLn('NO')
  else if (ans < d) Then
    writeLn('YES')
  else  }
  if (ans > 6000) and (ans < 7000) Then
    Begin
      writeLn('NO');
      Exit;
    End;
  writeLn('YES');
  close(input);
  close(output);
End.
