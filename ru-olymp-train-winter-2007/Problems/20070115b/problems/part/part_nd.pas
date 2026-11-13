{$A+,B-,D+,E-,F-,G+,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 16384,0,655360}
program macro;
const MaxTests=5000; MaxN={50}100;

var
  A   : array [0..MaxN, 0..MaxN] of longint;
  K   : longint;
  i, j, N, _: integer;
begin
  A[0,0] := 1;
  for i := 0 to MaxN do begin
    for j := 1 to i do
      A[i,j] := A[i,j-1] + A[i-j,j];
    for j := i+1 to MaxN do A[i,j]:=A[i,i]
  end;
  assign (input, 'vasya.in');  reset (input);
  assign (output, 'vasya.out');  rewrite (output);
  repeat
    read (N, K);
    if (N = 0) and (K = 0) then break;
    if (N <= 0) or (N > MaxN) or (K < 0) or (K >= A[N,N]) then runerror (239);
    inc (_); if _ > MaxTests then runerror (239);
    j := N;
    repeat
      i := j;
      while A[N,i-1] >= A[N,j] - K do dec(i);
      write (i, ' ');
      dec (K, A[N,j]-A[N,i]);
      dec (N, i);
      j := i
    until N = 0;
    if K <> 0 then runerror (239);
    writeln
  until false
end.