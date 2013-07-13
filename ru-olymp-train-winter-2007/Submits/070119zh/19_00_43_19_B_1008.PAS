program rooks; 

{$MODE DELPHI}

const
  MAXN = 11;
  P    = 10000;

var
  m, n, w, k, l, a, b, i, j, t, ans: Integer;
  x: array [0..MAXN, 0..MAXN, 0..MAXN*MAXN] of Integer;
  C: array [0..MAXN*MAXN, -1..MAXN*MAXN] of Integer;

begin
  Assign(input, 'rooks.in'); 
  Assign(output, 'rooks.out');
  Reset(input); Rewrite(output);

  fillchar(C, sizeof(C), 0);
  C[0,0] := 1;
  for i := 1 to MAXN*MAXN do
    for j := 0 to i do
      C[i,j] := (C[i-1,j-1] + C[i-1,j]) mod P;

  Read(m, n, w, l);
  fillchar(x, sizeof(x), 0);
  x[0,0,0] := 1;
  for a := 1 to n do
    for b := 1 to m do
      for k := 1 to w+l do
        for i := 1 to a do
          for t := 0 to i do
            x[a,b,k] := (x[a,b,k] + x[a-t,b-1,k-i] * ((C[a,t] * C[a-t,i-t]) mod P)) mod P;

  ans := 0;
  for a := 1 to n do
    for b := 1 to m do
      ans := (ans + ((x[a,b,w] * C[n,a]) mod P) * ((C[m,b] * C[(n-a)*(m-b),l]) mod P)) mod P;

  Write(ans);

  Close(input);
  Close(output);
end.