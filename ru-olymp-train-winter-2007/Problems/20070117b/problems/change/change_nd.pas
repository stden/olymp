{$A+,B-,D+,E-,F-,G+,I+,L+,N-,O-,P-,Q+,R+,S-,T-,V+,X+,Y+}
{$M 16384,0,655360}
program macro;
const MaxS = 200;
var
  A        : array [0..MaxS, 0..MaxS] of byte;
  B, D     : array [1..MaxS] of integer;
  C        : array [1..3] of integer;
  N, i, j, k, x, y, S  : integer;
  V, MV                : longint;
begin
  assign (input, 'change.in');  reset (input);
  assign (output, 'change.out');  rewrite (output);
  read (N);
  if (N < 0) or (N > MaxS) then runerror (239);
  fillchar (A, sizeof(A), 255);   A[0,0] := 0;
  for k := 1 to N do begin
    read (x);  if (x <= 0) or (x > MaxS) then runerror (239);
    B[k] := x;  inc (S, x);  if S > MaxS then runerror (239);
    for i := x to S do
      for j := 0 to S do
        if (A[i,j] = 255) and (A[i-x,j] < k) then A[i,j] := k;
    for i := 0 to S do
      for j := x to S do
        if (A[i,j] = 255) and (A[i,j-x] < k) then A[i,j] := k;
  end;
  MV := MaxLongInt;
  for i := 0 to S do
    for j := 0 to S do
      if A[i,j] <> 255 then begin
        k := S - i - j;
        V := sqr(longint(i)) + sqr(longint(j)) + sqr(longint(k));
        if V < MV then begin MV:=V;  x := i;  y := j end
      end;
  for k := N downto 1 do
    if A[x,y] < k then begin inc(C[3]); D[k]:=3 end else
    if (x >= B[k]) and (A[x-B[k],y] < k) then
         begin inc(C[1]);  D[k]:=1;  dec(x,B[k]) end
    else begin inc(C[2]);  D[k]:=2;  dec(y,B[k]) end;
  for k := 1 to 3 do begin
    write (C[k]);
    for i := 1 to N do if D[i] = k then write (' ', B[i]);
    writeln
  end
end.

