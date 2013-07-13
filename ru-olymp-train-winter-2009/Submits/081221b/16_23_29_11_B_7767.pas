{$H+}
Var
  s, s1, s2: string;
  n, i, j, len, len1, t1, t2, ans1, ans2, n1, n2, num1, num2, c: Longint;
  a: array [1..1000000] Of string;
function check(l, r: Longint): boolean;
var ind: Longint;
Begin
  ind := 0;
  For i := l To r Do
    if not(s[i] in ['0'..'9', ',']) Then
      Begin
        check := false;
        Exit;
      End;
  if (s[l] = ',') or (s[r] = ',') Then
    Begin
      check := false;
      Exit;
    End;
  c := 0;
  For i := l To r Do
    if (s[i] = ',') Then
      Begin
        inc(ind);
        if (ind > 1) Then
          Begin
            check := false;
            Exit;
          End;
      End
    else if (ind = 0) Then
      c := c*10 + ord(s[i]) - ord('0');
  check := true;
End;
Begin
  assign(input,'stress.in');
  Reset(input);
  Assign(output,'stress.out');
  Rewrite(output);
  s1 := '';
  For i := 1 To 48 Do
    s1 := s1 + '-';
  n := 0;
  ans1 := -100000000;
  ans2 := -100000000;
  while not(eof(input)) Do
    Begin
      n1 := -1;
      n2 := -1;
      inc(n);
      ReadLn(s);
      ReadLn(s);
      WriteLn('At ',s);
      a[n] := s;
      ReadLn(s);
      len := length(s);
      while not(s = s1) Do Begin
        if (len > 10) and (copy(s, 1, 11) = 'Work time: ') and (copy(s, len-2, 3) = ' ms') Then
            if check(12, len-3) Then
              Begin
                if (n1 < 0) Then
                  Begin
                    n1 := 0;
                    WriteLn('First: ',c,' ms');
                    if (c > ans1) Then
                      Begin
                        ans1 := c;
                        num1 := n;
                      End;
                  End
                else if (n2 < 0) Then
                  Begin
                    n2 := 0;
                    writeLn('Second: ',c,' ms');
                    if (c > ans2) Then
                      Begin
                        ans2 := c;
                        num2 := n;
                      End;
                  End;
              End;
      ReadLn(s);
      len := length(s);
    End;
    end;
  WriteLn('Maximal work time for first: ',ans1,' at ',a[num1]);
  WriteLn('Maximal work time for second: ',ans2,' at ',a[num2]);
  close(input);
  close(output);
End.
