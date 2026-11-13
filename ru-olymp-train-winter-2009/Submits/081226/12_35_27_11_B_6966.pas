uses SysUtils;
type list = record
  v, sum, prof: Longint;
End;
Var
  a: array [1..30, 1..30] Of Longint;
  b1, b2: array [0..15] of list;
  n, m, i, kol1, kol2, j, ans, prof, v1, v2, sum: Longint;
  t, t1: Extended;
  bool: boolean;
function prov(v: Longint): boolean;
Begin
  prov := false;
  if (v > n) Then
    Begin
      if (ans < b1[n Div 2].sum + b2[n Div 2].sum) Then
        Begin
          ans := b1[n Div 2].sum + b2[n Div 2].sum;
          prof := b1[n Div 2].prof;
        End;
      prov := 5.99 < (now - t)*86400;
      Exit;
    End;
  if (kol1 < n Div 2) Then
    Begin
      Inc(kol1);
      b1[kol1].v := v;
      b1[kol1].sum := b1[kol1-1].sum;
      For i := 1 To kol1-1 Do
        inc(b1[kol1].sum, a[v, b1[i].v]);
      b1[kol1].prof := b1[kol1-1].prof + (1 shl (v-1));
      if prov(v+1)Then
        Begin
          prov := true;
          Exit;
        End;
      dec(kol1);
    End;
  if (kol2 < n Div 2) Then
    Begin
      Inc(kol2);
      b2[kol2].v := v;
      b2[kol2].sum := b2[kol2-1].sum;
      For i := 1 To kol2-1 Do
        inc(b2[kol2].sum, a[v, b2[i].v]);
      b2[kol2].prof := b2[kol2-1].prof + (1 shl (v-1));
      if prov(v+1) Then
        Begin
          prov := true;
          Exit;
        End;
      dec(kol2);
    End;
End;
Begin
  t := now;
  Assign(input,'half.in');
  Reset(input);
  Assign(output,'half.out');
  Rewrite(output);
  Read(n, m);
  For i := 1 To m Do
    Begin
      Read(v1, v2);
      a[v1, v2] := 1;
      a[v2, v1] := 1;
    End;
  ans := -1;
  prof := 0;
  b1[1].v := 1;
  b1[1].prof := 1;
  b1[1].sum := 0;
  kol1 := 1;
  kol2 := 0;
  bool := prov(2);
  For i := 1 To n Do
    Begin
      if (prof mod 2 > 0) Then
        write(i,' ');
      prof := prof Div 2;
    End;
  close(input);
  close(output);
End.


