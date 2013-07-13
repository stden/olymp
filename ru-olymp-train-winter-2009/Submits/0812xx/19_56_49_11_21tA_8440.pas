uses Math;
const eps = 1000000000000000;
type shop = record
  a, p: Longint;
  num: Longint;
End;
Var
  a: array [1..50, 1..50] Of Longint;
  b: array [1..50, 1..7] Of shop;
  use: array [1..50, 0..127, 0..127] Of byte;
  d: array [1..50, 0..127] of int64;
  d1: array [1..50, 0..127] of int64;
  n, m, i, j, i1, j1, k, k1, kol, l, v, v1, v2, step, w, sum, skid: Longint;
  bit: array [1..7] of Longint;
  fact: array [0..7] of Longint;
  ans: int64;
procedure floyd;
Begin
  For i := 1 To n Do
    For j := 1 To n Do
      For k := 1 To n Do
        a[i, j] := min(a[i, j], a[i, k] + a[k, j]);
End;
procedure full_use;
var k2: longint;
Begin
  for k2 := 1 To n Do
  For i := 0 To step-1 Do
    For j := 0 To step-1 Do
      Begin
        i1 := i;
        j1 := j;
        use[k2, i, j] := 1;
        For k := 1 To k1 Do Begin
          Begin
            if (i1 mod 2 = 1) and (j1 mod 2 = 0) Then
              use[k2, i, j] := 0;
            if (i1 mod 2 = 0) and (j1 mod 2 = 1) and (b[k2, k].a = 0) Then
              use[k2, i, j] := 0;
          End;
          i1 := i1 div 2;
          j1 := j1 div 2;
        End;
      End;
End;
procedure swap(var x, y: Longint);
var t: Longint;
Begin
  t := x;
  x := y;
  y := t;
End;
procedure gen_next_comb;
var i, j: Longint;
Begin
  i := kol;
  while (bit[i] < bit[i-1]) Do dec(i);
  j := i-1;
  while (i < kol) and (bit[i+1] > bit[j]) Do inc(i);
  swap(bit[i], bit[j]);
  for i := 1 To (kol-j) Div 2 Do
    swap(bit[j+i], bit[kol+1-i]);

End;
procedure full_d1;
Begin
  For i := 1 To n Do
    d1[i, 0] := 0;
  For i := 1 To n Do
    For j := 1 To step-1 Do
      Begin
        if (use[i, 0, j] = 0) Then
          Begin
            d1[i, j] := eps;
            continue;
          End;
        kol := 0;
        j1 := j;
        for k := 1 To k1 Do
          Begin
             if (j1 mod 2 > 0) Then
               Begin
                 Inc(kol);
                 bit[kol] := k;
               End;
             j1 := j1 Div 2;
          end;
        d1[i, j] := eps;
        for l := fact[kol]-1 downTo 0 Do
          begin
            skid := 0;
            sum := 0;
            For k := 1 To kol Do
              Begin
                sum := sum + (b[i, bit[k]].a div 100)*(100-skid);
                skid := skid + b[i, bit[k]].p;
              End;
            d1[i, j] := min(d1[i, j], sum);
            if (l > 0) Then gen_next_comb;
          End;
      End;
End;
Begin
  Assign(input,'armor.in');
  Reset(input);
  Assign(output,'armor.out');
  Rewrite(output);
  inc(fact[1]);
  read(n, m, k1, v);
  for i := 2 To k1 Do
    fact[i] := i*fact[i-1];
  fact[0] := 1;
  For i := 1 To n Do
    For j := 1 To k1 Do
      Begin
        Read(b[i, j].a, b[i, j].p);
        b[i, j].num := j;
      End;
   For i := 1 To n Do
     a[i, i] := 0;
  For i := 1 To n-1 Do
    For j := i+1 To n Do
      Begin
        a[i, j] := 1000000000;
        a[j, i] := 1000000000;
      End;
  For i := 1 To m Do
    Begin
      Read(v1, v2, w);
      a[v1, v2] := min(a[v1, v2], w);
      a[v2, v1] := a[v1, v2];
    End;
  floyd;
  step := 1 shl k1;
  full_use;
  full_d1;
  For i := 1 To n Do
    d[i, 0] := eps;
  d[v, 0] := 0;
  For j := 1 To step-1 Do
    For i := 1 To n Do
      Begin
        d[i, j] := eps;
        For i1 := 1 To n Do
          For j1 := 0 To j-1 Do
            if (use[i, j1, j] > 0) and (a[i1, i] < 1000000000) Then
              d[i, j] := min(d[i, j], d[i1, j1] + a[i1, i] + d1[i, j-j1]);
      End;
  ans := eps;
  For i := 1 To n Do
    if (a[i, v] < 1000000000) Then
      ans := min(ans, d[i, step-1] + a[i, v]);
  if (ans = eps) Then
    WriteLn('-1')
  else
    WriteLn(ans);
  close(input);
  close(output);
End.
