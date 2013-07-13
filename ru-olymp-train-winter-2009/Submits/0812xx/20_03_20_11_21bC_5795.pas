{$H+}
uses Math;
const month: array [1..12] of string[3] = ('Jan','Feb', 'Mar', 'Apr',
 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
days: array [1..12] Of Longint = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
Var
  s, s1, s2: string;
  n, i, j, d, mon, y, h, m, z, ans, t, t1, t2, t3, t4, t5: Longint;
procedure dec_month;
Begin
  if (mon > 1) Then
    dec(mon)
  else Begin
    mon := 12;
    dec(y);
  End;
End;
procedure inc_month;
Begin
  if (mon < 12) Then
    inc(mon)
  else Begin
    mon := 1;
    inc(y);
  End;
End;
procedure dec_data;
Begin
  if (d > 1) Then
    dec(d)
  else Begin
    dec_month;
    d := days[mon];
    if (mon = 2) and (y mod 4 = 0) Then
      d := 29;
  End;
End;
procedure inc_data;
Begin
  if (mon = 2) THen
    Begin
      if (y mod 4 = 0) Then
        Begin
          if (d < 29) Then
            inc(d)
          else Begin
            d := 1;
            mon := 3;
          End;
        End
      else if (d < 28) Then
        inc(d)
      else Begin
        d := 1;
        mon := 3;
      End;
      Exit;
    End;

  if (d < days[mon]) Then
    inc(d)
  else Begin
    inc_month;
    d := 1;
  End;
End;
procedure dec_time(t1: Longint);
Begin
  t := t - t1;
  if (t < 0) Then
    Begin
      t := t + 1440;
      dec_data;
    End;
End;
procedure inc_time(t1: Longint);
Begin
  t := t + t1;
  if (t >= 1440) Then
    Begin
      t := t - 1440;
      inc_data;
    End;
End;
Begin
  Assign(input,'apache.in');
  Reset(input);
  Assign(output,'apache.out');
  Rewrite(output);
  ReadLn(s);
  t1 := ((ord(s[2]) - ord('0'))*10 + ord(s[3]) - ord('0'))*60;
  t1 := t1 + (ord(s[4]) - ord('0'))*10 + ord(s[5]) - ord('0');
  if (s[1] = '-') Then t1 := -t1;
  s2 := s;
  while not(eof(input)) Do
    Begin
      ReadLn(s);
      z := pos('[', s);
      write(copy(s, 1, z));
      delete(s, 1, z);
      d := ord(s[1]) - ord('0');
      d := d*10 + ord(s[2]) - ord('0');

      delete(s, 1, 3);
      s1 := copy(s, 1, 3);
      mon := 0;
      For i := 1 To 12 Do
        if (month[i] = s1) Then
          mon := i;
      i := 12 Div mon;
      if (mon = 0) Then
        Begin
          WriteLn('ERROR');
          Exit;
        End;
      delete(s, 1, 4);
      y := 0;
      For i := 1 To 4 Do
        y := y*10 + ord(s[i]) - ord('0');
      delete(s, 1, 5);
      t := ((ord(s[1]) - ord('0'))*10 + ord(s[2]) - ord('0'))*60;
      t := t + (ord(s[4]) - ord('0'))*10 + ord(s[5]) - ord('0');
      delete(s, 1, 6);
      t2 := ((ord(s[5]) - ord('0'))*10 + ord(s[6]) - ord('0'))*60;
      t2 := t2 + (ord(s[7]) - ord('0'))*10 + ord(s[8]) - ord('0');
      if (s[4] = '-') THen
        t2 := -t2;
      t2 := t1 - t2;
      if (t2 >= 0) Then
        inc_time(t2)
      else
        dec_time(-t2);
      write(d Div 10, d mod 10,'/',month[mon],'/',y,':');
      y := t;
      write((y Div 60) Div 10, (y Div 60) mod 10,':');
      y := y mod 60;
      write(y Div 10, y mod 10, ':',copy(s, 1, 3));
      delete(s, 1, 8);
      writeLn(s2, s);
    End;
  close(input);
  close(output);
End.
