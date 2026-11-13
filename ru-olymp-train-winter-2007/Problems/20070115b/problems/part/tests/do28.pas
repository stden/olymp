uses dorand;
const K=5000;
      N=100;
      FN=190569292;
var i:integer;
begin
  regint (99);
  for i:=1 to K do begin
    writeln (N, ' ', lr (1, FN));
  end;
  writeln ('0 0');
end.