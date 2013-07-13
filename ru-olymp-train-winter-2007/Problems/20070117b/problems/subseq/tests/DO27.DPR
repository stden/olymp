uses dorand;
const N=239017;
      K=100;
var i, j, z:longint;
    t:array [1..K] of longint;
begin
  regint (25);
  writeln (N);
  for j:=1 to K do t[j]:=randr (1-maxlongint, maxlongint-1);
  for i:=1 to N do begin
    z:=random (K)+1;
    t[z]:=t[z]+randr (1, 10);
    writeln (t[z]);
  end;
end.