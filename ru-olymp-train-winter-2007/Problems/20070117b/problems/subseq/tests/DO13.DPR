uses dorand;
const N=239017;
var i:longint;
begin
  regint (11);
  writeln (N);
  for i:=1 to N do writeln (randr (1-maxlongint, maxlongint-1));
end.