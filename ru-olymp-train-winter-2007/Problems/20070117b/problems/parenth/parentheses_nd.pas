{$A+,B-,D+,E-,F-,G+,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
program macro;
const MaxN = 50; MaxD = 10;
type Long = array [0..MaxD] of integer;

procedure addl (var A, B, C : Long); {A := B + C}
var i, x, r : integer;
begin
  r := 0;
  for i := 0 to MaxD do begin
    x := r + B[i] + C[i];  r := 0;
    if x >= 10000 then begin dec (x, 10000); r:=1 end;
    A[i] := x
  end;
  if r = 1 then runerror (239)
end;

var M, M0, One, Zero    : Long;
function cmpsubl (var C : Long) : boolean;  { M0 := M - C; M0 < 0  ? }
var i, r, x : integer;
begin
  r := 0;
  for i := 0 to MaxD do begin
    x := M[i] - C[i] - r;  r := 0;
    if x < 0 then begin inc (x, 10000); r:=1 end;
    M0[i] := x
  end;
  if r = 0 then M := M0;
  cmpsubl := (r <> 0)
end;

var A        : array [-1..MaxN, -1..MaxN] of ^Long;
    St       : array [0..MaxN] of char;
    S        : string;
    N, i, j  : integer;
    C        : char;
begin
  One[0] := 1;
  for i := -1 to MaxN do
    for j := -1 to MaxN do A[i,j] := @Zero;
  A[0,0] := @One;
  for j := 1 to MaxN do
    for i := 0 to j do begin
      new (A[i,j]);
      addl (A[i,j]^, A[i-1,j]^, A[i-1,j]^);
      addl (A[i,j]^, A[i,j]^, A[i,j-1]^)
    end;
  assign (input, 'parenth.in'); reset (input);
  assign (output, 'parenth.out'); rewrite (output);
  while not seekeof do begin
    read (N); if (N = 0) then break;
    i := ord (seekeof); readln (S);
    for i := 1 to length (S) do if not (S[i] in ['0'..'9']) then runerror(239);
    if not (length(S) in [1..44]) then runerror (239);
    while length(S) < 44 do S := '0' + S;
    for i := 0 to MaxD do val(copy(S, 41-4*i, 4), M[i], j);

    i := N;  j := N;
    if (N <= 0) or (N > MaxN) or cmpsubl(One) or not cmpsubl(A[N,N]^)
    then runerror (239);
    repeat
      if cmpsubl(A[i-1,j]^) then begin C:='('; dec(i);  St[j-i]:=')' end
      else begin
        if St[j-i] = ')' then begin
          if cmpsubl(A[i,j-1]^) then begin C:=')'; dec(j) end
          else begin C:='['; dec(i); St[j-i]:=']' end
        end else begin
          if cmpsubl(A[i-1,j]^) then begin C:='['; dec(i); St[j-i]:=']' end
          else begin C:=']'; dec(j) end
        end
      end;
      write (C)
    until j = 0;
    writeln
  end
end.
