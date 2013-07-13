type digit = array [0..100000] Of Longint;
Var
  a, b, c: digit;
  n, i, j, k: longint;
  ch: char;
  s: string;
procedure read_data(var a: digit);
Begin
  a[0] := 0;
  while not(ch in ['0'..'9']) Do
    read(ch);
  while (ch in ['0'..'9']) Do
    Begin
      Inc(a[0]);
      a[a[0]] := ord(ch) - ord('0');
      read(ch);
    End;
  For i := 1 To a[0] Div 2 Do
    Begin
      j := a[i];
      a[i] := a[a[0]+1-i];
      a[a[0]+1-i] := j;
    End;
End;
function srav: boolean;
Begin
  if (a[0] <>  b[0]) Then
    Begin
      srav := a[0] > b[0];
      Exit;
    End;
  For i := a[0] Downto 1 Do
    if (a[i] <> b[i]) Then
      Begin
        srav := a[i] > b[i];
        Exit;
      End;
  srav := true;
End;
procedure vych(a, b: digit; var c: digit);
Begin
  Fillchar(c, sizeof(c), 0);
  For i := 1 to a[0] Do
    Begin
      if (a[i] < b[i]) Then
        Begin
          dec(a[i+1]);
          a[i] := a[i] + 10;
        End;
      c[i] := a[i] - b[i];
    End;
  c[0] := a[0];
  while (c[0] > 1) and (c[c[0]] = 0) Do
    dec(c[0]);
End;
Begin
  Assign(input,'aplusminusb.in');
  Reset(input);
  Assign(output,'aplusminusb.out');
  Rewrite(output);
  read(ch);
  read_data(a);
  read_data(b);
  if srav Then
    vych(a, b, c)
  else Begin
    write('-');
    vych(b, a, c);
  End;
  For i := c[0] Downto 1 Do
    Write(c[i]);
  WriteLn;
  close(input);
  close(output);
End.
