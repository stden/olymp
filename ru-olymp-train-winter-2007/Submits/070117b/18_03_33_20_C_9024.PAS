uses math;
var n,i,j,k:longint;
    best:array[0..20000]of longint;
    next:array[0..10000,1..3]of longint;

begin
  assign(input,'linguae.in');
  reset(input);
  assign(output,'linguae.out');
  rewrite(output);
  read(n);
  for i:=0 to n-1 do
    for j:=1 to 3 do
      read(next[i,j]);
  for i:=1 to n do
    best[i]:=maxlongint div 2;
  best[0]:=0;
  for i:=0 to n-1 do
    for j:=max(0,i-2) to i do
      for k:=1 to 3 do
        best[min(n,j+k)]:=min(best[min(n,j+k)],best[i]+next[j,k]);
  writeln(best[n]);
  close(output);
  close(input);
end.
