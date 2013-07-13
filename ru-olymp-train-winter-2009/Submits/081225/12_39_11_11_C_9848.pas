var
  a: array [0..400000] Of longint;
  n, m, i, j, l, r, l1, r1, ind, u, v, p: Longint;
  ans: Longint;
Begin
  Assign(input,'dynarray.in');
  Reset(input);
  Assign(output,'dynarray.out');
  Rewrite(output);
  Read(n, m);
  For i := 1 To n Do
    Read(a[i]);
  while (m > 0) Do
    Begin
      dec(m);
      Read(ind);
      if (ind = 1) Then
        Begin
          Read(ind);
          read(a[ind]);
          continue;
        End;
      if (ind = 2) Then
        Begin
          read(ind);
          inc(ind);
          inc(n);
          For i := n Downto ind+1 Do
            a[i] := a[i-1];
          read(a[ind]);
          continue;
        End;
      if (ind = 3) Then
        Begin
          Read(u, v, p);
          ans := 0;
          For i := u To v Do
            if (p >= a[i]) Then
              inc(ans);
          WriteLn(ans);
        End;
    End;
  close(input);
  close(output);
End.