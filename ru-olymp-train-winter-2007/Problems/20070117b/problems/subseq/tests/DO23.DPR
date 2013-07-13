uses dorand;
const N=239017;
      K=4;
var i, j, z:longint;
    t:array [1..K] of longint;
begin
  regint (21);
  writeln (N);
  for j:=1 to K do t[j]:=randr (1-maxlongint, maxlongint-1);
  for i:=1 to N do begin
    z:=random (K)+1;
    t[z]:=t[z]+randr (-1, 1000);
    writeln (t[z]);
  end;
end.