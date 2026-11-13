{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
program macro;

type float = extended;
     point = record x, y : float end;
     line = record A, B, C : float end;
     polygon = record N : integer; P : array [0..7] of point end;

procedure mkline (var L : line; var P, Q : point);
begin
  L.A := P.y - Q.y;
  L.B := Q.x - P.x;
  L.C := -L.A*P.x - L.B*P.y
end;

function appline (var L : line; var P : point) : float;
begin appline := L.A * P.x + L.B * P.y + L.C end;

procedure intersect (var B, A : polygon; var L : line);
var i : integer; F : boolean; v1, v2 : float; Q : point;
begin
  A.P[0] := A.P[A.N];
  B.N := 0;
  for i := 0 to A.N - 1 do begin
    v1 := appline (L, A.P[i]);
    v2 := appline (L, A.P[i+1]);
    F := false;
    if v1 >= 0 then begin
      inc (B.N);  B.P[B.N] := A.P[i];
      F := (v1 > 0) and (v2 < 0)
    end else F := (v2 > 0);
    if F then begin
      Q.x := (v2*A.P[i].x - v1*A.P[i+1].x) / (v2 - v1);
      Q.y := (v2*A.P[i].y - v1*A.P[i+1].y) / (v2 - v1);
      inc (B.N);  B.P[B.N] := Q
    end
  end
end;

function area (var A : polygon) : float;
var S : float; i : integer;
begin
  with A do begin
    P[0] := P[N];
    S := 0;
    for i := 1 to N do
      S := S + (P[i-1].x-P[i].x) * (P[i].y + P[i-1].y)
  end;
  area := S
end;


var L           : Line;
    S1, S2, S0  : float;
    i           : integer;
    P, Q        : array [1..4] of point;
    TP          : point;
    A0, A1      : polygon;
begin
  assign (input, 'union.in'); reset (input);
  assign (output, 'union.out');  rewrite (output);
  repeat
    for i := 1 to 3 do read (P[i].x, P[i].y);
    for i := 1 to 3 do read (Q[i].x, Q[i].y);
    mkline (L, P[1], P[2]);
    S1 := appline (L, P[3]);
    if S1 < 0 then begin S1 := -S1; TP:=P[1]; P[1]:=P[2]; P[2]:=TP end;
    mkline (L, Q[1], Q[2]);
    S2 := appline (L, Q[3]);
    if S2 < 0 then begin S2 := -S2; TP:=Q[1]; Q[1]:=Q[2]; Q[2]:=TP end;
    A0.N := 3;  for i := 1 to 3 do A0.P[i] := P[i];
    Q[4] := Q[1];
    for i := 1 to 3 do begin
      mkline (L, Q[i], Q[i+1]);
      intersect (A1, A0, L);
      A0 := A1
    end;
    S0 := area (A0);
    writeln ((S1+S2-S0)*0.5+1e-12:6:6)
  until seekeof
end.
