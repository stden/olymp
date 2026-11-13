uses dorand;
const N=239017;
var i, t:longint;
begin
  regint (15);
  writeln (N);
  t:=randr (1-maxlongint, maxlongint-1);
  for i:=1 to N do begin
    t:=t+randr (-10000, 1000);
    writeln (t);
  end;
end.