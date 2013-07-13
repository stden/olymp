uses dorand;
const N=239017;
var i:longint;
begin
  regint (13);
  writeln (N);
  for i:=1 to N do writeln (longrandfixd (1-maxlongint, maxlongint-1, gaussmod));
end.