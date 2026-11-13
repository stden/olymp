uses dorand;
const N=239017;
      K=717;
var i, j, z:longint;
    t:array [1..K] of longint;
begin
  regint (30);
  writeln (N);
  for i:=1 to N do writeln (lr (1, 10));
end.