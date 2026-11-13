{$H+}
uses Math;
var
  b: array [0..100000] Of int64;
  a: array [1..2000, 1..2000] Of int64;
  last: array [1..2000, 2..1000] Of longint;
  n, i, j, k, step, step1, l1, r1: Longint;
  s: array [1..100000] of string;

procedure dfs;
var i, l, r: Longint;
Begin
  l := l1;
  r := r1;
  For i := l To last[l, r] Do
    s[i] := s[i] + '0';
  For i := last[l, r] + 1 To r Do
    s[i] := s[i] + '1';
  if (l < last[l, r]) Then Begin
    l1 := l; r1 := last[l, r]; dfs;
  End;
  if (last[l, r]+1 <  r) Then
    Begin
      l1 := last[l, r] + 1;
      r1 := r;dfs;
    End;
End;
Begin
  Assign(input,'code.in');
  Reset(input);
  Assign(output,'code.out');
  Rewrite(output);
  Read(n);
  b[0] := 0;
  For i := 1 To n Do
    Begin
      Read(b[i]);
      b[i] := b[i] + b[i-1];
    End;
  if (n > 2000) Then
    Begin
      l1 := 0;
      step := 1;
      while (step < n) Do
        Begin
          step := step*2;
          inc(l1);
        End;
      For i := 0 To n-1 Do
        Begin
          s[1] := '';
          step1 := step;
          j := i;
          For k := 1 To l1 Do
            begin
              step1 := step1 Div 2;
              s[1] := s[1] + chr(j Div step1 + ord('0'));
              j := j mod step1;
            End;
          WriteLn(s[1]);
        End;
      Exit;
    End;
  For i := 1 To n Do
    a[i, i] := 0;
  For j := 1 To n-1 Do
    For i := 1 To n - j Do
      Begin
        a[i, i+j] := 100000000000000000;
        For k := i To i+j-1 Do
          if (a[i, i+j] > a[i, k] + a[k+1, i+j] + b[i+j] - b[i-1]) Then
            Begin
              a[i, i+j] := a[i, k] + a[k+1, i+j] + b[i+j] - b[i-1];
              last[i, i+j] := k;
            End;
      End;
  For i := 1 To n Do
    s[i] := '';
  l1 := 1;
  r1 := n;
  dfs;
  For i := 1 To n Do
    WriteLn(s[i]);
  close(input);
  close(output);
End.
