uses treeunit;
Var
  a, use, use1: array [1..200000] Of Longint;
  v1, v2, num, uk, ban: array [1..400000] Of Longint;
  n, i, j, ans, kol, kol1, x, num1, ind: Longint;
procedure dfs(v: Longint);
var ind: Longint;
Begin
  ind := a[v];
  inc(kol);
  use[v] := 1;
  while (ind > 0) Do
    Begin
      if (ban[ind] = 0) and (use[v2[ind]] = 0) Then
        Begin
          dfs(v2[ind]);
          use[v] := use[v] + use[v2[ind]];
        End;
      ind := uk[ind];
    End;
End;
procedure dfs1(v: Longint);
var ind: Longint;
Begin
  use1[v] := 1;
  ind := a[v];
  while (ind > 0) Do
    Begin
      if (ban[ind] = 0) and (use1[v2[ind]] = 0) Then
        Begin
          if (abs(kol - 2*use[v2[ind]]) < ans) Then
            Begin
              ans := abs(kol - 2*use[v2[ind]]);
              num1 := ind;
            End;
          dfs1(v2[ind]);
        End;
      ind := uk[ind];
    End;
End;
Begin
  {writeLn('init()');}
  {Write('getN()');
  read(n);}
  init;
  n := getN;
  For i := 1 To n-1 Do
    Begin
      {write('getA(',i,')');
      read(v1[2*i-1]);
      write('getB(',i,')');
      read(v2[2*i-1]);}
      v1[2*i-1] := getA(i);
      v2[2*i-1] := getB(i);

      v1[2*i] := v2[2*i-1];
      v2[2*i] := v1[2*i-1];
      uk[2*i-1] := a[v1[2*i-1]];
      a[v1[2*i-1]] := 2*i-1;
      num[2*i-1] := i;
      num[2*i] := i;
      uk[2*i] := a[v1[2*i]];
      a[v1[2*i]] := 2*i;
    End;
  x := n Div 2 + 1;
  while true Do
    Begin
      kol := 0;
      fillchar(use, sizeof(use), 0);
      dfs(x);
      if (kol = 1) Then
        Break;
      fillchar(use1, sizeof(use1), 0);
      ans := 10000000;
      dfs1(x);
      if (num1 mod 2 = 0) then dec(num1);
      {writeLn('query(',(num1+1) Div 2,')');
      read(ind);}
      ind := query((num1+1) Div 2);
      if (ind = 0) Then
        x := v1[num1]
      else
        x := v2[num1];
      ban[num1] := 1;
      ban[num1+1] := 1;
    End;
  {writeLn('report(',x,')');}
  report(x);
End.
















