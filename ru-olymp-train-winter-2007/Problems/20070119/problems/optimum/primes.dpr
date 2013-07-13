const N=10000;
var i, j:integer;
    F:array [1..N] of boolean;
begin
  for i:=2 to N do
    if not F[i] then begin
      j:=2*i;
      while j<=N do begin
        F[j]:=true;
        inc (j, i);
      end;
    end;
  for i:=2 to N do
    if not F[i] then writeln (i);
end.