type tuk = ^tree;
tree = record
  a: Longint;
  l, r: tuk;
End;
ttuk = ^tuk;
var
  d: array [0..10] Of tree;
  p: array [0..10] of tuk;
  n, m, k, i, j, l, r, ans, ind,step, log1, l1, r1: Longint;
  a: array [0..10, 1..100000] Of ttuk;
  kol: array [0..10] Of Longint;
  uk: ttuk;
procedure make_tree(l: Longint;var uk: tuk);
Begin
  new(uk);
  if (l < log1) Then
    Begin
      make_tree(l+1, uk^.l);
      make_tree(l+1, uk^.r);
    End;
  if (i = 0) Then
    uk^.a := step Div (1 shl l)
  else
    uk^.a := 0;
  uk^.a := uk^.a;
End;
function find_sum(l, r, l1, r1: Longint; var uk: tuk): Longint;
Begin
  if (l = l1) and (r = r1) Then
    Begin
      find_sum := uk^.a;
      Exit;
    End;

  if (r1 <= (l+r) Div 2) Then
    find_sum := find_sum(l, (l+r) Div 2, l1, r1, uk^.l)
  else if (l1 >= (l+r) Div 2+1) Then
    find_sum := find_sum((l+r) Div 2+1, r, l1, r1, uk^.r)
  else
    find_sum := find_sum(l, (l+r) Div 2, l1, (l+r) Div 2, uk^.l) + find_sum((l+r) Div 2 +1, r, (l+r) Div 2+1, r1, uk^.r);
End;
procedure change(l, r, l1, r1: Longint; var uk: tuk);
Begin
  if (l = l1) and (r = r1) Then
    Begin
      inc(kol[i]);
      a[i, kol[i]] := @uk;
      Exit;
    End;
  if (r1 <= (l+r) Div 2) Then
    change(l, (l+r) Div 2, l1, r1, uk^.l)
  else if (l1 >= (l+r) Div 2+1) Then
    change((l+r) Div 2+1, r, l1, r1, uk^.r)
  else Begin
    change(l, (l+r) Div 2, l1, (l+r) Div 2, uk^.l);
    change((l+r) Div 2+1, r, (l+r) Div 2+1, r1, uk^.r);
  End;
End;
procedure resum(l, r, l1, r1: Longint; var uk: tuk);
var x: Longint;
Begin
  if (l = l1) and (r = r1) Then
    Begin
      Exit;
    End;
  if (uk = nil) Then
    Begin
      WriteLn('ERROR ',m);
      Exit;
    End;
  x := (l+r) Div 2;
  if (r1 <= x) Then
    resum(l, x, l1, r1, uk^.l)
  else if (l1 >= x+1) Then
    resum(x+1, r, l1, r1, uk^.r)
  else Begin
    resum(l, x, l1, x, uk^.l);
    resum(x+1, r, x+1, r1, uk^.r);
  End;
  if (uk^.r = nil) Then
    Begin
      WriteLn('ERROR');
      Exit;
    End;
  if (uk^.l = nil) Then
    Begin
      WriteLn('ERROR');
      Exit;
    End;
  uk^.a := uk^.l^.a + uk^.r^.a;
End;
Begin
  Assign(input,'sum.in');
  Reset(input);
  Assign(output,'sum.out');
  Rewrite(output);
  read(n, k, m);
  step := 1;
  log1 := 0;
  while (step < n) Do
    Begin
      inc(log1);
      step := step*2;
    End;
  For i := 0 To k-1 Do
    make_tree(0, p[i]);
  while (m > 0) Do
    Begin
      dec(m);
      Read(ind, l1, r1);
      if (ind = 2) Then
        Begin
          ans := 0;
          For i := 0 To k-1 Do
            ans := ans + i*find_sum(1, step, l1, r1, p[i]);
          WriteLn(ans);
          continue;
        End;
      For i := 0 To k-1 Do
        Begin
          kol[i] := 0;
          change(1, step, l1, r1, p[i]);
        End;
      For j := 1 To kol[0] Do
        Begin
          new(a[k, j]);
          new(a[k, j]^);
          For i := k Downto 1 Do
            a[i, j]^^ := a[i-1, j]^^;
          a[0, j]^^ := a[k, j]^^;
        End;
      For i := 0 To k-1 Do
        resum(1, step, l1, r1, p[i]);
    End;
  close(input);
  close(output);
End.