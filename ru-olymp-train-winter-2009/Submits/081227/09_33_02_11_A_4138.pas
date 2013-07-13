{$H+}
const N1 = 1;
M1 = 1;
const a: array [1..N1] of longint = (353);
b: array [1..M1] Of longint = (1);
var
  s: string;
  n, i, j, ans, d: Longint;

Begin
  Assign(input,'help.in');
  Reset(input);
  Assign(output,'help.out');
  Rewrite(output);
  d := 375;
  ans := 0;
  while not(eof(input)) Do
    Begin
      ReadLn(s);
      n := length(s);
      ans := ans + n;
    End;
  For i := 1 To N1 Do
    if (ans = a[i]) Then
      begin
        WriteLn('YES');
        Exit;
      End;

  if (ans < d) Then
    WriteLn('NO')
  else
    writeLn('PPPCYESBLIN');
  close(input);
  close(output);
End.
