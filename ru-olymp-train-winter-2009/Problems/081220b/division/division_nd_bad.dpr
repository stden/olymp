{$I+,Q+,R+}
program macro;
const MaxL=100;

function readl : string;
var R : string; i : integer;
begin
  readln (R);  assert ((R <> '') and (length(R) <= MaxL));
  for i := 1 to length (R) do assert (R[i] in ['0'..'9']);
  readl := R;
end;

var L : array [1..MaxL*4] of string;

procedure norml (var S : string);
begin while (length(S) > 1) and (S[1] = '0') do delete (S, 1, 1) end;

function cmpl (var S, T : string) : integer;
var i : integer;
begin
  norml(S);  norml(T);  cmpl := length(S) - length(T);
  if Result <> 0 then exit;
  for i := 1 to length(S) do begin
    cmpl := ord(S[i]) - ord(T[i]);
    if Result <> 0 then exit
  end
end;

procedure subl (var S, T : string);
var i, c, v, d : integer;
begin
  norml(S);  norml(T);
  d := length(S) - length(T);  assert (d >= 0);
  c := 0;
  for i := length(T) downto 1 do begin
    v := ord(S[d+i]) - ord(T[i]) - c;
    if v < 0 then begin c := 1;  inc (v, 10) end else c := 0;
    S[d+i] := chr (48+v)
  end;
  if c > 0 then begin
    while (d > 0) and (S[d] = '0') do begin S[d] := '9';  dec (d) end;
    assert (d > 0);  dec (S[d])
  end;
  norml (S)
end;

procedure addl (var S, T : string);
var i, c, v, d : integer;
begin
  if S = '' then begin S := T;  exit end;
  d := length(S) - length(T);  assert (d >= 0);
  c := 0;
  for i := length(T) downto 1 do begin
    v := ord(S[d+i]) + ord(T[i]) + c - 96;
    if v >= 10 then begin c := 1;  dec (v, 10) end else c := 0;
    S[d+i] := chr (48+v)
  end;
  if c > 0 then begin
    while (d > 0) and (S[d] = '9') do begin S[d] := '0';  dec (d) end;
    if d > 0 then inc (S[d]) else S := '1' + S;
  end
end;

procedure putl (y, x : integer; const S : string);
var i : integer;
begin
  while length(L[y]) < x do L[y] := L[y] + ' ';
  for i := 1 to length(S) do
    L[y,x+i-length(S)] := S[i]
end;

procedure putr (y, x1, x2 : integer; C : char);
var i : integer;
begin
  while length(L[y]) < x2 do L[y] := L[y] + ' ';
  for i := x1 to x2 do L[y,i] := C
end;

var
  S, D, R, Q, E  : string;
  N, z, o, o1, oo, cu, cf, i : integer;
begin
  assign (input, 'division.in');  reset (input);
  assign (output, 'division.out');  rewrite (output);
  repeat
    S := readl;  D := readl;
    assert (D[1] > '0');  
    assert ((S = '0') or (S[1] > '0'));
    z := 1;  R := '0';  o := 0;  o1 := 0;  Q := '';  oo := 0;
    L[1] := S + ' |' + D;  L[2] := '';  L[3] := '';
    N := length(S);
    repeat
      cu := 0;
      while cmpl(R,D) < 0 do begin
        inc(o);
        if (cu > 0) and (Q <> '') then Q := Q + '0';
        if o > length(S) then break;
        o1 := o;
        R := R + S[o];  inc (cu);
      end;
      if z > 1 then begin
        putr (z - 1, oo, o1, '-');
        putl (z, o1, R)
      end;
      if o > length(S) then break;
      cf := 0;  E := '';  oo := o - length(R) + 1;
      repeat inc(cf);  subl(R,D);  addl(E,D)
      until cmpl(R,D) < 0;
      Q := Q + chr (48+cf);
      putl (z+1, o, E);
      inc (z, 3);  L[z] := '';  L[z+1] := '';  L[z+2] := '';
    until false;
    if Q = '' then Q := '0';
    putr (2, N+2, N+2, '+');
    putr (2, N+3, N+2+length(Q), '-');
    putl (3, N+2+length(Q), '|' + Q);
    if z < 3 then z := 3;
    for i := 1 to z do writeln (L[i]);
    if seekeof then break;
    writeln;  writeln
  until seekeof
end.

