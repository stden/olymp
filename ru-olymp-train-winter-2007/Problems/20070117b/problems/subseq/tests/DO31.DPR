uses dorand;
const N=239017;
      K=717;
var i, j, z:longint;
    t:array [1..K] of longint;
begin
  regint (29);
  writeln (N);
  for i:=1 to N do writeln (lr (1, 100));
end.