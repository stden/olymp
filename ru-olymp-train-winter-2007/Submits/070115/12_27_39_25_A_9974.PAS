// Keep It Simple, Stupid!
var n:longint;
begin
 assign(input,'cars.in'); reset(input); readln(n); close(input);
 assign(output,'cars.out');rewrite(output); if n in [2,3] then writeln(n-1) else writeln(n); close(output);
end.
