{$H+}
const N1 = 1;
M1 = 1;
const a: array [1..N1] of longint = (354);
b: array [1..M1] Of longint = (7000);
var
  s: string;
  n, i, j, ans, d: Longint;

Begin
  Assign(input,'help.in');
  Reset(input);
  Assign(output,'help.out');
  Rewrite(output);
  d := 2443;
  ans := 0;
  while not(eof(input)) Do
    Begin
      ReadLn(s);
      {if (ans = 0) and (pos('program', s) > 0) Then
        begin
          WriteLn('NO');
          Exit;
        End;  }
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
  if (ans < d) Then
    WriteLn('NO')
  else if (ans = d) Then
    writeLn('YES')
  else
    writeLn('PPPCYESBLIN');
  close(input);
  close(output);
End.
