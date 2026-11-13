uses dorand;
const MaxN=50;
      CurL=17;
var a:array [0..MaxN] of integer;
    i, j, N, L:integer;
begin
  randomize;
  N:=MaxN; L:=CurL; a[0]:=N; i:=0;
  while L>0 do begin
    inc (i);
    a[i]:=poisson (4*N/L, 1, min (a[i-1], N-L));
    dec (N, a[i]);
    dec (L);
  end;
  writeln (N);
  write (i); for j:=1 to i do write (' ', a[j]);
end.