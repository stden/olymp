{$A+,B-,D+,E-,F-,G+,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program macro;
const MaxN = 10000;  MaxV = 10000;

var
  N, i, j, k    : integer;
  R             : longint;
  A             : array [-3..0] of longint;
  B             : array [-3..0, 1..3] of integer;
begin
  assign (input, 'linguae.in');  reset (input);
  assign (output, 'linguae.out');  rewrite (output);
  read (N);  if (N <= 0) or (N > MaxN) then runerror (239);
  fillchar (A, sizeof(A), $70);
  fillchar (B, sizeof(B), $7f);
  A[0] := 0;  R := MaxLongInt;
  for i := 1 to N+3 do begin
    for j := -3 to -1 do begin
      A[j] := A[j+1];
      for k := 1 to 3 do B[j,k] := B[j+1,k]
    end;
    if i <= N then for k := 1 to 3 do read (B[-1,k]);
    A[0] := MaxLongint;
    for j := 1 to 3 do
      for k := j to 3 do
        if A[0] > A[-j] + B[-k,k] then A[0] := A[-j] + B[-k,k];
    if (R > A[0]) and (i >= N) then R := A[0];
  end;
  writeln (R)
end.


