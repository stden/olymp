uses Math;
type zap = record
  a: Longint;
  b: int64;
End;
Var
  a: array [1..50] of Longint;
  use: array [1..50] Of byte;
  v, w, uk: array [1..1000] Of Longint;
  b, reb, pred: array [1..1000] Of longint;
  n, m, i, j, k, ans, v1, ind, ind1, ans1: Longint;
  d: array [0..200000] of zap;
procedure fill_d(x: Longint);
var i, j, ind: Longint;
Begin
  j := x;
  d[x].a := x;
  b[1] := 0;
  b[n] := 1;
  For i := 2 To n-1 Do
    Begin
      b[i] := x mod 2;
      x := x Div 2;
    End;
  d[j].b := 0;
  For i := 1 To n Do
    if (b[i] = 0) Then
      Begin
        ind := a[i];
        while (a[i] > 0) Do
          Begin
            if (b[v[ind]] = 1) Then
              d[j].b := d[j].b + w[ind];
            ind := uk[ind];
          End;
      End;
End;
procedure swap(var x, y: zap);
var t: zap;
Begin
  t := x;
  x := y;
  y := t;
End;
procedure qsort(l, r: Longint);
var i, j: Longint;
x: int64;
Begin
  i := l;
  j := r;
  x := d[(i+j) div 2].b;
  while (i < j) Do
    Begin
      while (d[i].b < x) Do inc(i);
      while (d[j].b > x) Do dec(j);
      if (i <= j) Then
        Begin
          swap(d[i], d[j]);
          inc(i);
          dec(j);
        End;
    End;
  if (i < r) Then
    qsort(i, r);
  if (l < j) Then qsort(l, j);
End;
function bfs: boolean;
Begin
  i := 0;
  j := 1;
  use[1] := 1;
  bfs := false;
  b[1] := 1;
  while (i < j) Do
    Begin
      inc(i);
      ind := a[b[i]];
      while (ind > 0) Do
        begin
          if (use[v[ind]] = 0) and (w[ind] > 0) Then
            Begin
              inc(j);
              b[j] := v[ind];
              reb[j] := ind;
              pred[j] := i;
              use[b[j]] := 1;
              if (b[j] = n) Then
                Begin
                  bfs := true;
                  ans := 2000000000;
                  ind1 := j;
                  while (ind1 > 1) Do
                    Begin
                      ans := min(ans, w[reb[ind1]]);
                      ind1 := pred[ind1];
                    End;
                  ans1 := ans1 + ans;
                  ind1 := j;
                  while (ind1 > 1) Do
                    begin
                      w[reb[ind1]] := w[reb[ind1]] - ans;
                      if (reb[ind1] mod 2 = 0) Then
                        w[reb[ind1] - 1] := w[reb[ind1] - 1] + ans
                      else
                        w[reb[ind1] + 1] := w[reb[ind1] + 1] + ans;
                      ind1 := pred[ind1];
                    End;
                  Exit;
                End;
            End;
          ind := uk[ind];
        End;
    End;
End;

Begin
  Assign(input,'cuts.in');
  Reset(input);
  Assign(output,'cuts.out');
  Rewrite(output);
  read(n, m);
  For i := 1 To m Do
    Begin
      Read(v1, v[2*i-1], w[2*i-1]);
      uk[2*i-1] := a[v1];
      a[v1] := 2*i-1;
      v[2*i] := v1;
      w[2*i] := 0;
      uk[2*i] := a[v[2*i-1]];
      a[v[2*i-1]] := 2*i;
    End;
  read(k);
  ans1 := 0;
  if (k = 1) Then begin
  repeat
    fillchar(use, sizeof(use), 0);
  until not(bfs);
  for i := 1 To n Do
    write(1 - use[i]);
  Exit;
  End;
  {writeLn('011111');
  writeLn('000001');
  writeLn('011001');
  writeLn('011101');
  writeLn('010101');
  writeLn('010001');
  writeLn('011011');
  writeLn('001001');
  writeLn('000101');
  writeLn('001011');
  writeLn('010111');
  WriteLn('001111');
  writeLn('000011');
  WriteLn('010011');
  WriteLn('000111');
  WriteLn('001101');}
  For i := 0 To (1 shl (n-2) - 1) Do
    full_d(i);
  qsort(0, 1 shl(n-2) - 1);
  For i := 0 To k-1 Do
    Begin
      write('0');
      ind := d[i].a;
      For j := 1 To n-2 Do
        Begin
          b[j] := ind mod 2;
          ind := ind Div 2;
        End;
      For j := n-2 Downto 1 Do
        write(b[j]);
      writeLn('1');
    End;


  close(input);
  close(output);
End.
