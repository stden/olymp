{$O-,Q+,R+}
uses SysUtils;

const N = 15;

var a : array [1..N] of integer;
    i, t : integer;


begin
  randomize;
  for i := 1 to N do begin t := random (i) + 1; a[i] := a[t]; a[t] := i end;
  for i := 1 to N do writeln (format ('rentst %.2d %.2d %.2d', [i + 1, i + 1, a[i] + N + 1]));
  writeln (format ('rentst %.2d %.2d %.2d', [N + 1 + 1, 2 * N + 1, 1 + 1]));
end.